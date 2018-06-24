package kr.or.picsion.utils;


import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils 
 * @className NoticeSocketHandler
 * @date 2018. 6. 13.
 */

public class NoticeSocketHandler extends TextWebSocketHandler {

	private Map<Integer, WebSocketSession> users = new ConcurrentHashMap<Integer, WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession wSession) throws Exception {
		System.out.println("afterConnectionEstablished!!!!!!! 커넥션 열림??");
		
		Map<String,Object> map = wSession.getAttributes();

		int userNo = (Integer)map.get("userNo");
		
		users.put(userNo, wSession);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession wSession, CloseStatus status) throws Exception {
		Map<String,Object> map = wSession.getAttributes();

		int userNo = (Integer)map.get("userNo");
		
		users.remove(userNo);
		System.out.println("afterConnectionClosed????? 커넥션 닫힘???");
		
	}

	@Override
	protected void handleTextMessage(WebSocketSession wSession, TextMessage message) throws Exception {
		System.out.println("현재 접속되어 있는 유저");
		System.out.println(users);
		String[] info = message.getPayload().split(":");
		
		int receiveUserNo = Integer.valueOf(info[1]);
		
		if(users.get(receiveUserNo) != null) {
			System.out.println(receiveUserNo + "번한테 보냈어?");
			users.get(receiveUserNo).sendMessage(message);   
		}
	}

	   @Override
	    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
	        System.out.println(session.getId() + " Exception 발생: " + exception.getMessage());
	    }

}
