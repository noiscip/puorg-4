package kr.or.picsion.picture.dto;

import java.util.Date;
import java.util.List;

public class Picture {

	private int picNo;
	private String picTitle;
	private String picContent;
	private Date picReg;
	private String picPath;
	private String picWater;
	private int picHit;
	private int picPrice;
	private int userNo;
	private int tableNo;
	private String camera;
	private String resolution;
	private Date photoDate;
	private List<String> tagContent;
	private String cartCheck;
	private String respectCheck;
	private String bookmarkCheck;
	private int respectCount;
	private int bookmarkCount;
	private String transferState;

	public Picture() {}
	
	public Picture(int picNo, String picTitle, String picContent, Date picReg, String picPath, String picWater,
			int picHit, int picPrice, int userNo, int tableNo, String camera, String resolution, Date photoDate,

			List<String> tagContent,  String cartCheck, String respectCheck, String bookmarkCheck, int respectCount, int bookmarkCount,
			String transferState) {

		super();
		this.picNo = picNo;
		this.picTitle = picTitle;
		this.picContent = picContent;
		this.picReg = picReg;
		this.picPath = picPath;
		this.picWater = picWater;
		this.picHit = picHit;
		this.picPrice = picPrice;
		this.userNo = userNo;
		this.tableNo = tableNo;
		this.camera = camera;
		this.resolution = resolution;
		this.photoDate = photoDate;
		this.tagContent = tagContent;
		this.cartCheck = cartCheck;
		this.respectCheck = respectCheck;
		this.bookmarkCheck = bookmarkCheck;
		this.respectCount = respectCount;
		this.bookmarkCount = bookmarkCount;
		this.transferState = transferState;
	}

	public int getPicNo() {
		return picNo;
	}

	public void setPicNo(int picNo) {
		this.picNo = picNo;
	}

	public String getPicTitle() {
		return picTitle;
	}

	public void setPicTitle(String picTitle) {
		this.picTitle = picTitle;
	}

	public String getPicContent() {
		return picContent;
	}

	public void setPicContent(String picContent) {
		this.picContent = picContent;
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

	public String getPicWater() {
		return picWater;
	}

	public void setPicWater(String picWater) {
		this.picWater = picWater;
	}

	public int getPicHit() {
		return picHit;
	}

	public void setPicHit(int picHit) {
		this.picHit = picHit;
	}

	public int getPicPrice() {
		return picPrice;
	}

	public void setPicPrice(int picPrice) {
		this.picPrice = picPrice;
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

	public void setTableNo(int tableNo) {
		this.tableNo = tableNo;
	}

	public String getCamera() {
		return camera;
	}

	public void setCamera(String camera) {
		this.camera = camera;
	}

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}

	public Date getPhotoDate() {
		return photoDate;
	}

	public void setPhotoDate(Date photoDate) {
		this.photoDate = photoDate;
	}

	public List<String> getTagContent() {
		return tagContent;
	}

	public void setTagContent(List<String> tagContent) {
		this.tagContent = tagContent;
	}

	public String getCartCheck() {
		return cartCheck;
	}

	public void setCartCheck(String cartCheck) {
		this.cartCheck = cartCheck;
	}

	public String getRespectCheck() {
		return respectCheck;
	}

	public void setRespectCheck(String respectCheck) {
		this.respectCheck = respectCheck;
	}

	public String getBookmarkCheck() {
		return bookmarkCheck;
	}

	public void setBookmarkCheck(String bookmarkCheck) {
		this.bookmarkCheck = bookmarkCheck;
	}

	public int getRespectCount() {
		return respectCount;
	}

	public void setRespectCount(int respectCount) {
		this.respectCount = respectCount;
	}

	public int getBookmarkCount() {
		return bookmarkCount;
	}

	public void setBookmarkCount(int bookmarkCount) {
		this.bookmarkCount = bookmarkCount;
	}

	public String getTransferState() {
		return transferState;
	}

	public void setTransferState(String transferState) {
		this.transferState = transferState;
	}



	
	
	
}
