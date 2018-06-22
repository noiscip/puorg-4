package kr.or.picsion.operation.service;

import java.util.HashMap;
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

	

	// 작업 등록 서비스
	public int insertOperation(Operation operation) {
		System.out.println("insertOperation 서비스 ");
		System.out.println(operation);
		OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
		int result = operationDao.insertOperation(operation);
		
		return result;
	}
	// 작업 찾기 서비스
		public Operation selectOper(int brdNo) {

			System.out.println("selectOper 서비스 ");
			OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
			Operation operation = operationDao.selectOper(brdNo);
				
			return operation;
		}
	// 작업 찾기list 
		public List<Operation> operBoardList(HashMap<String, Integer> map) {

			System.out.println("operBoardList 서비스 시작 ");
			OperationDao operationDao = sqlSession.getMapper(OperationDao.class);
			List<Operation> operation = operationDao.operBoardList(map);
			System.out.println("operBoardList 서비스 끝");
			return operation;
		}
}
