package edu.kh.todo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kh.todo.model.dto.Todo;
import edu.kh.todo.model.service.TodoService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("ajax")
@Controller // 요청 / 응답 제어 역할 명시 + Bean 등록
public class AjaxController {

	//@Autowired
	//- 등록된 Bean 중 같은 타입 또는 상속관계인 Bean을 해당 필드에 의존성 주입(DI)
	
	@Autowired
	private TodoService service;
	
	
	@GetMapping("main") //ajax/main GET 요청 매핑
	public String ajaxMain() {
		
		// 접두사 : classpath:templates/
		// 접미사 : .html
		return "ajax/main";
	}
	
	// 전체 Todo 개수 조회
	// 원래 Spring 에서 return 값이 forward/ redirect만 들어가야하는데,
	// 비동기화 인 경우 @ResponseBody 를 붙인다면 값 그대로 호출한 곳에 돌려보내주는 역할을 한다.
	
	/* 다시한번 더 정리하자면
	 * @ResponseBody
	 * - 컨트롤러 메서드의 반환값을 HTTP 응답 본문에 직접 바인딩하는 역할임을 명시
	 * 
	 * 즉, 컨트롤러 메서드의 반환값을 비동기 요청했던 HTML/JS 파일 부분에 값을 돌려보낼 것이다를 명시 !
	 * 그래서 더이상 return 값을 forward/redirect로 인식하는 것이 아니다!
	 * 
	 * @RequestBody
	 *  - 비동기 요청(ajax) 시 전달되는 데이터 중 body 부분에 포함된 요청 데이터를 
	 *  알맞은 Java 객체 타입으로 바인딩 하는 어노테이션
	 *  
	 *  - 비동기 요청 시 body에 담긴 값을 알맞은 타입으로 변환해서 매개변수에 저장
	 *  
	 *  [HttpMessageConverter]
	 *  Spring에서 비동기 통신 시 
	 * - 전달되는 데이터의 자료형
	 * - 응답하는 데이터의 자료형
	 * 위 두가지를 알맞은 형태로 가공(변환) 해주는 객체
	 * 
	 * - 문자열, 숫자 <-> TEXT
	 * - DTO <-> JSON
	 * - Map <-> JSON 
	 * 
	 * (참고) 
	 * HttpMessageConverter가 동작하기 위해서는
	 * Jackson-data-bind 하이브러리가 필요한데
	 * Spring Boot 모듈에 내장되어 있음
	 * (Jackson : 자바에서 JSON 다루는 방법을 제공하는 라이브러리)
	 	
	 * */
	
	
	
	@ResponseBody // 비동기 요청으로 값자체를 반환할 것이다.
	@GetMapping("totalCount")
	public int getTotalCount() {
		
		// 전체 할 일 개수 조회 서비스 호출 및 응답
		int totalCount = service.getTotalCount();
		
		return totalCount;
	}
	
	@ResponseBody
	@GetMapping("completeCount")
	public int getCompleteCount() {
		return service.getCompleteConunt();
	}
	
	@ResponseBody
	@PostMapping("add")
	public int addTodo(
			// JSON이 파라미터로 전달된 경우 @RequestParam과 같은 방법으로 얻어오기는 불가능!
			
			@RequestBody Todo todo // 요청 body에 담긴 값을 Todo에 저장
			) {
		log.debug(todo.toString());
		
		return service.addTodo(todo.getTodoTitle(),todo.getTodoContent());
	}
	
	@ResponseBody //값 자체를 호출한 쪽으로 돌려보낼때 사용!!! 현재 값 자체를 호출한 쪽으로 돌려보내야하기에 사용
	@GetMapping("selectList")
	public List<Todo> selectList() {
		List<Todo> todoList = service.selectList();
		
		//selectAll은 완료된 객체까지 가져오는 메서드이기에 이용하기에 어려워 selectList 메서드 만들어서 할일 목록만 나타나게 만들것임!@
		
		return todoList;
		
		//List(Java 전용 타입) 을 반환한다고 했지만 , 원래는 JS가 인식할 수 없기 때문에 HttpMessageConverter가 
		//JSON으로 형태를 변환하여 반환해줄 것임. 
		// -> [{},{},{}] JSONArray => JSON 형태의 배열
	}
	
	@ResponseBody
	@GetMapping("detail")
	public Todo selectTodo(@RequestParam ("todoNo") int todoNo) {
		
		
		// return 자료형 : Todo
		// -> HttpMessageConverter가 String (JSON) 형태로 변환해서 반환		
		return  service.todoDetail(todoNo);
		
	}
	
	//Delete 방식 요청 처리(비동기식만 가능)
	@ResponseBody
	@DeleteMapping("delete") //Delete방식 요청 처리 (비동기 요청만 가능하다!)
	public int todoDelete(@RequestBody int todoNo) {
		
		return service.todoDelete(todoNo);
		
	}
	
	// 완료 여부 변경
	@ResponseBody
	@PutMapping("changeComplete")
	public int changeComplete(@RequestBody Todo todo) {
		return service.changeComplete(todo);
	
	}
	
	// 할 일 수정
	@ResponseBody
	@PutMapping("update")
	public int todoUpdate(@RequestBody Todo todo) {
		return service.todoUpdate(todo);
				
	}
}
