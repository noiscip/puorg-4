package kr.or.picsion.operationapply.dao;

import java.util.List;

import kr.or.picsion.operationapply.dto.OperationApply;

public interface OperationApplyDao {

	public int insertOperationApply(OperationApply operationApply);
	public int deleteOperationApply(int operApplyNo);
	public List<OperationApply> selectOperationApply(int requestUserNo);
	public String operationStatus(int operStateNo);
	
	
}
