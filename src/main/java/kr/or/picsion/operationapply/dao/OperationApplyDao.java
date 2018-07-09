package kr.or.picsion.operationapply.dao;

import java.util.List;

import kr.or.picsion.operationapply.dto.OperationApply;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.operationapply.dao 
 * @className OperationApplyDao
 * @date 2018. 6. 4.
 */

public interface OperationApplyDao {

	public int insertOperationApply(OperationApply operationApply);
	public int countOperationApply(OperationApply operationApply);
	
	public List<OperationApply> selectOperationApply(int requestUserNo);
	public List<OperationApply> operationApplyList(int brdNo, int requestUserNo);
	public List<String> operationApplyNameList(int brdNo);
	public String operationStatus(int operStateNo);
	
	
}
