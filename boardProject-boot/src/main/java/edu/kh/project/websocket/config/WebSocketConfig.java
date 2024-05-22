package edu.kh.project.websocket.config;

import java.rmi.registry.Registry;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.HandshakeInterceptor;

import edu.kh.project.websocket.handler.ChattingWebsocketHandler;
import edu.kh.project.websocket.handler.TestWebsocketHandler;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Configuration // 서버 실행 시 작성된 메서드를 모두 수행할 수 있게 하는 어노테이션
@EnableWebSocket // 웹소켓 활성화 설정
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer{
	
	// bean 으로 등록한 것을 사용할 수 있게 의존성 주입하기
	
	//Bean으로 등록된 SessionHandShakeInterceptor가 주인됨.
	private final HandshakeInterceptor handshakeInterceptor;
	
	// 웹소켓 처리 동작이 작성된 객체 의존성 주입
	private final TestWebsocketHandler testWebsocketHandler;
	
	// 채팅관련 웹소켓 처리 동작이 작성된 객체 의존성 주입
	private final ChattingWebsocketHandler chattingWebsocketHandler;
	
	// 웹소켓 핸들러를 등록하는 메서드
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// addHandler(웹소켓 핸들러, 웹소켓 요청 주소)
		
		registry.addHandler(testWebsocketHandler, "/testSock")
		// ws:// localhost/testSock으로 클라이언트가 요청을 하먼
		// testWebsocketHandler가 처리하도록 등록
		.addInterceptors(handshakeInterceptor)
		// 클라이언트 연결 시 HttpSession을 가로채 핸들러에게 전달
		.setAllowedOriginPatterns("http://localhost/","http://127,0,0.1/","http://192.168.50.254/")
		// 웹소켓 요청이 허용되는 ip/도메인 지정
		.withSockJS();
		//SockJS 지원
		
		
		////-------------------------------------------------------
		
		registry.addHandler(chattingWebsocketHandler, "/chattingSock")
		.addInterceptors(handshakeInterceptor)
		.setAllowedOriginPatterns("http://localhost/","http://127,0,0.1/","http://192.168.50.254/")
		.withSockJS();
		
	}
}
