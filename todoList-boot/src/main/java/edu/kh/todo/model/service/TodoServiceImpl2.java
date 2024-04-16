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

	private final TodoMapper2 mapper2;

	@Override
	public List<Todo2> add(String todoTitle, String todoContent) {
		
		return mapper2.add(todoTitle, todoContent);
	}
	
	
}
