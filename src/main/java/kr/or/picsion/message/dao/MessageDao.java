package kr.or.picsion.message.dao;

import java.util.List;

import kr.or.picsion.message.dto.Message;
import kr.or.picsion.user.dto.User;

public interface MessageDao {

	public int insertMessage(Message message);
	public int deleteMessage(int msgNo);
	public List<Message> receiveMessageList(int receiveUserNo);		//받은 메시지 리스트
	public List<User> receiveMessageUserInfo(int receiveUserNo);	//받은 메시지 보낸사람 리스트
	public Message selectMessgae(int msgNo);
	public List<Message> sendMessageList(int sendUserNo);
	
}
