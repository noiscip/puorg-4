package kr.or.picsion.operationapply.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OperationApplyService {
	
	@Autowired
	private SqlSession sqlSession;
	
}
