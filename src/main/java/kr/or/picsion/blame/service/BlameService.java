package kr.or.picsion.blame.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.blame.dao.BlameDao;
import kr.or.picsion.blame.dto.Blame;
import kr.or.picsion.user.dao.UserDao;
import kr.or.picsion.user.dto.User;

@Service
public class BlameService {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<Blame> complain() {
		BlameDao blameDao = sqlSession.getMapper(BlameDao.class);
		List<Blame> blameList = blameDao.blameList();
		
		return blameList;
	}
	
	public List<Blame> complainSearch(String date) {
		BlameDao blameDao = sqlSession.getMapper(BlameDao.class);
		return blameDao.complainSearch(date);
	}
	
}
