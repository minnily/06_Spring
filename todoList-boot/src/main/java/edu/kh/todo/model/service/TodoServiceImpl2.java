package edu.kh.todo.model.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.kh.todo.model.dto.Todo2;
import edu.kh.todo.model.mapper.TodoMapper2;
import lombok.RequiredArgsConstructor;

@Transactional(rollbackFor = Exception.class)
@Service
@RequiredArgsConstructor
public class TodoServiceImpl2 implements TodoService2{

	private final TodoMapper2 mapper;

	// 할일 추가하기 
	@Override
	public int add2(Todo2 todo2) {
		
		return mapper.add2(todo2);
	}

	// 할일 목록 tbody에 조회하기
	@Override
	public List<Todo2> selectTodoList() {
		
		
		return mapper.selectTodoList();
		
	}
	
	
}
