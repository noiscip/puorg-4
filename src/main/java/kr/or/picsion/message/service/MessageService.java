package kr.or.picsion.message.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.message.dao.MessageDao;
import kr.or.picsion.message.dto.Message;
import kr.or.picsion.user.dto.User;

@Service
public class MessageService {
	
	@Autowired
	private SqlSession sqlSession;
	
	//메시지 보내기 (insert)
	public int sendMessage(Message message) {
		
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		int result = messageDao.insertMessage(message);
		
		return result;
	}
	
	//받은 메시지 리스트
	public List<Message> receiveMessageList(int receiveUserNo){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<Message> receiveList = messageDao.receiveMessageList(receiveUserNo);
		
		return receiveList;
	}
	
	//받은 메시지 보낸사람 정보
	public List<User> receiveMessageInfo(int receiveUserNo){
		MessageDao messageDao =sqlSession.getMapper(MessageDao.class);
		List<User> receiveInfo = messageDao.receiveMessageUserInfo(receiveUserNo);
		
		return receiveInfo;
	}
	
}
