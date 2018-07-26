package kr.or.picsion.operation.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.operation.dao.OperationDao;
import kr.or.picsion.operation.dto.Operation;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.operation.service 
 * @className OperationService
 * @date 2018. 6. 4.
 */

@Service
public class OperationService {

	@Autowired
	private SqlSession sqlSession;

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : insertOperation 
	 * 작성자명 : 김준수 
	 * 기      능 : 작업 등록 서비스
	 *
	 * @param operation
	 * @return Integer
	 */
	public int insertOperation(Operation operation) {
		System.out.println(operation);
		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		int result = operationDao.insertOperation(operation);

		return result;
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : selectOper 
	 * 작성자명 : 김준수
	 * 기      능 : 작업 찾기 서비스
	 *
	 * @param brdNo
	 * @return Operation
	 */
	public Operation selectOper(int brdNo) {

		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		Operation operation = operationDao.selectOper(brdNo);

		return operation;
	}
	
	/**
	* 날      짜 : 2018. 7. 4.
	* 메소드명 : operNoselectOper
	* 작성자명 : 김준수 
	* 기      능 : 작업번호로 작업 찾기
	*
	* @param operNo
	* @return Operation
	*/
	public Operation operNoselectOper(int operNo) {

		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		Operation operation = operationDao.operNoselectOper(operNo);

		return operation;
	}
	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : operBoardList 
	 * 작성자명 : 김준수 
	 * 기      능 : 작업 찾기list
	 *
	 * @return
	 */
	public List<Operation> operBoardList() {

		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		List<Operation> operation = operationDao.operBoardList();
		return operation;
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : operationList 
	 * 작성자명 : 김준수 
	 * 기      능 : 내 작업 리스트
	 *
	 * @param userNo
	 * @return
	 */
	public List<Operation> operationList(int userNo) {

		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		return operationDao.operationList(userNo);
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : requestList 
	 * 작성자명 : 김준수 
	 * 기      능 : 내 요청 리스트
	 *
	 * @param userNo
	 * @return
	 */
	public List<Operation> requestList(int userNo) {

		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		return operationDao.requestList(userNo);
	}
	
	
	
	/**
	* 날      짜 : 2018. 7. 3.
	* 메소드명 : updateOperation
	* 작성자명 : 김준수 
	* 기      능 : 
	*
	* @param operation
	* @return
	*/
	public int updateOperation(Operation operation) {
		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		int result = operationDao.updateOperation(operation);
		return result;
	}
}
