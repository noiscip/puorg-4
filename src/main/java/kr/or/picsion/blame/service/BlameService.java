package kr.or.picsion.blame.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BlameService {
	
	@Autowired
	private SqlSession sqlSession;
	
}
