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
		Map<String,Object> map = wSession.getAttributes();

		int userNo = (Integer)map.get("userNo");
		
		users.put(userNo, wSession);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession wSession, CloseStatus status) throws Exception {
		Map<String,Object> map = wSession.getAttributes();

		int userNo = (Integer)map.get("userNo");
		
		users.remove(userNo);
	}

	@Override
	protected void handleTextMessage(WebSocketSession wSession, TextMessage message) throws Exception {
		String[] info = message.getPayload().split(":");
		int receiveUserNo = Integer.valueOf(info[1]);
		if(users.get(receiveUserNo) != null) {
			users.get(receiveUserNo).sendMessage(message);   
		}
	}

	   @Override
	    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
	        System.out.println(session.getId() + " Exception 발생: " + exception.getMessage());
	    }

}
