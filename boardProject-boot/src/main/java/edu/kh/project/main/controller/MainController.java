package edu.kh.project.main.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@PropertySource("classpath:/config.properties")
public class MainController {
	
	@Value("${my.public.data.service.key.decode}")
	private String decodeServiceKey;
	
	@RequestMapping("/") // "/" 요청 매핑 (method 가리지 않음)
	public String mainPage() {
		
		//접두사/ 접미사 제외
		return "common/main";
	}

	@GetMapping("loginError")
	public String loginError(RedirectAttributes ra) {
		
		ra.addFlashAttribute("message","로그인 후 이용해 주세요");
		return "redirect:/";
	}
	
	/**공공데이터 서비스키 리턴하기
	 * @return
	 */
	@ResponseBody
	@GetMapping("/getServiceKey")
	public String getServiceKey() {
		return decodeServiceKey;
		
	}
	
}
