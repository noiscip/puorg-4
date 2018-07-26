package kr.or.picsion.picture.dto;

import java.util.Date;
import java.util.List;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.picture.dto
 * @className Picture
 * @date 2018. 6. 4.
 */

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
	private String userName;
	private int tableNo;
	private String camera;
	private String resolutionH;
	private String resolutionW;
	private Date photoDate;
	private List<String> tagContent;
	private String cartCheck;
	private String respectCheck;
	private String bookmarkCheck;
	private int respectCount;
	private int bookmarkCount;
	private String transferState;
	private String lens;
	private int picPeople;
	private List<Colors> colorList;
	
	public Picture() {
	}

	public Picture(int picNo, String picTitle, String picContent, Date picReg, String picPath, String picWater,
			int picHit, int picPrice, int userNo, String userName, int tableNo, String camera, String resolutionH,
			String resolutionW, Date photoDate, List<String> tagContent, String cartCheck, String respectCheck,
			String bookmarkCheck, int respectCount, int bookmarkCount, String transferState, String lens, int picPeople,
			List<Colors> colorList) {
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
		this.userName = userName;
		this.tableNo = tableNo;
		this.camera = camera;
		this.resolutionH = resolutionH;
		this.resolutionW = resolutionW;
		this.photoDate = photoDate;
		this.tagContent = tagContent;
		this.cartCheck = cartCheck;
		this.respectCheck = respectCheck;
		this.bookmarkCheck = bookmarkCheck;
		this.respectCount = respectCount;
		this.bookmarkCount = bookmarkCount;
		this.transferState = transferState;
		this.lens = lens;
		this.picPeople = picPeople;
		this.colorList = colorList;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public String getResolutionH() {
		return resolutionH;
	}

	public void setResolutionH(String resolutionH) {
		this.resolutionH = resolutionH;
	}

	public String getResolutionW() {
		return resolutionW;
	}

	public void setResolutionW(String resolutionW) {
		this.resolutionW = resolutionW;
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

	public String getLens() {
		return lens;
	}

	public void setLens(String lens) {
		this.lens = lens;
	}

	public int getPicPeople() {
		return picPeople;
	}

	public void setPicPeople(int picPeople) {
		this.picPeople = picPeople;
	}

	public List<Colors> getColorList() {
		return colorList;
	}

	public void setColorList(List<Colors> colorList) {
		this.colorList = colorList;
	}

	@Override
	public String toString() {
		return "Picture [picNo=" + picNo + ", picTitle=" + picTitle + ", picContent=" + picContent + ", picReg="
				+ picReg + ", picPath=" + picPath + ", picWater=" + picWater + ", picHit=" + picHit + ", picPrice="
				+ picPrice + ", userNo=" + userNo + ", userName=" + userName + ", tableNo=" + tableNo + ", camera="
				+ camera + ", resolutionH=" + resolutionH + ", resolutionW=" + resolutionW + ", photoDate=" + photoDate
				+ ", tagContent=" + tagContent + ", cartCheck=" + cartCheck + ", respectCheck=" + respectCheck
				+ ", bookmarkCheck=" + bookmarkCheck + ", respectCount=" + respectCount + ", bookmarkCount="
				+ bookmarkCount + ", transferState=" + transferState + ", lens=" + lens + ", picPeople=" + picPeople
				+ ", colorList=" + colorList + "]";
	}

}
