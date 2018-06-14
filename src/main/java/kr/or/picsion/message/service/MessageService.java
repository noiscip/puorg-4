package kr.or.picsion.message.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.message.dao.MessageDao;
import kr.or.picsion.message.dto.Message;
import kr.or.picsion.notice.dao.NoticeDao;

@Service
public class MessageService {
	
	@Autowired
	private SqlSession sqlSession;
	
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
	
}
