package com.example.newproject.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.newproject.model.dto.Member;

@Mapper
public interface MemberMapper {

	Member login(Member inputMember);

}
