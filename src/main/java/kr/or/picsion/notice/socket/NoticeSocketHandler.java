package kr.or.picsion.notice.socket;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.picsion.HomeController;
import kr.or.picsion.message.dao.MessageDao;

public class NoticeSocketHandler extends TextWebSocketHandler {

	@Autowired
	private SqlSession sqlSession;


	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionClosed?????");
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("afterConnectionEstablished!!!!!!!");
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("여기는 노티스 소켓 핸들러");
		System.out.println(message);
		System.out.println(message.getPayload());
		System.out.println(session.getId());
		MessageDao dao = sqlSession.getMapper(MessageDao.class);

		session.sendMessage(message);   
		// 현재 수신자에게 몇개의 메세지가 와있는지 디비에서 검색함.

	}

	   @Override
	    public void handleTransportError(
	            WebSocketSession session, Throwable exception) throws Exception {
	        System.out.println(session.getId() + " 익셉션 발생: " + exception.getMessage());
	    }

}
