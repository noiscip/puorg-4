package kr.or.picsion.message.dao;

import java.util.Date;
import java.util.List;

import kr.or.picsion.message.dto.Message;
import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.message.dao 
 * @className MessageDao
 * @date 2018. 6. 4.
 */

public interface MessageDao {

	public int insertMessage(Message message);
	public List<Message> receiveMessageList(int receiveUserNo);		//받은 메시지 리스트
	public List<User> receiveMessageUserInfo(int receiveUserNo);	//받은 메시지 보낸사람 리스트
	public List<Message> sendMessageList(int sendUserNo);	//보낸 메시지 리스트
	public List<User> sendMessageUserInfo(int sendUserNo);	//보낸 메시지 받은사람 리스트
	public List<Message> selectAll(int userNo);				//모든 메시지 가져오기 (받은, 보낸)
	public List<Message> msgList(int myUserNo, int userNo);	//한 회원과 대화한 메시지 리스트 가져오기
	public Message selectMessage(int msgNo);	//msgNo로 메시지 정보 검색
	public int receiveDel(int myUserNo, int userNo);
	public int sendDel(int myUserNo, int userNo);			//회원과 주고받은 메시지 모두 삭제
	public List<Message> selectUserMsg(int userNo, String userName);	//메시지함에서 유저 검색
	
	///////////
	public int receiveMessageDel(int msgNo);		//받은사람이 메시지 삭제
	public int sendMessageDel(int msgNo);			//보낸사람이 메시지 삭제
	public List<Message> selectReceiveMsg(int receiveUserNo, String userName);		//받은 메시지 검색한 메시지 리스트
	public List<User> selectReceiveInfo(int receiveUserNo, String userName);		//받은 메시지 검색한 정보
	public List<Message> selectSendMsg(int receiveUserNo, String userName);		//보낸 메시지 검색한 메시지 리스트
	public List<User> selectSendInfo(int receiveUserNo, String userName);		//보낸 메시지 검색한 정보
	
	
	public int messageState(int msgNo);			//메시지 읽었을 때 상태 update
	public int deleteMessage(Date date);
}
