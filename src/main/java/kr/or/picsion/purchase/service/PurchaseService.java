package kr.or.picsion.purchase.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PurchaseService {
	
	@Autowired
	private SqlSession sqlSession;
	
}
