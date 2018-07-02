package kr.or.picsion.purchase.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.purchase.dao.PurchaseDao;
import kr.or.picsion.purchase.dto.Purchase;
import kr.or.picsion.user.dto.User;

@Service
public class PurchaseService {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<Purchase> purchaseList(){
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		List<Purchase> purchaseList = purchaseDao.purchaseList();
		
		return purchaseList;
	}
	
	public List<Purchase> purchaseSearch(String date) {
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		return purchaseDao.purchaseSearch(date);
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : insertCart
	* 작성자명 : 정도혁
	* 기      능 : 장바구니에 사진 저장
	*
	* @param picNo
	* @param userNo
	* @return Integer
	*/
	public int insertCart(int picNo, int userNo) {
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		int result = purchaseDao.insertCart(picNo, userNo);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : deleteCart
	* 작성자명 : 정도혁
	* 기      능 : 장바구니에서 빼기
	*
	* @param picNo
	* @param userNo
	* @return Integer
	*/
	public int deleteCart(int picNo, int userNo) {
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		int result = purchaseDao.deleteCart(picNo, userNo);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : deleteCartAll
	* 작성자명 : 정도혁
	* 기      능 : 장바구니 전체 비우기
	*
	* @param userNo
	* @return Integer
	*/
	public int deleteCartAll(int userNo) {
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		int result = purchaseDao.deleteCartAll(userNo);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : selectCart
	* 작성자명 : 정도혁
	* 기      능 : 장바구니에 담긴 사진 리스트
	*
	* @param userNo
	* @return List<Picture>
	*/
	public List<Picture> selectCart(int userNo){
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		List<Picture> list = purchaseDao.selectCart(userNo);
		return list;
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : CartPhotographer
	* 작성자명 : 정도혁
	* 기      능 : 장바구니에 담긴 사진 작가 리스트
	*
	* @param userNo
	* @return List<User>
	*/
	public List<User> CartPhotographer(int userNo){
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		List<User> list = purchaseDao.CartPhotographer(userNo);
		return list;
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : cartTotal
	* 작성자명 : 정도혁
	* 기      능 : 장바구니 합계
	*
	* @param userNo
	* @return Integer
	*/
	public int cartTotal(int userNo) {
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		int total = purchaseDao.cartTotal(userNo);
		return total;
	}
	
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : cartConfirm
	* 작성자명 : 정도혁
	* 기      능 : 장바구니 담김 여부
	*
	* @param picNo
	* @param userNo
	* @return Integer
	*/
	public int cartConfirm(int picNo, int userNo) {
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		int result = purchaseDao.cartConfirm(picNo, userNo);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : buyPicture
	* 작성자명 : 정도혁
	* 기      능 : 사진 구매
	*
	* @param picNo
	* @param purchaseUserNo
	* @param saleUserNo
	* @return Integer
	*/
	public int buyPicture(List<Purchase> purlist) {
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		int result = purchaseDao.buyPicture(purlist);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : cartCount
	* 작성자명 : 정도혁
	* 기      능 : 장바구니 항목 갯수 
	*
	* @param userNo
	* @return Integer
	*/
	public int cartCount(int userNo) {
		PurchaseDao purchaseDao = sqlSession.getMapper(PurchaseDao.class);
		int result = purchaseDao.cartCount(userNo);
		return result;
	}

}
