package kr.or.picsion.message.dto;

import java.util.Date;
import java.util.List;

import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.message.dto 
 * @className Message
 * @date 2018. 6. 4.
 */

public class Message {

	private int msgNo;
	private String msgContent;
	private Date msgReg;
	private String msgState;
	private String sendMsgDel;
	private String receiveMsgDel;
	private int sendUserNo;
	private int receiveUserNo;
	private int tableNo;
	private List<User> user;
	
	public Message() {}

	public Message(int msgNo, String msgContent, Date msgReg, String msgState, String sendMsgDel, String receiveMsgDel,
			int sendUserNo, int receiveUserNo, int tableNo, List<User> user) {
		super();
		this.msgNo = msgNo;
		this.msgContent = msgContent;
		this.msgReg = msgReg;
		this.msgState = msgState;
		this.sendMsgDel = sendMsgDel;
		this.receiveMsgDel = receiveMsgDel;
		this.sendUserNo = sendUserNo;
		this.receiveUserNo = receiveUserNo;
		this.tableNo = tableNo;
		this.user = user;
	}


	public String getSendMsgDel() {
		return sendMsgDel;
	}

	public void setSendMsgDel(String sendMsgDel) {
		this.sendMsgDel = sendMsgDel;
	}

	public String getReceiveMsgDel() {
		return receiveMsgDel;
	}

	public void setReceiveMsgDel(String receiveMsgDel) {
		this.receiveMsgDel = receiveMsgDel;
	}

	public int getMsgNo() {
		return msgNo;
	}

	public void setMsgNo(int msgNo) {
		this.msgNo = msgNo;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	public Date getMsgReg() {
		return msgReg;
	}

	public void setMsgReg(Date msgReg) {
		this.msgReg = msgReg;
	}

	public String getMsgState() {
		return msgState;
	}

	public void setMsgState(String msgState) {
		this.msgState = msgState;
	}

	public int getSendUserNo() {
		return sendUserNo;
	}

	public void setSendUserNo(int sendUserNo) {
		this.sendUserNo = sendUserNo;
	}

	public int getReceiveUserNo() {
		return receiveUserNo;
	}

	public void setReceiveUserNo(int receiveUserNo) {
		this.receiveUserNo = receiveUserNo;
	}

	public int getTableNo() {
		return tableNo;
	}

	public void setTableNo(int tableNo) {
		this.tableNo = tableNo;
	}

	public List<User> getUser() {
		return user;
	}

	public void setUser(List<User> user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Message [msgNo=" + msgNo + ", msgContent=" + msgContent + ", msgReg=" + msgReg + ", msgState="
				+ msgState + ", sendMsgDel=" + sendMsgDel + ", receiveMsgDel=" + receiveMsgDel + ", sendUserNo="
				+ sendUserNo + ", receiveUserNo=" + receiveUserNo + ", tableNo=" + tableNo + ", user=" + user + "]";
	}



	
}
