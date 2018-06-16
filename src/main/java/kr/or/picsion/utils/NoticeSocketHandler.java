package kr.or.picsion.utils;


import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

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
		System.out.println("여기는 노티스 소켓 핸들러");
		
		String[] info = message.getPayload().split(":");
		
		int receiveUserNo = Integer.valueOf(info[1]);
	
		if(users.get(receiveUserNo) != null) {
			users.get(receiveUserNo).sendMessage(message);   
		}
		// 현재 수신자에게 몇개의 메세지가 와있는지 디비에서 검색함.

	}

	   @Override
	    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
	        System.out.println(session.getId() + " 익셉션 발생: " + exception.getMessage());
	    }

}
