package kr.or.picsion.user.dto;

import java.util.Date;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.user.dto 
 * @className User
 * @date 2018. 6. 4.
 */

public class User {

	private int userNo;
	private String userId;
	private String pwd;
	private String userName;
	private int point;
	private Date userReg;
	private int tableNo;
	private int roleNo;
	private String naver;
	private String google;
	private String prPicture;
	private String prContent;
	private int follower;

	public User() {}

	public User(int userNo, String userId, String pwd, String userName, int point, Date userReg, int tableNo,
			int roleNo, String naver, String google, String prPicture, String prContent, int follower) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.pwd = pwd;
		this.userName = userName;
		this.point = point;
		this.userReg = userReg;
		this.tableNo = tableNo;
		this.roleNo = roleNo;
		this.naver = naver;
		this.google = google;
		this.prPicture = prPicture;
		this.prContent = prContent;
		this.follower = follower;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public Date getUserReg() {
		return userReg;
	}

	public void setUserReg(Date userReg) {
		this.userReg = userReg;
	}

	public int getTableNo() {
		return tableNo;
	}

	public void setTableNo(int tableNo) {
		this.tableNo = tableNo;
	}

	public int getRoleNo() {
		return roleNo;
	}

	public void setRoleNo(int roleNo) {
		this.roleNo = roleNo;
	}

	public String getNaver() {
		return naver;
	}

	public void setNaver(String naver) {
		this.naver = naver;
	}

	public String getGoogle() {
		return google;
	}

	public void setGoogle(String google) {
		this.google = google;
	}

	public String getPrPicture() {
		return prPicture;
	}

	public void setPrPicture(String prPicture) {
		this.prPicture = prPicture;
	}

	public String getPrContent() {
		return prContent;
	}

	public void setPrContent(String prContent) {
		this.prContent = prContent;
	}

	public int getFollower() {
		return follower;
	}

	public void setFollower(int follower) {
		this.follower = follower;
	}

	@Override
	public String toString() {
		return "User [userNo=" + userNo + ", userId=" + userId + ", pwd=" + pwd + ", userName=" + userName + ", point="
				+ point + ", userReg=" + userReg + ", tableNo=" + tableNo + ", roleNo=" + roleNo + ", naver=" + naver
				+ ", google=" + google + ", prPicture=" + prPicture + ", prContent=" + prContent + ", follower="
				+ follower + "]";
	}

}
