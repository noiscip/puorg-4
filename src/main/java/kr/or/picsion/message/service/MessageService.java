package kr.or.picsion.message.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.message.dao.MessageDao;
import kr.or.picsion.message.dto.Message;
import kr.or.picsion.user.dto.User;

/**
 * @author Bit
 *
 */
/**
 * @author Bit
 *
 */
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
	public List<Message> selectReceiveMsg(int receiveUserNo, String userName){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<Message> receiveSelect = messageDao.selectReceiveMsg(receiveUserNo, userName);
		
		return receiveSelect;
	}
	
	//받은 메시지 검색(User 정보)
	public List<User> selectReceiveInfo(int receiveUserNo, String userName){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<User> receiveSelectInfo = messageDao.selectReceiveInfo(receiveUserNo, userName);
		
		return receiveSelectInfo;
	}
	
	//보낸 메시지 검색
	public List<Message> selectSendMsg(int receiveUserNo, String userName){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<Message> sendSelect = messageDao.selectSendMsg(receiveUserNo, userName);
		
		return sendSelect;
	}
	
	
	//보낸 메시지 검색(User 정보)
	public List<User> selectSendInfo(int receiveUserNo, String userName){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<User> sendSelectInfo = messageDao.selectSendInfo(receiveUserNo, userName);
		
		return sendSelectInfo;
	}
	
	//메시지 모두 가져오기
	public List<Message> messageAll(int userNo){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<Message> messageAll = messageDao.selectAll(userNo);
		
		return messageAll;
	}
	
	//한 회원과 주고받은 메시지 리스트 뽑아오기 6.22
	public List<Message> messageList(int myUserNo, int userNo){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<Message> messageList = messageDao.msgList(myUserNo, userNo);
		
		return messageList;
	}
	
	//메시지번호로 메시지 검색
	public Message messageInfo(int msgNo) {
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		Message msginfo= messageDao.selectMessage(msgNo);
				
		return msginfo;
	}
	
	//받은메시지 삭제(receiveMsgDel update)
	public int receiveDel(int myUserNo, int userNo) {
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		int result = messageDao.receiveDel(myUserNo, userNo);
		
		return result;
	}
	
	//보낸메시지 삭제(sendMsgDel update)
	public int sendDel(int myUserNo, int userNo) {
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		int result = messageDao.sendDel(myUserNo, userNo);
		
		return result;
	}
	
	//메시지함 유저 검색해서 메시지 리스트 가져오기
	public List<Message> selectUserMsg(int userNo, String userName){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<Message> selectUserMsg = messageDao.selectUserMsg(userNo, userName);
		
		return selectUserMsg;
	}
	
	
}
