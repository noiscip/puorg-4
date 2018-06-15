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
		super.afterConnectionEstablished(wSession);
		System.out.println("afterConnectionEstablished!!!!!!! 커넥션 열림??");
		System.out.println("wSession ::: " + wSession);
		
		Map<String,Object> map = wSession.getAttributes();
		System.out.println("map ::: " + map);

		int userNo = (Integer)map.get("userNo");
		System.out.println("userNo ::: " + userNo);
		
		System.out.println("여기까지가 커넥션 열림부분");
		
		users.put(userNo, wSession);
		System.out.println(users.keySet());
		System.out.println(users.values());
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession wSession, CloseStatus status) throws Exception {
		Map<String,Object> map = wSession.getAttributes();
		System.out.println("map ::: " + map);

		int userNo = (Integer)map.get("userNo");
		System.out.println("userNo ::: " + userNo);
		
		users.remove(userNo);
		System.out.println("닫히는부분");
		System.out.println("afterConnectionClosed????? 커넥션 닫힘???");
		
	}

	@Override
	protected void handleTextMessage(WebSocketSession wSession, TextMessage message) throws Exception {
		System.out.println("여기는 노티스 소켓 핸들러");
		
		System.out.println(message.getPayload());
		System.out.println(wSession.getId());
		String[] info = message.getPayload().split(":");
	
		User user = userService.userInfo(Integer.valueOf(info[0]));
		
		System.out.println(user.toString());
		
		System.out.println(users.values());
		
		for(WebSocketSession s : users.values()) {
			
			System.out.println("하하 : " + s);
			s.sendMessage(message);   
		}
		// 현재 수신자에게 몇개의 메세지가 와있는지 디비에서 검색함.

	}

	   @Override
	    public void handleTransportError(
	            WebSocketSession session, Throwable exception) throws Exception {
	        System.out.println(session.getId() + " 익셉션 발생: " + exception.getMessage());
	    }

}
