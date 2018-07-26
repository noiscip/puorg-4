package kr.or.picsion.operation.dto;

import java.util.Date;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.operation.dto 
 * @className Operation
 * @date 2018. 6. 4.
 */

public class Operation {

	private int operNo;
	private int requesterNo;
	private int operatorNo;
	private int operPrice;
	private Date operStartReg;
	private Date operEndReg;
	private int firstCancelUserNo;
	private String operatorEnd;
	private String requesterEnd;
	private String operatorCancel;
	private String requesterCancel;
	private int operApplyNo;
	private int brdNo;
	private int step;

	public Operation() {
	}

	public Operation(int operNo, int requesterNo, int operatorNo, int operPrice, Date operStartReg, Date operEndReg,
			int firstCancelUserNo, String operatorEnd, String requesterEnd, String operatorCancel,
			String requesterCancel, int operApplyNo, int brdNo, int step) {
		super();
		this.operNo = operNo;
		this.requesterNo = requesterNo;
		this.operatorNo = operatorNo;
		this.operPrice = operPrice;
		this.operStartReg = operStartReg;
		this.operEndReg = operEndReg;
		this.firstCancelUserNo = firstCancelUserNo;
		this.operatorEnd = operatorEnd;
		this.requesterEnd = requesterEnd;
		this.operatorCancel = operatorCancel;
		this.requesterCancel = requesterCancel;
		this.operApplyNo = operApplyNo;
		this.brdNo = brdNo;
		this.step = step;
	}

	public int getOperNo() {
		return operNo;
	}

	public void setOperNo(int operNo) {
		this.operNo = operNo;
	}

	public int getRequesterNo() {
		return requesterNo;
	}

	public void setRequesterNo(int requesterNo) {
		this.requesterNo = requesterNo;
	}

	public int getOperatorNo() {
		return operatorNo;
	}

	public void setOperatorNo(int operatorNo) {
		this.operatorNo = operatorNo;
	}

	public int getOperPrice() {
		return operPrice;
	}

	public void setOperPrice(int operPrice) {
		this.operPrice = operPrice;
	}

	public Date getOperStartReg() {
		return operStartReg;
	}

	public void setOperStartReg(Date operStartReg) {
		this.operStartReg = operStartReg;
	}

	public Date getOperEndReg() {
		return operEndReg;
	}

	public void setOperEndReg(Date operEndReg) {
		this.operEndReg = operEndReg;
	}

	public int getFirstCancelUserNo() {
		return firstCancelUserNo;
	}

	public void setFirstCancelUserNo(int firstCancelUserNo) {
		this.firstCancelUserNo = firstCancelUserNo;
	}

	public String getOperatorEnd() {
		return operatorEnd;
	}

	public void setOperatorEnd(String operatorEnd) {
		this.operatorEnd = operatorEnd;
	}

	public String getRequesterEnd() {
		return requesterEnd;
	}

	public void setRequesterEnd(String requesterEnd) {
		this.requesterEnd = requesterEnd;
	}

	public String getOperatorCancel() {
		return operatorCancel;
	}

	public void setOperatorCancel(String operatorCancel) {
		this.operatorCancel = operatorCancel;
	}

	public String getRequesterCancel() {
		return requesterCancel;
	}

	public void setRequesterCancel(String requesterCancel) {
		this.requesterCancel = requesterCancel;
	}

	public int getOperApplyNo() {
		return operApplyNo;
	}

	public void setOperApplyNo(int operApplyNo) {
		this.operApplyNo = operApplyNo;
	}

	public int getBrdNo() {
		return brdNo;
	}

	public void setBrdNo(int brdNo) {
		this.brdNo = brdNo;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	@Override
	public String toString() {
		return "Operation [operNo=" + operNo + ", requesterNo=" + requesterNo + ", operatorNo=" + operatorNo
				+ ", operPrice=" + operPrice + ", operStartReg=" + operStartReg + ", operEndReg=" + operEndReg
				+ ", firstCancelUserNo=" + firstCancelUserNo + ", operatorEnd=" + operatorEnd + ", requesterEnd="
				+ requesterEnd + ", operatorCancel=" + operatorCancel + ", requesterCancel=" + requesterCancel
				+ ", operApplyNo=" + operApplyNo + ", brdNo=" + brdNo + ", step=" + step + "]";
	}

}
