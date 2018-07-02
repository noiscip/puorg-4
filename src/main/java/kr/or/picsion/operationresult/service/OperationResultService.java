package kr.or.picsion.operationresult.service;

public class OperationResultService {

	private int operNo;
	private int requesterNo;
	private int operatorNo;
	private int penaltyUserNo;
	private int resultNo;
	
	public OperationResultService(int operNo, int requesterNo, int operatorNo, int penaltyUserNo, int resultNo) {
		super();
		this.operNo = operNo;
		this.requesterNo = requesterNo;
		this.operatorNo = operatorNo;
		this.penaltyUserNo = penaltyUserNo;
		this.resultNo = resultNo;
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
	public int getPenaltyUserNo() {
		return penaltyUserNo;
	}
	public void setPenaltyUserNo(int penaltyUserNo) {
		this.penaltyUserNo = penaltyUserNo;
	}
	public int getResultNo() {
		return resultNo;
	}
	public void setResultNo(int resultNo) {
		this.resultNo = resultNo;
	}
	
	
	@Override
	public String toString() {
		return "OperationResult [operNo=" + operNo + ", requesterNo=" + requesterNo + ", operatorNo=" + operatorNo
				+ ", penaltyUserNo=" + penaltyUserNo + ", resultNo=" + resultNo + "]";
	}

	
}
