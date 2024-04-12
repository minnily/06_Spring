package com.example.newproject.model.service;

import com.example.newproject.model.dto.Member;

public interface MemberService {

	/** 로그인 서비스
	 * @param inputMember
	 * @return 
	 */
	Member login(Member inputMember);

	
}
