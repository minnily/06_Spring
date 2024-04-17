package edu.kh.todo.model.service;

import java.util.List;

import edu.kh.todo.model.dto.Todo2;

public interface TodoService2 {

	int add2(Todo2 todo2);

	List<Todo2> selectTodoList();

	
}
