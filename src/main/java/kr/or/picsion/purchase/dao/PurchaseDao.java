package kr.or.picsion.purchase.dao;

import java.util.Date;
import java.util.List;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.purchase.dto.Purchase;
import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.purchase.dao 
 * @className PurchaseDao
 * @date 2018. 6. 4.
 */

public interface PurchaseDao {

	public int insertPurchase(Purchase purchase);  //구매
	public Purchase buyList(int purchaseUserNo);   //구매자 번호로 구매 확인
	public Purchase sellList(int saleUserNo);	   //판매
	public List<Purchase> purchaseList();		   //구매 리스트
	public List<Purchase> purchaseSearch(String date); //날짜로 검색한 구매 리스트

	public int salesStatistics(Date startDate, Date endDate);

	public int insertCart(int picNo, int userNo);  //장바구니에 저장
	public int deleteCart(int picNo, int userNo);  //장바구니에서  빼기
	public int deleteCartAll(int userNo);		   //장바구니 전체 비우기
	public List<Picture> selectCart(int userNo);   //장바구니에 저장된 사진 리스트
	public List<User> CartPhotographer(int userNo); //장바구니에 저장된 사진 작가 리스트
	public int cartTotal(int userNo);			   //장바구니 합계
	public int cartCount(int userNo);              //장바구니 항목 갯수
	public int cartConfirm(int userNo, int picNo); //장바구니 확인
	public int purchaseConfirm(int purchaseUserNo, int picNo); //구매 확인
	public int buyPicture(List<Purchase> purcahseList); //사진 결제
	public List<Picture> selectPicPurchase(int userNo);	//구매한 사진 리스트
	public List<User> selectPicUser(int userNo);		//구매한 사진 작가 리스트
	public List<Purchase> selectPurchase(int userNo);	//구매한 정보 리스트
	public int sumPurchase(int userNo);				//구매한 사진의 총 합계
	public int updatePoint(int point, int userNo);

}
