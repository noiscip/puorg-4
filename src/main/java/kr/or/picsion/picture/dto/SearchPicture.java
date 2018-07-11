package kr.or.picsion.picture.dto;


/**
 * @project Final_Picsion
 * @package kr.or.picsion.picture.dto
 * @className SearchPicture
 * @date 2018. 7. 20.
 */

public class SearchPicture {

	private int userNo;
	private String order;
	private String tag;
	private int colorR;
	private int colorG;
	private int colorB;
	private int lowPrice;
	private int highPrice;
	private int picPeople;
	private String resolutionSize;
	
	public SearchPicture() {
	}

	public SearchPicture(int userNo, String order, String tag, int colorR, int colorG, int colorB, int lowPrice,
			int highPrice, int picPeople, String resolutionSize) {
		super();
		this.userNo = userNo;
		this.order = order;
		this.tag = tag;
		this.colorR = colorR;
		this.colorG = colorG;
		this.colorB = colorB;
		this.lowPrice = lowPrice;
		this.highPrice = highPrice;
		this.picPeople = picPeople;
		this.resolutionSize = resolutionSize;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public int getColorR() {
		return colorR;
	}

	public void setColorR(int colorR) {
		this.colorR = colorR;
	}

	public int getColorG() {
		return colorG;
	}

	public void setColorG(int colorG) {
		this.colorG = colorG;
	}

	public int getColorB() {
		return colorB;
	}

	public void setColorB(int colorB) {
		this.colorB = colorB;
	}

	public int getLowPrice() {
		return lowPrice;
	}

	public void setLowPrice(int lowPrice) {
		this.lowPrice = lowPrice;
	}

	public int getHighPrice() {
		return highPrice;
	}

	public void setHighPrice(int highPrice) {
		this.highPrice = highPrice;
	}

	public int getPicPeople() {
		return picPeople;
	}

	public void setPicPeople(int picPeople) {
		this.picPeople = picPeople;
	}

	public String getResolutionSize() {
		return resolutionSize;
	}

	public void setResolutionSize(String resolutionSize) {
		this.resolutionSize = resolutionSize;
	}

	@Override
	public String toString() {
		return "SearchPicture [userNo=" + userNo + ", order=" + order + ", tag=" + tag + ", colorR=" + colorR
				+ ", colorG=" + colorG + ", colorB=" + colorB + ", lowPrice=" + lowPrice + ", highPrice=" + highPrice
				+ ", picPeople=" + picPeople + ", resolutionSize=" + resolutionSize + "]";
	}


}
