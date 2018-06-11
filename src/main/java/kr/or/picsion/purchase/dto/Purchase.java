package kr.or.picsion.purchase.dto;

import java.util.Date;

public class Purchase {

	private int picNo;
	private int purchaseUserNo;
	private int saleUserNo;
	private Date purchaseReg;

	public Purchase() {}

	public Purchase(int picNo, int purchaseUserNo, int saleUserNo, Date purchaseReg) {
		this.picNo = picNo;
		this.purchaseUserNo = purchaseUserNo;
		this.saleUserNo = saleUserNo;
		this.purchaseReg = purchaseReg;
	}

	public int getPicNo() {
		return picNo;
	}

	public void setPicNo(int picNo) {
		this.picNo = picNo;
	}

	public int getPurchaseUserNo() {
		return purchaseUserNo;
	}

	public void setPurchaseUserNo(int purchaseUserNo) {
		this.purchaseUserNo = purchaseUserNo;
	}

	public int getSaleUserNo() {
		return saleUserNo;
	}

	public void setSaleUserNo(int saleUserNo) {
		this.saleUserNo = saleUserNo;
	}

	public Date getPurchaseReg() {
		return purchaseReg;
	}

	public void setPurchaseReg(Date purchaseReg) {
		this.purchaseReg = purchaseReg;
	}

	@Override
	public String toString() {
		return "Purchase [picNo=" + picNo + ", purchaseUserNo=" + purchaseUserNo + ", saleUserNo=" + saleUserNo
				+ ", purchaseReg=" + purchaseReg + "]";
	}

}
