package kr.or.picsion.picture.dto;

public class Tag {
	
	private int picNo;
	private String tagContent;
	
	public Tag() {}
	
	public Tag(int picNo, String tagContent) {
		super();
		this.picNo = picNo;
		this.tagContent = tagContent;
	}
	public int getPicNo() {
		return picNo;
	}
	public void setPicNo(int picNo) {
		this.picNo = picNo;
	}
	public String getTagContent() {
		return tagContent;
	}
	public void setTagContent(String tagContent) {
		this.tagContent = tagContent;
	}

	@Override
	public String toString() {
		return "Tag [picNo=" + picNo + ", tagContent=" + tagContent + "]";
	}

}
