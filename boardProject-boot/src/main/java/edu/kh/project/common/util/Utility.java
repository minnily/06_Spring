package edu.kh.project.common.util;

import java.text.SimpleDateFormat;

// 프로그램 전체적으로 사용될 우용한 기능 모음
public class Utility {

	
	public static int seqNum =1; // 1~9999
	
	
	public static String fileRename(String originalFileName){
	
		
		//SimpleDateFormat : 시간을 원하는 형태의 문자열로 간단히 변경
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHss");
		
		// new java.util.Date() : 현재 시간을 저장한 자바 객체
		String date = sdf.format(new java.util.Date());
		
		String number = String.format("%05d",seqNum);
		
		seqNum++; // 1증가
		if(seqNum == 100000) seqNum = 1;
		
		// 확장자 
		// "문자열".substring(인덱스)
		// - 문자열을 인덱스부터 끝까지 잘라낸 결과를 반환
		
		// "문자열".lastIndexOf(".")
		// - 문자열에서 마지막 "."의 인덱스를 반환
		String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		// originalFileName == 뚱이.jpg
		//.jpg
		
		return date + "_" + number + ext;
	}
}
