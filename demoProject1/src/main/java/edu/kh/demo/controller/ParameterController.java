package edu.kh.demo.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.kh.demo.model.dto.MemberDTO;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

// Bean : 스프링이 만들고 관리하는 객체

@Controller // 요청/응답 제어 역할 명시 + Bean 등록
@RequestMapping("param")// /param 으로 시작하는 모든 요청을 현재 컨트롤러로 매핑될 수 있게끔 해주는 것
@Slf4j // log를 이용한 메세지 출력 시 사용 (Lombok  제공)
public class ParameterController {
	
	@GetMapping("main") //  /param/main GET 방식 요청 매핑
	public String paramMain() {
		
		// classpath: src/main/resource
		// 접두사 : classpath :/templates/
		// 접미사 : .html
		// -> src/main/resource/templates/param/param-main.html
		return "param/param-main";
	}
	
	/* 1. HttpServleRequest.getParameter("key") 이용
	 * 
	 * HttpServleRequest : 
	 * - 요청 클라이언트 정보, 제출된 파라미터 등을 저장한 객체
	 * - 클라이언트 요청 시 생성 
	 * 
	 * 
	 * ArgumentResolver(전달 인자 해결사)
	 * - Spring의 Controller 메서드 작성 시
	 * 매개변수에 원하는 객체를 작성하면
	 * 존재하는 객체를 바인딩 또는 없으면 생성해서 바인딩 
	 * 
	 * 
	 * */
	
	
	@PostMapping("test1") // /param/test1 POST 방식 요청 매핑
	public String paramTest1(HttpServletRequest req) {
		
		String inputName = req.getParameter("inputName");
		String inputAddress = req.getParameter("inputAddress");
		int inputAge = Integer.parseInt(req.getParameter("inputAge")); 
		// 넘어올때 무조건 String 형태이기에 int인경우 오류발생 
		// 따라서, Integer를 사용하여 형변환을 해주면 됨.
		
		// debug : 코드 오류 해결 
		// -> 코드 오류는 없는데 정상 수행이 안될 때
		// -> 값이 잘못된 경우 -> 값 추적
		log.debug("inputName : " + inputName);
		log.debug("inputAddress : " + inputAddress);
		log.debug("inputAge : " + inputAge);
		
		
		/* Spring에서 Redirect(재요청) 하는 방법!
		 * 
		 * - Controller 메서드 반환 값에
		 * 		"redirect: 요청주소"; 작성
		 * 
		 * 
		 * */
		
		return "redirect:/param/main";
	}
	
	/*
	 * 2. @RequestParam 어노테이션을 이용 - 낱개 파라미터 얻어오기
	 * 
	 * - request 객체를 이용한 파라미터 전달 어노테이션
	 * - 매개변수 앞에 해당 어노테이션을 작성하면, 매개변수에 값이 주입됨.
	 * - 주입되는 데이터는 매개변수의 타입에 맞게 형변환/파싱이 자동으로 수행됨.
	 * 
	 * [기본 작성법]
	 * @RequestParam("key") 자료형 매개변수명 
	 * 
	 * 
	 * [속성 추가 작성법]
	 * @ RequestParam(value="name", required="false", defaultValue="1")
	 * 
	 * value : 전달받은 input태그의 name 속성값
	 * 
	 * required : 입력된 name 속성값 파라미터 필수 여부 지정(기본값 true)
	 * -> required = true인 파라미터가 존재하지 않는다면 400 Bad Request 에러 발생
	 * 기본값으로 작성할 경우는 무조건 required가 true!!!! 기억하기!!!!
	 * 
	 * 
	 * defaultValue : 파라미터 중 일치하는 name 속성값이 없을 경우 대입할 값 지정.
	 * -> required=false 인 경우 사용
	 * 
	 * 
	 * */
	@PostMapping("test2")
	public String paramTest2(@RequestParam("title") String title, 
							 @RequestParam("writer") String writer,
							 @RequestParam("price") int price,
							 @RequestParam(value="publisher", required=false, defaultValue="ABC출판사") String publisher) {
		
		log.debug("title : " + title);
		log.debug("writer : " + writer);
		log.debug("price : " + price);
		log.debug("publisher : " + publisher);
		
		
		
		
		return "redirect:/param/main";
	}
	
	/* @RequestParam 여러 개 파라미터
	 * 
	 * String[]
	 * List<자료형>
	 * Map<String,Object>
	 * 
	 * 
	 * 
	 * 주의할점 : 
	 * required 속성은 사용 가능하나, defaultValue 속성은 사용 불가함.
	 * 
	 * */
	@PostMapping("test3")
	public String paramTest3(
			@RequestParam(value="color", required=false) String[] colorArr,
			@RequestParam(value="fruit", required=false) List<String> fruitList,
			@RequestParam Map<String, Object> paramMap
			) {
		
		log.debug("colorArr : " + Arrays.toString(colorArr));
		
		log.debug("fruitList : " + fruitList);
		
		log.debug("paramMap : " + paramMap);
		
		
		//@RequestParam Map<String, Object>
		//-> 제출된 모든 파라미터가 Map에 저장된다
		// -> 단, key(name 속성값)이 중복되면 처음 들어온 값 하나만 저장된다.
		//-> 같은 name 속성 파라미터 String[],List로 저장x
		return "redirect:/param/main";
		
	}
	
	
	/*  **@ModelAttribute를 이용한 파라미터 얻어오기 **
	 * 
	 * @ModelAttribute
	 * - DTO(또는 VO)와 같이 사용하는 어노테이션 
	 * 
	 * 전달 받은 파라미터의 name 속성 값이 같이 사용되는 DTO의 필드명과 같으면
	 * 자동으로 Setter를 호출해서 필드에 값을 세팅
	 * 
	 * 
	 * 
	 * ****@ModelAttribute를 이용해 값이 필드에 세팅된 객체를 "커맨드 객체"라고 부른다***
	 * 
	 * ****@ModelAttribute 사용 시 주의사항****
	 * -DTO에 기본생성자 setter 가 필수로 존재해야한다
	 * 
	 * *****@ModelAttribute 어노테이션은 생략이 가능하다****
	 * */
	
	@PostMapping("test4")
	public String paramTest4(/*@ModelAttribute*/ MemberDTO inputMember) {
		
		log.debug("inputMember : " + inputMember.toString());
		return "redirect:/param/main";
	}
}
