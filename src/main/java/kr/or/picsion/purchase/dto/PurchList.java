/**
 * 
 */
package kr.or.picsion.purchase.dto;

import java.util.List;

/**
 * @author Bit
 *
 */
public class PurchList {
	
	private List<Purchase> purchases;

	public PurchList() {}
	
	public PurchList(List<Purchase> purchases) {
		super();
		this.purchases = purchases;
	}

	public List<Purchase> getPurchases() {
		return purchases;
	}

	public void setPurchases(List<Purchase> purchases) {
		this.purchases = purchases;
	}
}
