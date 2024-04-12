package com.example.newproject.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.newproject.model.dto.Member;
import com.example.newproject.model.service.MemberService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@SessionAttributes("loginMember")
@Controller
@RequestMapping("member")
@RequiredArgsConstructor
public class MemberController {

	
	private final MemberService service;
	
	@GetMapping("login")
	public String login() {
		
		
	
		return "common/login";
	}
	
	
}
