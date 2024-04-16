package edu.kh.todo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.kh.todo.model.dto.Todo2;
import edu.kh.todo.model.service.TodoService2;
import lombok.RequiredArgsConstructor;

@RequestMapping("ajax")
@Controller
@RequiredArgsConstructor
public class AjaxController2 {
	
	private final TodoService2 service2;
	
	@GetMapping("main2")
	public String ajaxMain() {
		
		return "ajax/main2";
	}
	
	@ResponseBody
	@PostMapping("add")
	public List<Todo2> add(@RequestBody Todo2 todo2 ){
		
		return service2.add(todo2.getTodoTitle(), todo2.getTodoContent());
	}
}