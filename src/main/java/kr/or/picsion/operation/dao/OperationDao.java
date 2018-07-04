package kr.or.picsion.operation.dao;

import java.util.List;

import kr.or.picsion.operation.dto.Operation;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.operation.dao 
 * @className OperationDao
 * @date 2018. 6. 4.
 */

public interface OperationDao {

	public int insertOperation(Operation operation);
	public int updateOperation(Operation operation);
	public List<Operation> selectOperation(int userNo);	
	public Operation operNoselectOper(int operNo);
	public Operation selectOper(int brdNo);
	public List<Operation> operBoardList();
	public List<Operation> operationList(int userNo);
	public List<Operation> requestList(int userNo);	
}
