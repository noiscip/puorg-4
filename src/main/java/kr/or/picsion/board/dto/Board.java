package kr.or.picsion.board.dto;

import java.util.Date;

public class Board {

	private int brdNo;
	private String brdTitle;
	private String brdContent;
	private int brdExpectPrice;
	private Date brdExpectEndDate;
	private String copyright;
	private Date brdReg;
	private int userNo;
	private int tableNo;
	private int operStateNo;

	public Board() {}

	public Board(int brdNo, String brdTitle, String brdContent, int brdExpectPrice, Date brdExpectEndDate,
			String copyright, Date brdReg, int userNo, int tableNo, int operStateNo) {
		this.brdNo = brdNo;
		this.brdTitle = brdTitle;
		this.brdContent = brdContent;
		this.brdExpectPrice = brdExpectPrice;
		this.brdExpectEndDate = brdExpectEndDate;
		this.copyright = copyright;
		this.brdReg = brdReg;
		this.userNo = userNo;
		this.tableNo = tableNo;
		this.operStateNo = operStateNo;
	}

	public int getBrdNo() {
		return brdNo;
	}

	public void setBrdNo(int brdNo) {
		this.brdNo = brdNo;
	}

	public String getBrdTitle() {
		return brdTitle;
	}

	public void setBrdTitle(String brdTitle) {
		this.brdTitle = brdTitle;
	}

	public String getBrdContent() {
		return brdContent;
	}

	public void setBrdContent(String brdContent) {
		this.brdContent = brdContent;
	}

	public int getBrdExpectPrice() {
		return brdExpectPrice;
	}

	public void setBrdExpectPrice(int brdExpectPrice) {
		this.brdExpectPrice = brdExpectPrice;
	}

	public Date getBrdExpectEndDate() {
		return brdExpectEndDate;
	}

	public void setBrdExpectEndDate(Date brdExpectEndDate) {
		this.brdExpectEndDate = brdExpectEndDate;
	}

	public String getCopyright() {
		return copyright;
	}

	public void setCopyright(String copyright) {
		this.copyright = copyright;
	}

	public Date getBrdReg() {
		return brdReg;
	}

	public void setBrdReg(Date brdReg) {
		this.brdReg = brdReg;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getTableNo() {
		return tableNo;
	}

	public void setTableNo(int blaTypeNo) {
		this.tableNo = blaTypeNo;
	}

	public int getOperStateNo() {
		return operStateNo;
	}

	public void setOperStateNo(int operStateNo) {
		this.operStateNo = operStateNo;
	}

	@Override
	public String toString() {
		return "Board [brdNo=" + brdNo + ", brdTitle=" + brdTitle + ", brdContent=" + brdContent + ", brdExpectPrice="
				+ brdExpectPrice + ", brdExpectEndDate=" + brdExpectEndDate + ", copyright=" + copyright + ", brdReg="
				+ brdReg + ", userNo=" + userNo + ", tableNo=" + tableNo + ", operStateNo=" + operStateNo + "]";
	}

}
