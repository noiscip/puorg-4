package kr.or.picsion.comment.dto;

import java.util.Date;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.comment.dto 
 * @className Comment
 * @date 2018. 6. 4.
 */

public class Comment {

	private int cmtNo;
	private String cmtContent;
	private Date cmtReg;
	private String cmtDel;
	private int userNo;
	private int brdNo;
	private int picNo;
	private int tableNo;
	
	public Comment() {}

	public Comment(int cmtNo, String cmtContent, Date cmtReg, String cmtDel, int userNo, int brdNo, int picNo,
			int tableNo) {
		this.cmtNo = cmtNo;
		this.cmtContent = cmtContent;
		this.cmtReg = cmtReg;
		this.cmtDel = cmtDel;
		this.userNo = userNo;
		this.brdNo = brdNo;
		this.picNo = picNo;
		this.tableNo = tableNo;
	}

	public int getCmtNo() {
		return cmtNo;
	}

	public void setCmtNo(int cmtNo) {
		this.cmtNo = cmtNo;
	}

	public String getCmtContent() {
		return cmtContent;
	}

	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}

	public Date getCmtReg() {
		return cmtReg;
	}

	public void setCmtReg(Date cmtReg) {
		this.cmtReg = cmtReg;
	}

	public String getCmtDel() {
		return cmtDel;
	}

	public void setCmtDel(String cmtDel) {
		this.cmtDel = cmtDel;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
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

	public int getTableNo() {
		return tableNo;
	}

	public void setTableNo(int blaTypeNo) {
		this.tableNo = blaTypeNo;
	}

	@Override
	public String toString() {
		return "Comments [cmtNo=" + cmtNo + ", cmtContent=" + cmtContent + ", cmtReg=" + cmtReg + ", cmtDel=" + cmtDel
				+ ", userNo=" + userNo + ", brdNo=" + brdNo + ", picNo=" + picNo + ", tableNo=" + tableNo + "]";
	}
	
	
	
}
