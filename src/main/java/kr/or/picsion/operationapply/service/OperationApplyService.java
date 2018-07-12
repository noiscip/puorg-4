package kr.or.picsion.operationapply.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.operationapply.dao.OperationApplyDao;
import kr.or.picsion.operationapply.dto.OperationApply;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.operationapply.service 
 * @className OperationApplyService
 * @date 2018. 6. 4.
 */

@Service
public class OperationApplyService {

	@Autowired
	private SqlSession sqlSession;
	
	/**
	* 날      짜 : 2018. 7. 9.
	* 메소드명 : countOperationApply
	* 작성자명 : 김준수 
	* 기      능 : 중복 신청 확인
	*
	* @param operationApply
	* @return Integer
	*/
	public int countOperationApply(OperationApply operationApply) {
		int result=0;
		OperationApplyDao operationApplyDao = sqlSession.getMapper(OperationApplyDao.class);
		result=operationApplyDao.countOperationApply(operationApply);		
		return result;
	}
	
	
	
	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : insertOperationApply 
	 * 작성자명 : 김준수 
	 * 기      능 : 신청하기
	 *
	 * @param operationApply
	 * @return Integer
	 */
	public int insertOperationApply(OperationApply operationApply) {
		OperationApplyDao operationApplyDao = sqlSession.getMapper(OperationApplyDao.class);

		int check = operationApplyDao.insertOperationApply(operationApply);

		return check;
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : operationApplyNameList 
	 * 작성자명 : 김준수 
	 * 기      능 : 해당유저가쓴 요청글에 신청자 이름 목록 가져오기
	 *
	 * @param brdNo
	 * @return List<String>
	 */
	public List<String> operationApplyNameList(int brdNo) {
		OperationApplyDao operationApplyDao = sqlSession.getMapper(OperationApplyDao.class);

		List<String> operationApplyNameList = operationApplyDao.operationApplyNameList(brdNo);

		return operationApplyNameList;
	}

	/**
	 * 날      짜 : 2018. 6. 29. 
	 * 메소드명 : operationApplyList 
	 * 작성자명 : 김준수 
	 * 기      능 : 해당유저가쓴 요청글에 신청자 목록 가져오기
	 *
	 * @param brdNo
	 * @param requestUserNo
	 * @return List<OperationApply>
	 */
	public List<OperationApply> operationApplyList(int brdNo, int requestUserNo) {
		OperationApplyDao operationApplyDao = sqlSession.getMapper(OperationApplyDao.class);

		List<OperationApply> operationapplylist = operationApplyDao.operationApplyList(brdNo, requestUserNo);

		return operationapplylist;
	}
}
