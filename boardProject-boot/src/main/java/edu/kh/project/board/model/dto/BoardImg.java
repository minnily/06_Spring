package edu.kh.project.board.model.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class BoardImg {

	private int imgNo; // 이미지 번호
	private String imgPath; // /image/board/
	private String imgOriginalName;
	private String imgRename; 
	private int imgOrder; //이미지순서
	private int boardNo;
	
	// 게시글 이미지 삽입/ 수정 때 사용
	private MultipartFile uploadFile;
}
