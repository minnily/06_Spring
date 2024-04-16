package edu.kh.todo.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.kh.todo.model.dto.Todo2;

@Mapper
public interface TodoMapper2 {

	List<Todo2> add(String todoTitle, String todoContent);

	
}
