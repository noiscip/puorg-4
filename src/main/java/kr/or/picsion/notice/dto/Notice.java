package kr.or.picsion.notice.dto;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.notice.dto 
 * @className Notice
 * @date 2018. 6. 14.
 */

public class Notice {

	private int noticeNo;
	private String readCheck;
	private int receiveUserNo;
	private int sendUserNo;
	private int tableNo;
	private int operApplyNo;
	private int operNo;
	private int cmtNo;
	private int msgNo;
	private int brdNo;
	private int picNo;
	
	public Notice() {}

	public Notice(int noticeNo, String readCheck, int receiveUserNo, int sendUserNo, int tableNo, int operApplyNo,
			int operNo, int cmtNo, int msgNo, int brdNo, int picNo) {
		this.noticeNo = noticeNo;
		this.readCheck = readCheck;
		this.receiveUserNo = receiveUserNo;
		this.sendUserNo = sendUserNo;
		this.tableNo = tableNo;
		this.operApplyNo = operApplyNo;
		this.operNo = operNo;
		this.cmtNo = cmtNo;
		this.msgNo = msgNo;
		this.brdNo = brdNo;
		this.picNo = picNo;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getReadCheck() {
		return readCheck;
	}

	public void setReadCheck(String readCheck) {
		this.readCheck = readCheck;
	}

	public int getReceiveUserNo() {
		return receiveUserNo;
	}

	public void setReceiveUserNo(int receiveUserNo) {
		this.receiveUserNo = receiveUserNo;
	}

	public int getSendUserNo() {
		return sendUserNo;
	}

	public void setSendUserNo(int sendUserNo) {
		this.sendUserNo = sendUserNo;
	}

	public int getTableNo() {
		return tableNo;
	}

	public void setTableNo(int tableNo) {
		this.tableNo = tableNo;
	}

	public int getOperApplyNo() {
		return operApplyNo;
	}

	public void setOperApplyNo(int operApplyNo) {
		this.operApplyNo = operApplyNo;
	}

	public int getOperNo() {
		return operNo;
	}

	public void setOperNo(int operNo) {
		this.operNo = operNo;
	}

	public int getCmtNo() {
		return cmtNo;
	}

	public void setCmtNo(int cmtNo) {
		this.cmtNo = cmtNo;
	}

	public int getMsgNo() {
		return msgNo;
	}

	public void setMsgNo(int msgNo) {
		this.msgNo = msgNo;
	}

	public int getBrdNo() {
		return brdNo;
	}

	public void setBrdNo(int brdNo) {
		this.brdNo = brdNo;
	}

	public int getPicNo() {
		return picNo;
	}

	public void setPicNo(int picNo) {
		this.picNo = picNo;
	}

	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", readCheck=" + readCheck + ", receiveUserNo=" + receiveUserNo
				+ ", sendUserNo=" + sendUserNo + ", tableNo=" + tableNo + ", operApplyNo=" + operApplyNo + ", operNo="
				+ operNo + ", cmtNo=" + cmtNo + ", msgNo=" + msgNo + ", brdNo=" + brdNo +", picNo=" + picNo + "]";
	}

}
