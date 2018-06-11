package kr.or.picsion.message.dao;

import java.util.List;

import kr.or.picsion.message.dto.Message;

public interface MessageDao {

	public int insertMessage(Message message);
	public int deleteMessage(int msgNo);
	public List<Message> receiveMessageList(int receiveUserNo);
	public Message selectMessgae(int msgNo);
	public List<Message> sendMessageList(int sendUserNo);
	
}
