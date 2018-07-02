package kr.or.picsion.operation.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.operation.dao.OperationDao;
import kr.or.picsion.operation.dto.Operation;

@Service
public class OperationService {

	@Autowired
	private SqlSession sqlSession;

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : insertOperation 
	 * 작성자명 : 김준수 
	 * 기 능 : 작업 등록 서비스
	 *
	 * @param operation
	 * @return
	 */
	public int insertOperation(Operation operation) {
		System.out.println("insertOperation 서비스 ");
		System.out.println(operation);
		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		int result = operationDao.insertOperation(operation);
		System.out.println("insertOperation 서비스  끝");

		return result;
	}

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : selectOper 
	 * 작성자명 : 김준수
	 * 기 능 : 작업 찾기 서비스
	 *
	 * @param brdNo
	 * @return
	 */
	public Operation selectOper(int brdNo) {

		System.out.println("selectOper 서비스 ");
		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		Operation operation = operationDao.selectOper(brdNo);

		return operation;
	}

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : operBoardList 
	 * 작성자명 : 김준수 
	 * 기 능 : 작업 찾기list
	 *
	 * @return
	 */
	public List<Operation> operBoardList() {

		System.out.println("operBoardList 서비스 시작 ");
		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		List<Operation> operation = operationDao.operBoardList();
		System.out.println("operBoardList 서비스 끝");
		return operation;
	}

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : operationList 
	 * 작성자명 : 김준수 
	 * 기 능 : 내 작업 리스트
	 *
	 * @param userNo
	 * @return
	 */
	public List<Operation> operationList(int userNo) {

		System.out.println("operationList 서비스 시작 ");
		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		return operationDao.operationList(userNo);
	}

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : requestList 
	 * 작성자명 : 김준수 
	 * 기 능 : 내 요청 리스트
	 *
	 * @param userNo
	 * @return
	 */
	public List<Operation> requestList(int userNo) {

		System.out.println("requestList 서비스 시작 ");
		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		return operationDao.requestList(userNo);
	}
}
