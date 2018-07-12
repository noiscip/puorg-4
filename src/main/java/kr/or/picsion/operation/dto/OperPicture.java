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
	private String wpicPath;
	private int userNo;
	private int blaTypeNo;
	
	public OperPicture(){}
	public OperPicture(int operNo, Date picReg, String picPath, String wpicPath, int userNo, int blaTypeNo) {
		
		this.operNo = operNo;
		this.picReg = picReg;
		this.picPath = picPath;
		this.wpicPath = wpicPath;
		this.userNo = userNo;
		this.blaTypeNo = blaTypeNo;
	}
	
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
	public String getWpicPath() {
		return wpicPath;
	}
	public void setWpicPath(String wpicPath) {
		this.wpicPath = wpicPath;
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
	@Override
	public String toString() {
		return "OperPicture [operNo=" + operNo + ", picReg=" + picReg + ", picPath=" + picPath + ", wpicPath="
				+ wpicPath + ", userNo=" + userNo + ", blaTypeNo=" + blaTypeNo + "]";
	}
	
	
	

}
