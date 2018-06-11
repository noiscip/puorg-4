package kr.or.picsion.operationapply.dto;

import java.util.Date;

public class OperationApply {

	private int operApplyNo;
	private String operApplyAppeal;
	private int operApplyPrice;
	private Date operApplyReg;
	private int requestUserNo;
	private int brdNo;
	private int operUserNo;
	private int resultNo;

	public OperationApply() {}

	public OperationApply(int operApplyNo, String operApplyAppeal, int operApplyPrice, Date operApplyReg,
			int requestUserNo, int brdNo, int operUserNo, int resultNo) {
		this.operApplyNo = operApplyNo;
		this.operApplyAppeal = operApplyAppeal;
		this.operApplyPrice = operApplyPrice;
		this.operApplyReg = operApplyReg;
		this.requestUserNo = requestUserNo;
		this.brdNo = brdNo;
		this.operUserNo = operUserNo;
		this.resultNo = resultNo;
	}

	public int getOperApplyNo() {
		return operApplyNo;
	}

	public void setOperApplyNo(int operApplyNo) {
		this.operApplyNo = operApplyNo;
	}

	public String getOperApplyAppeal() {
		return operApplyAppeal;
	}

	public void setOperApplyAppeal(String operApplyAppeal) {
		this.operApplyAppeal = operApplyAppeal;
	}

	public int getOperApplyPrice() {
		return operApplyPrice;
	}

	public void setOperApplyPrice(int operApplyPrice) {
		this.operApplyPrice = operApplyPrice;
	}

	public Date getOperApplyReg() {
		return operApplyReg;
	}

	public void setOperApplyReg(Date operApplyReg) {
		this.operApplyReg = operApplyReg;
	}

	public int getRequestUserNo() {
		return requestUserNo;
	}

	public void setRequestUserNo(int requestUserNo) {
		this.requestUserNo = requestUserNo;
	}

	public int getBrdNo() {
		return brdNo;
	}

	public void setBrdNo(int brdNo) {
		this.brdNo = brdNo;
	}

	public int getOperUserNo() {
		return operUserNo;
	}

	public void setOperUserNo(int operUserNo) {
		this.operUserNo = operUserNo;
	}

	public int getResultNo() {
		return resultNo;
	}

	public void setResultNo(int resultNo) {
		this.resultNo = resultNo;
	}

	@Override
	public String toString() {
		return "OperationApply [operApplyNo=" + operApplyNo + ", operApplyAppeal=" + operApplyAppeal
				+ ", operApplyPrice=" + operApplyPrice + ", operApplyReg=" + operApplyReg + ", requestUserNo="
				+ requestUserNo + ", brdNo=" + brdNo + ", operUserNo=" + operUserNo + ", resultNo=" + resultNo + "]";
	}

}
