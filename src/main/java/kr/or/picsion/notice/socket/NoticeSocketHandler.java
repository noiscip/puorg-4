package kr.or.picsion.notice.socket;


import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;


public class NoticeSocketHandler extends TextWebSocketHandler {

	@Autowired
	private UserService userService;

	private Map<Integer, WebSocketSession> users = new ConcurrentHashMap<Integer, WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession wSession) throws Exception {
		System.out.println("afterConnectionEstablished!!!!!!! 커넥션 열림??");
		
		System.out.println(wSession);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionClosed????? 커넥션 닫힘???");
		
	}

	@Override
	protected void handleTextMessage(WebSocketSession wSession, TextMessage message) throws Exception {
		System.out.println("여기는 노티스 소켓 핸들러");
		
		System.out.println(message.getPayload());
		System.out.println(wSession.getId());
		String[] info = message.getPayload().split(":");
	
		System.out.println("바뀜??");
		User user =userService.userInfo(Integer.valueOf(info[0]));
		System.out.println(user.toString());
		
		wSession.sendMessage(message);   
		// 현재 수신자에게 몇개의 메세지가 와있는지 디비에서 검색함.

	}

	   @Override
	    public void handleTransportError(
	            WebSocketSession session, Throwable exception) throws Exception {
	        System.out.println(session.getId() + " 익셉션 발생: " + exception.getMessage());
	    }

}
