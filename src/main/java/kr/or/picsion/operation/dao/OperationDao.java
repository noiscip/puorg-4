package kr.or.picsion.operation.dao;

import java.util.HashMap;
import java.util.List;

import kr.or.picsion.operation.dto.Operation;

public interface OperationDao {

	public int insertOperation(Operation operation);
	public int updateOperation(Operation operation);
	public List<Operation> selectOperation(int userNo);
	public Operation selectOper(int brdNo);
	public List<Operation> operBoardList(HashMap<String, Integer> map);
	public List<Operation> operationList(int userNo);
	public List<Operation> requestList(int userNo);	
}
