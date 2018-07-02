package kr.or.picsion.message.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.message.dao.MessageDao;
import kr.or.picsion.message.dto.Message;

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
	
	/**
	* 날      짜 : 2018. 6. 12.
	* 메소드명 : sendMessage
	* 작성자명 : 박주원
	* 기      능 : 메시지 보내기 (insert)
	*
	* @param message
	* @return Integer
	*/
	public int sendMessage(Message message) {
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		int result = messageDao.insertMessage(message);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 6. 21.
	* 메소드명 : receiveMessageList
	* 작성자명 : 박주원
	* 기      능 : 받은 메시지 리스트
	*
	* @param receiveUserNo
	* @return List<Message>
	*/
	public List<Message> receiveMessageList(int receiveUserNo){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<Message> receiveList = messageDao.receiveMessageList(receiveUserNo);
		
		return receiveList;
	}
	
	/**
	* 날      짜 : 2018. 6. 21.
	* 메소드명 : messageAll
	* 작성자명 : 박주원
	* 기      능 : 메시지 모두 가져오기
	*
	* @param userNo
	* @return List<Message>
	*/
	public List<Message> messageAll(int userNo){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<Message> messageAll = messageDao.selectAll(userNo);
		
		return messageAll;
	}
	
	/**
	* 날      짜 : 2018. 6. 22.
	* 메소드명 : messageList
	* 작성자명 : 박주원
	* 기      능 : 한 회원과 주고받은 메시지 리스트 뽑아오기
	*
	* @param myUserNo
	* @param userNo
	* @return List<Message>
	*/
	public List<Message> messageList(int myUserNo, int userNo){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<Message> messageList = messageDao.msgList(myUserNo, userNo);
		
		return messageList;
	}
	
	/**
	* 날      짜 : 2018. 6. 24.
	* 메소드명 : messageInfo
	* 작성자명 : 박주원
	* 기      능 : 메시지번호로 메시지 검색
	*
	* @param msgNo
	* @return Message
	*/
	public Message messageInfo(int msgNo) {
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		Message msginfo= messageDao.selectMessage(msgNo);
				
		return msginfo;
	}
	
	/**
	* 날      짜 : 2018. 6. 27.
	* 메소드명 : receiveDel
	* 작성자명 : 박주원
	* 기      능 : 받은메시지 삭제(receiveMsgDel update)
	*
	* @param myUserNo
	* @param userNo
	* @return Integer
	*/
	public int receiveDel(int myUserNo, int userNo) {
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		int result = messageDao.receiveDel(myUserNo, userNo);
		
		return result;
	}
	
	/**
	* 날      짜 : 2018. 6. 27.
	* 메소드명 : sendDel
	* 작성자명 : 박주원
	* 기      능 : 보낸메시지 삭제(sendMsgDel update)
	*
	* @param myUserNo
	* @param userNo
	* @return Integer
	*/
	public int sendDel(int myUserNo, int userNo) {
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		int result = messageDao.sendDel(myUserNo, userNo);
		
		return result;
	}
	
	/**
	* 날      짜 : 2018. 6. 28.
	* 메소드명 : selectUserMsg
	* 작성자명 : 박주원
	* 기      능 : 메시지함 유저 검색해서 메시지 리스트 가져오기
	*
	* @param userNo
	* @param userName
	* @return List<Message>
	*/
	public List<Message> selectUserMsg(int userNo, String userName){
		MessageDao messageDao = sqlSession.getMapper(MessageDao.class);
		List<Message> selectUserMsg = messageDao.selectUserMsg(userNo, userName);
		
		return selectUserMsg;
	}
	
	
}
