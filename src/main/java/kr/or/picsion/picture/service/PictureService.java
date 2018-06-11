package kr.or.picsion.picture.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PictureService {
	
	@Autowired
	private SqlSession sqlSession;
	
}
