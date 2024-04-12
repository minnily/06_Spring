package edu.kh.project.email.model.service;

import java.util.Map;

public interface EmailService {

	String sendEmail(String string, String email);

	/**이메일 인증번호 확인
	 * @param map
	 * @return count
	 */
	int checkAuthKey(Map<String, Object> map);

}
