package kr.or.picsion.message.dao;

import java.util.List;

import kr.or.picsion.message.dto.Message;
import kr.or.picsion.user.dto.User;

public interface MessageDao {

	public int insertMessage(Message message);
	public int receiveMessageDel(int msgNo);		//받은사람이 메시지 삭제
	public int sendMessageDel(int msgNo);			//보낸사람이 메시지 삭제
	public List<Message> receiveMessageList(int receiveUserNo);		//받은 메시지 리스트
	public List<User> receiveMessageUserInfo(int receiveUserNo);	//받은 메시지 보낸사람 리스트
	public Message selectMessgae(int msgNo);
	public List<Message> sendMessageList(int sendUserNo);
	
	public int messageState(int msgNo);			//메시지 읽었을 때 상태 update
	
}
