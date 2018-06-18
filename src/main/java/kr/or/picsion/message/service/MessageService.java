package kr.or.picsion.message.service;

import java.util.List;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.message.dao.MessageDao;
import kr.or.picsion.message.dto.Message;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.notice.dao.NoticeDao;

@Service
public class MessageService {
	
	@Autowired
	private SqlSession sqlSession;
	
	//메시지 보내기 (insert)
	public int sendMessage(Message message) {
		
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		int result = messageDao.insertMessage(message);
		
		NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
		System.out.println(message.toString());
		
		HashMap<String, Object> noticeMap = new HashMap<String, Object>();
		
		noticeMap.put("msgNo", message.getMsgNo());
		noticeMap.put("receiveUserNo", message.getReceiveUserNo());
		noticeMap.put("sendUserNo", message.getSendUserNo());
		noticeMap.put("table", "msgNo");
		noticeMap.put("tableNo", message.getTableNo());
		System.out.println(noticeMap.keySet());
		noticeDao.insertNotice(noticeMap);
		
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
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<User> receiveInfo = messageDao.receiveMessageUserInfo(receiveUserNo);
		
		return receiveInfo;
	}
	
	//메시지  읽었을때 메시지 읽음 상황 변경
	public int messageState(int msgNo) {
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		int result = messageDao.messageState(msgNo);

		return result;
	}
	
	//받은 사람이 메시지 삭제
	public int receiveMessageDel(int msgNo) {
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		int result = messageDao.receiveMessageDel(msgNo);
		
		return result;
	}
	
	
	//보낸 메시지 리스트
	public List<Message> sendMessageList(int sendUserNo){
		MessageDao messageDao =sqlSession.getMapper(MessageDao.class);
		List<Message> sendList = messageDao.sendMessageList(sendUserNo);
		
		return sendList;
	}
	
	//보낸 메시지 받은 사람 정보
	public List<User> sendMessageInfo(int sendUserNo){
		MessageDao messageDao =sqlSession.getMapper(MessageDao.class);
		List<User> sendInfo = messageDao.sendMessageUserInfo(sendUserNo);
		
		return sendInfo;
	}
	
	//보낸 사람이 메시지 삭제
	public int sendMessageDel(int msgNo) {
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		int result = messageDao.sendMessageDel(msgNo);
		
		return result;
	}
	
	//받은 메시지 검색
	
	
	
	
	
	
	
}
