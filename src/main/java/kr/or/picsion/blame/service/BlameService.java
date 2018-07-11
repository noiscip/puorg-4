package kr.or.picsion.blame.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.blame.dao.BlameDao;
import kr.or.picsion.blame.dto.Blame;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.blame.service 
 * @className BlameService
 * @date 2018. 6. 4.
 */

@Service
public class BlameService {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	/**
	 * 날      짜 : 2018. 6. 15.
	 * 메소드명 : complain
	 * 작성자명 : 김보경
	 * 기      능 : 신고 리스트 조회
	 *
	 * @return List<Blame>
	*/
	public List<Blame> complain() {
		BlameDao blameDao = sqlSession.getMapper(BlameDao.class);
		List<Blame> blameList = blameDao.blameList();
		
		return blameList;
	}
	
	/**
	 * 날      짜 : 2018. 6. 19.
	 * 메소드명 : complainSearch
	 * 작성자명 : 김보경
	 * 기      능 : 신고 기간으로 리스트 조회
	 *
	 * @param date
	 * @return List<Blame>
	*/
	public List<Blame> complainSearch(String date) {
		BlameDao blameDao = sqlSession.getMapper(BlameDao.class);
		return blameDao.complainSearch(date);
	}
	
	/**
	 * 날      짜 : 2018. 6. 15.
	 * 메소드명 : complainInsert
	 * 작성자명 : 아윤근
	 * 기      능 : 신고 추가
	 *
	 * @param blame
	 * @return Integer
	*/
	public int complainInsert(Blame blame) {
		BlameDao blameDao = sqlSession.getMapper(BlameDao.class);
		return blameDao.complainInsert(blame);
	}
	
}
