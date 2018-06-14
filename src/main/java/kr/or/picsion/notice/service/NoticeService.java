/**
 * 
 */
package kr.or.picsion.notice.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.notice.dao.NoticeDao;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.notice.service 
 * @className NoticeService
 * @date 2018. 6. 14.
 */

@Service
public class NoticeService {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int readCheckCount(int userNo) {
		
			NoticeDao noticeDao = sqlSession.getMapper(NoticeDao.class);
			
		return noticeDao.readCheckCount(userNo);
	}
}
