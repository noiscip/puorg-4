package kr.or.picsion.operation.service;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.operation.dao.OperPictureDao;
import kr.or.picsion.operation.dto.OperPicture;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.operation.service 
 * @className OperPictureService
 * @date 2018. 7. 2.
 */

@Service
public class OperPictureService {

	@Autowired
	private SqlSession sqlSession;

	
	/**
	* 날      짜 : 2018. 7. 3.
	* 메소드명 : insertOperPicture
	* 작성자명 : 김준수 
	* 기      능 : 
	*
	* @param operpicture
	* @return
	*/
	public int insertOperPicture(OperPicture operpicture) {

		OperPictureDao operPictureDao = sqlSession.getMapper(OperPictureDao.class);
		int result = operPictureDao.insertOperPicture(operpicture);
		return result;
	}
	
	
	public OperPicture selectOperpicture(int operNo) {

		OperPictureDao operPictureDao = sqlSession.getMapper(OperPictureDao.class);
		OperPicture operPicture = operPictureDao.selectOperpicture(operNo);
		return operPicture;
	}
	
}
