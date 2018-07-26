package kr.or.picsion.purchase.dto;

import java.util.Date;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.purchase.dto 
 * @className Purchase
 * @date 2018. 6. 4.
 */

public class Purchase {

	private int picNo;
	private int purchaseUserNo;
	private int saleUserNo;
	private Date purchaseReg;
	private int picPrice;

	public Purchase() {}

	public Purchase(int picNo, int purchaseUserNo, int saleUserNo, Date purchaseReg, int picPrice) {
		super();
		this.picNo = picNo;
		this.purchaseUserNo = purchaseUserNo;
		this.saleUserNo = saleUserNo;
		this.purchaseReg = purchaseReg;
		this.picPrice = picPrice;
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

	public int getPicPrice() {
		return picPrice;
	}

	public void setPicPrice(int picPrice) {
		this.picPrice = picPrice;
	}

	@Override
	public String toString() {
		return "Purchase [picNo=" + picNo + ", purchaseUserNo=" + purchaseUserNo + ", saleUserNo=" + saleUserNo
				+ ", purchaseReg=" + purchaseReg + ", picPrice=" + picPrice + "]";
	}
	
}
