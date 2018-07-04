package kr.or.picsion.operation.dto;

import java.util.Date;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.operation.dto 
 * @className OperPicture
 * @date 2018. 7. 2.
 */

public class OperPicture {

	private int operNo;
	private Date picReg;
	private String picPath;
	private int userNo;
	private int blaTypeNo;
	public int getOperNo() {
		return operNo;
	}
	public void setOperNo(int operNo) {
		this.operNo = operNo;
	}
	public Date getPicReg() {
		return picReg;
	}
	public void setPicReg(Date picReg) {
		this.picReg = picReg;
	}
	public String getPicPath() {
		return picPath;
	}
	public void setPicPath(String picPath) {
		this.picPath = picPath;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getBlaTypeNo() {
		return blaTypeNo;
	}
	public void setBlaTypeNo(int blaTypeNo) {
		this.blaTypeNo = blaTypeNo;
	}
	public OperPicture() {}
	public OperPicture(int operNo, Date picReg, String picPath, int userNo, int blaTypeNo) {
		super();
		this.operNo = operNo;
		this.picReg = picReg;
		this.picPath = picPath;
		this.userNo = userNo;
		this.blaTypeNo = blaTypeNo;
	}
	@Override
	public String toString() {
		return "OperPicture [operNo=" + operNo + ", picReg=" + picReg + ", picPath=" + picPath + ", userNo=" + userNo
				+ ", blaTypeNo=" + blaTypeNo + "]";
	}
	
	
	

}
