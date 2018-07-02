package kr.or.picsion.purchase.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.purchase.dto.Purchase;
import kr.or.picsion.purchase.service.PurchaseService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

@Controller
@RequestMapping("/purchase/")
public class PurchaseController {

	@Autowired
	private View jsonview;
	
	@Autowired
	private UserService userService;

	@Autowired
	private PurchaseService purchaseService;
	
	@RequestMapping("adminPurchase.ps")
	public String purchase(Model model) {
		
		List<Purchase> purchaseList = purchaseService.purchaseList();
		model.addAttribute("purchaseList",purchaseList);
		return "admin.purchase";
	}
	
	@RequestMapping("adminPurchaseSearch.ps")
	public View purchaseSearch(Date date, Model model) {
		System.out.println("purchaseSearch");
		System.out.println(date);
		
		SimpleDateFormat reg = new SimpleDateFormat("yyyy-MM-dd");		
		List<Purchase> purchaseList = purchaseService.purchaseSearch(reg.format(date));	
		model.addAttribute("purchaseList",purchaseList);
		
		return jsonview;
	}
	
	@RequestMapping("adminAllPurchase.ps")
	public View allPurchase(Model model) {
		
		List<Purchase> purchaseList = purchaseService.purchaseList();
		model.addAttribute("purchaseList",purchaseList);
		return jsonview;
	}
	
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : userPurchase
	* 작성자명 : 정도혁
	* 기      능 : 구매 페이지
	*
	* @param model
	* @param userNo
	* @param picNo
	* @return String
	*/
	@RequestMapping("userPurchase.ps")
	public String userPurchase(Model model,int userNo, int picNo) {
		int result = purchaseService.insertCart(picNo, userNo);
		List<Picture> myCartList = purchaseService.selectCart(userNo);
		List<User> CartPhotographer = purchaseService.CartPhotographer(userNo);
		int total = purchaseService.cartTotal(userNo);
		
		model.addAttribute("total", total);
		model.addAttribute("result", result);
		model.addAttribute("photographerName",CartPhotographer);
		model.addAttribute("myCartList",myCartList);
		return "purchase.buy";
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : deleteItem
	* 작성자명 : 정도혁
	* 기      능 : 장바구니 품목 삭제
	*
	* @param model
	* @param userNo
	* @param picNo
	* @return View
	*/
	@RequestMapping("deleteItem.ps")
	public View deleteItem(Model model,int userNo, int picNo) {
		int result = purchaseService.deleteCart(picNo, userNo);
		if(result!=0) {
			System.out.println("삭제 완료");
		}else {
			System.out.println("삭제 실패");
		}
		model.addAttribute("result",result);
		return jsonview;
	}
	
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : buyPicture
	* 작성자명 : 정도혁
	* 기      능 : 장바구니에 담긴 사진 전체 구매
	*
	* @param purchases
	* @param session
	* @param model
	* @return String
	*/
	@RequestMapping("picturePurchase.ps")
	public String buyPicture(@ModelAttribute("PurchList") PurchList purchases, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		purchaseService.buyPicture(purchases.getPurchases()); //장바구니에 담긴 사진 전체 구매
		purchaseService.deleteCartAll(user.getUserNo());      //카트 전체 삭제
		if(user != null) {
			List<Picture> followingPicList = userService.followingUserPicList(user.getUserNo());
		    model.addAttribute("imagelist", followingPicList);
		}
		return "home.home";
	}
}
