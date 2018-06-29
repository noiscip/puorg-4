package kr.or.picsion.operationapply.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.operationapply.dao.OperationApplyDao;
import kr.or.picsion.operationapply.dto.OperationApply;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dao.UserDao;

@Service
public class OperationApplyService {

	@Autowired
	private SqlSession sqlSession;

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : insertOperationApply 
	 * 작성자명 : 김준수 
	 * 기 능 : 신청하기
	 *
	 * @param operationApply
	 * @return
	 */
	public int insertOperationApply(OperationApply operationApply) {
		System.out.println("insertoperation 서비스");
		OperationApplyDao operationApplyDao = sqlSession.getMapper(OperationApplyDao.class);

		int check = operationApplyDao.insertOperationApply(operationApply);

		return check;
	}

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : operationApplyNameList 
	 * 작성자명 : 김준수 
	 * 기 능 : 해당유저가쓴 요청글에 신청자 이름 목록 가져오기
	 *
	 * @param brdNo
	 * @return
	 */
	public List<String> operationApplyNameList(int brdNo) {
		System.out.println("operationApplyNameList 서비스");
		OperationApplyDao operationApplyDao = sqlSession.getMapper(OperationApplyDao.class);

		List<String> operationApplyNameList = operationApplyDao.operationApplyNameList(brdNo);

		return operationApplyNameList;
	}

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : operationApplyList 
	 * 작성자명 : 김준수 
	 * 기 능 : 해당유저가쓴 요청글에 신청자 목록 가져오기
	 *
	 * @param brdNo
	 * @param requestUserNo
	 * @return
	 */
	public List<OperationApply> operationApplyList(int brdNo, int requestUserNo) {
		System.out.println("operationApplyList 서비스");
		OperationApplyDao operationApplyDao = sqlSession.getMapper(OperationApplyDao.class);

		List<OperationApply> operationapplylist = operationApplyDao.operationApplyList(brdNo, requestUserNo);

		return operationapplylist;
	}
}
