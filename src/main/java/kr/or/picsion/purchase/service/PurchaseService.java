package kr.or.picsion.purchase.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.purchase.dao.PurchaseDao;
import kr.or.picsion.purchase.dto.Purchase;

@Service
public class PurchaseService {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<Purchase> purchaseList(){
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		List<Purchase> purchaseList = purchaseDao.purchaseList();
		
		return purchaseList;
	}
}
