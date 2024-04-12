package com.example.newproject.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.newproject.model.dto.Member;
import com.example.newproject.model.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Transactional(rollbackFor =Exception.class)
@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService{
	
	private final MemberMapper mapper;
	

	//로그인 서비스 
	@Override
	public Member login(Member inputMember) {
		
		return mapper.login(inputMember);
	}
}
