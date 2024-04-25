package edu.kh.project.board.model.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import edu.kh.project.board.model.dto.Board;
import edu.kh.project.board.model.dto.BoardImg;
import edu.kh.project.board.model.exception.BoardInsertException;
import edu.kh.project.board.model.mapper.EditBoardMapper;
import edu.kh.project.common.util.Utility;
import lombok.RequiredArgsConstructor;

@Service
@Transactional(rollbackFor = Exception.class)
@RequiredArgsConstructor
@PropertySource("classpath:/config.properties")
public class EditBoardServiceImpl implements EditBoardService{

	private final EditBoardMapper mapper;
	
	
	// config.properties 값을 얻어와 필드에 저장
	@Value("${my.board.web-path}")
	private String webPath; // /images/board/
	
	@Value("${my.board.folder-path}")
	private String folderPath; // C:/uploadFiles/board/
	

	// 게시글 작성
	@Override
	public int boardInsert(Board inputBoard, List<MultipartFile> images) throws IllegalStateException, IOException {
		
		// 1. 게시글 부분 먼저 
		// BOARD 테이블 INSERT 하기
		// -> INSERT 결과로 작성된 게시글 번호(생성된 시퀀스 번호) 반환 받기
		int result = mapper.boardInsert(inputBoard);
		
		// result == INSERT 결과 (0/1)
		
		// 삽입 실패 시 
		if(result == 0) return 0;
		
		//삽입된 게시글의 번호를 변수로 저장
		// -> mapper.xml에서 <selectKey> 태그를 이용해서 생성된 boardNo가 inputBoard에 저장된 상태!
		//(얕은 복사 개념 이해 필수)
		int boardNo = inputBoard.getBoardNo();
		
		// 2. 업로드된 이미지가 실제로 존재할 경우
		// 업로드된 이미지만 별도로 저장하여 
		// "BOARD_IMG"  테이블에 삽입하는 코드 작성
		
		// 실제 업로드된 이미지의 정보를 모아둘 List 생성
		List<BoardImg> uploadList = new ArrayList<>();
		
		// images 리스트에서 하나씩 꺼내어 선택된 파일이 있는지 검사
		for(int i=0; i< images.size(); i++) {
			
			// 실제로 선택된 파일이 존재하는 경우 
			if(!images.get(i).isEmpty()) {
				
				// 원본명 꺼내오기
				String originalName = images.get(i).getOriginalFilename();
				
				// 변경명 만들기
				String rename = Utility.fileRename(originalName); //2024~_난수
				
				// IMG_ORDER == i (인덱스 == 순서)
				
				// 모든 값을 저장할 DTO 생성(BoardImg - Builder 패턴 사용)
				BoardImg img = BoardImg.builder().imgOriginalName(originalName)
						.imgRename(rename).imgPath(webPath).boardNo(boardNo)
						.imgOrder(i).uploadFile(images.get(i)).build();
				
				uploadList.add(img);
			}
		}
		
		// 선택한 파일이 없을 경우
		if(uploadList.isEmpty()) {
			return boardNo;
		}
		
		// 선책한 파일이 존재할 경우
		// -> BORD_IMG 테이블에 INSERT +서버에 파일 저장
		
		// result == 삽입된 행의 개수 == uploadList.size()
		result = mapper.insertUploadList(uploadList);
		
		// 다중 INSERT 성공했는지 확인 
		//(uploadList에 저장된 값이 모두 정상 삽입이 되었는지? 5개가 다 들어갔으면 o ), 하나라도 안들어갔으면 rollback
		if(result == uploadList.size()) {
			//성공했다면 서버에 파일 저장
			for(BoardImg img :uploadList) {
				img.getUploadFile().transferTo(new File(folderPath+img.getImgRename()));
			}
			
		// 5개 중 하나라도 안들어갔을 경우  == 부분적으로 삽입이 실패한경우	
		//=> 이전에 삽입된 내용 모두 rollback
		}else {
			// rollback 하는 방법은? 상단에 @Transactional을 적어놨기에 RuntimeException을 강제 발생시키면 된다. 
			// (@Transactional 에 의해 rollback이 발생됨)
			throw new BoardInsertException("이미지가 정상 삽입되지 않음");
			
		}
		
		
		return boardNo;
	}
}
