package edu.kh.project.websocket.interceptor;

import java.util.Map;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import jakarta.servlet.http.HttpSession;

/** SessionHandshakeInterceptor 클래스
 * 
 * WebSocketHandler가 동작하기 전/ 후에 
 * 연결된 클라이언트 세션을 가로채는 동작을 작성할 클래스 
 * 
 */
// ▼웹소켓 설정할 때 필요한곳에 적절히 주입되서 이용이되려면 꼭 Bean으로 등록되어 있어야 하기에!
// "@Component" 어노테이션을 꼭 작성해줘야 한다.
@Component //Bean등록
public class SessionHandshakeInterceptor implements HandshakeInterceptor{
	
	// 핸들러 동작 전에 수행되는 메서드
	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		 // ServerHttpRequest : HttpServletRequest 의 부모 인터페이스
		 // ServerHttpResponse : HttpServletResponse 의 부모 인터페이스
		
		// attributes : 해당 맵에 세팅된 속성(데이터)은 다음에 동작할 Handler 객체에 전달됨.
		//				(HandshakeInterceptor -> Handler 데이터 전달하는 역할)
		
		// Session을 뽑아오려면 다운캐스팅을 해야하는데 다운캐스팅 시 여러가지 예외 발생함 그래서 예외 처리 해야함
		// 즉, request가 참고하는 객체가 ServletServerHttpRequest로 다운캐스팅이 가능한가?를 묻는 조건문 작성
		if(request instanceof ServletServerHttpRequest) {
			
			//다운 캐스팅
			ServletServerHttpRequest servletRequest =(ServletServerHttpRequest)request;
			
			//웹소켓 동작을 요청한 클라이언트의 세션을 얻어옴
			HttpSession session = servletRequest.getServletRequest().getSession();
			
			// 가로챈 세션을 Handler에 전달할 수 있게 값 세팅
			attributes.put("session",session);
		}
		
		return true; // 가로채기 진행 여부 true-> ture로 작성해야 세션을 가로채서 Handler에게 전달 가능
	}
	
	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception exception) {
		
		
	}
	
}
