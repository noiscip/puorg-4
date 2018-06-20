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
}
