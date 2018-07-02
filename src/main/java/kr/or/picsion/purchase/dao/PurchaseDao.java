package kr.or.picsion.purchase.dao;

import java.util.List;

import kr.or.picsion.purchase.dto.Purchase;

public interface PurchaseDao {

	public int insertPurchase(Purchase purchase);  //구매
	public Purchase buyList(int purchaseUserNo);   //구매자 번호로 구매 확인
	public Purchase sellList(int saleUserNo);	   //판매
	public List<Purchase> purchaseList();		   //구매 리스트
	public List<Purchase> purchaseSearch(String date); //날짜로 검색한 구매 리스트
}
