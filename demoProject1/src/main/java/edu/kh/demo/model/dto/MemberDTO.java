package edu.kh.demo.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// Lombok : 자주 사용하는 코드를 컴파일 시 자동 완성 해주는 라이브러리
//-> DTO(기본생성자, getter/setter,toString) + Log

@Getter // Getter 자동완성
@Setter //Setter 자동완성
@NoArgsConstructor // 기본생성자 자동완성
@AllArgsConstructor //매개변수 생성자 자동완성
@ToString
public class MemberDTO {

	
	private String memberId;
	private String memberPw;
	private String memberName;
	private int memberAge;
}
