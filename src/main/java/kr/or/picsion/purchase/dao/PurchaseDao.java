package kr.or.picsion.purchase.dao;

import java.util.List;

import kr.or.picsion.purchase.dto.Purchase;

public interface PurchaseDao {

	public int insertPurchase(Purchase purchase);
	public Purchase buyList(int purchaseUserNo);
	public Purchase sellList(int saleUserNo);
	public List<Purchase> purchaseList();
}
