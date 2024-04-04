package edu.kh.todo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller("student")
public class controller {
	@PostMapping("select")
	public String selectStudent(HttpServletRequest req, @ModelAttribute Student student) {
		
		req.setAttribute("stdName",student.getStdName());

		req.setAttribute("stdAge", student.getStdAge());

		req.setAttribute("stdAddress", student.getStdAddress());

		return "student/select";
	}
	
}
