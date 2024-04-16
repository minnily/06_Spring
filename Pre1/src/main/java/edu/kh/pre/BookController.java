package edu.kh.pre;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
@Controller
@RequiredArgsConstructor
@ResponseBody
@RequestMapping("book")
public class BookController {

	
		private final BookService service;

			@GetMapping("selectAllList")
			public List<Book> selectAllList(String book) {

				return service.selectAllList();

			

	}
	
}
