package kr.or.picsion.purchase.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.purchase.dto.PurchList;
import kr.or.picsion.purchase.dto.Purchase;
import kr.or.picsion.purchase.service.PurchaseService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.purchase.controller 
 * @className PurchaseController
 * @date 2018. 6. 4.
 */

@Controller
@RequestMapping("/purchase/")
public class PurchaseController {

	@Autowired
	private View jsonview;
	
	@Autowired
	private PurchaseService purchaseService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("adminPurchase.ps")
	public String purchase(Model model) {
		
		List<Purchase> purchaseList = purchaseService.purchaseList();
		model.addAttribute("purchaseList",purchaseList);
		return "admin.purchase";
	}
	
	@RequestMapping("adminPurchaseSearch.ps")
	public View purchaseSearch(Date date, Model model) {
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
	public String userPurchase(Model model,int userNo, int picNo,  HttpSession session) {
		User user = (User) session.getAttribute("user");
		int check = purchaseService.cartConfirm(userNo, picNo);
		int buycheck = purchaseService.purchaseConfirm(userNo, picNo);
		if(check==0 && buycheck==0) {
			purchaseService.insertCart(picNo, userNo);
		}
		List<Picture> myCartList = purchaseService.selectCart(userNo);
		List<User> CartPhotographer = purchaseService.CartPhotographer(userNo);
		int total = purchaseService.cartTotal(userNo);
		model.addAttribute("user",user);
		model.addAttribute("total", total);
		model.addAttribute("photographerName",CartPhotographer);
		model.addAttribute("myCartList",myCartList);
		return "purchase.buy";
	}
	
	/**
	* 날      짜 : 2018. 7. 3.
	* 메소드명 : salesStatistics
	* 작성자명 : 김보경
	* 기      능 : 기간별 매출 보기
	*
	* @param startDate
	* @param endDate
	* @param model
	* @return
	*/
	@RequestMapping("salesAmount.ps")
	public View salesStatistics(Date startDate, Date endDate, Model model) {
		
		Map<Integer, List<Object>> map = purchaseService.salesStatistics(startDate,endDate);
		model.addAttribute("map",map);
		return jsonview; 
	}
	
	/**
	* 날      짜 : 2018. 7. 12.
	* 메소드명 : maySalesStatistics
	* 작성자명 : 김준수 
	* 기      능 : 개인별 매출 보기
	*
	* @param startDate
	* @param endDate
	* @param userNo
	* @param model
	* @return
	*/
	@RequestMapping("mySalesAmount.ps")
	public View mySalesStatistics(Date startDate, Date endDate, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		Map<Integer, List<Object>> map = purchaseService.mySalesStatistics(startDate,endDate,user.getUserNo());
		model.addAttribute("map",map);
		return jsonview; 
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
	@Transactional(propagation = Propagation.REQUIRED)
	public View deleteItem(Model model,int userNo, int picNo) {
		int result = 0;
		try {
			result = purchaseService.deleteCart(picNo, userNo);
			if(result!=0) { //삭제 완료
				int again = purchaseService.cartCount(userNo);
				model.addAttribute("again",again);
			}else {  //삭제 실패
			}
		} catch (Exception e) {
			e.printStackTrace();
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
	@Transactional(propagation = Propagation.REQUIRED) // 트랜잭션으로 예외 발생시 결제와 포인트 반환
	public String buyPicture(@ModelAttribute("PurchList") PurchList purchases, HttpSession session, Model model, int point) {
		User user = (User) session.getAttribute("user");
		String view = "redirect:";
		if(user != null) {
			try {
			    purchaseService.buyPicture(purchases.getPurchases()); //장바구니에 담긴 사진 전체 구매
			    purchaseService.updatePoint(point, user.getUserNo()); //구매자 포인트 변경
			    purchaseService.updateSalePoint(purchases.getPurchases()); //판매자 포인트 변경
				purchaseService.deleteCartAll(user.getUserNo());      //카트 전체 삭제
				session.setAttribute("user", userService.userInfo(user.getUserNo()));
				view += "/purchase/history.ps";
			} catch (Exception e) {
				e.printStackTrace();
				view +=  "/home.ps";
			}
		}
		return view;
	}
	
	
	/**
	* 날      짜 : 2018. 7. 3.
	* 메소드명 : buyHistory
	* 작성자명 : 박주원
	* 기      능 : 구매내역 페이지 이동
	*
	* @return String
	*/
	@RequestMapping("history.ps")
	public String buyHistory(HttpSession session, Model model, String pg) {
		User user = (User) session.getAttribute("user");
		
        int total=0;
        
        int page = 1;
        String Strpg = pg;
        if (Strpg != null) {
            page = Integer.parseInt(Strpg);
        }

        int rowSize = 5;
        int start = (page * rowSize) - (rowSize - 1) - 1;

        total = purchaseService.getPurCount(user.getUserNo());

        int allPage = (int) Math.ceil(total / (double) rowSize); // 페이지수
        int block = 5; // 한페이지에 보여줄 범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9]
        int fromPage = ((page - 1) / block * block) + 1; // 보여줄 페이지의 시작
        int toPage = ((page - 1) / block * block) + block; // 보여줄 페이지의 끝
        if (toPage > allPage) { // 예) 20>17
            toPage = allPage;
        }

		List<Picture> pictureInfo = purchaseService.selectPicPurchase(user.getUserNo(), start, rowSize);
		List<User> userInfo = purchaseService.selectPicUser(user.getUserNo(), start, rowSize);
		List<Purchase> purchaseInfo = purchaseService.selectPurchase(user.getUserNo(), start, rowSize);
		int sumPurchase = purchaseService.sumPurchase(user.getUserNo());
		
		model.addAttribute("pictureInfo", pictureInfo);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("purchaseInfo", purchaseInfo);
		model.addAttribute("sumPurchase", sumPurchase);
		
        model.addAttribute("pg", page);
        model.addAttribute("allPage", allPage);
        model.addAttribute("block", block);
        model.addAttribute("fromPage", fromPage);
        model.addAttribute("toPage", toPage);
		
		return "mypage.buyhistory";
	}
	
	
	/**
	* 날      짜 : 2018. 7. 3.
	* 메소드명 : sellHistory
	* 작성자명 : 박주원
	* 기      능 : 판매내역 페이지 이동
	*
	* @param session
	* @param model
	* @return String
	*/
	@RequestMapping("sellhistory.ps")
	public String sellHistory(HttpSession session, Model model, String pg){
		User user = (User) session.getAttribute("user");
		int total=0;
        int page = 1;
        String Strpg = pg;
        if (Strpg != null) {
            page = Integer.parseInt(Strpg);
        }

        int rowSize = 5;
        int start = (page * rowSize) - (rowSize - 1) - 1;

        total = purchaseService.getSaleCount(user.getUserNo());

        int allPage = (int) Math.ceil(total / (double) rowSize); // 페이지수
        int block = 5; // 한페이지에 보여줄 범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9]
        int fromPage = ((page - 1) / block * block) + 1; // 보여줄 페이지의 시작
        int toPage = ((page - 1) / block * block) + block; // 보여줄 페이지의 끝
        if (toPage > allPage) { // 예) 20>17
            toPage = allPage;
        }
        
		List<Picture> pictureInfo=purchaseService.selectPicSell(user.getUserNo(), start, rowSize);
		List<User> userInfo = purchaseService.selectPicPurUser(user.getUserNo(), start, rowSize);
		List<Purchase> purchaseInfo = purchaseService.selectSell(user.getUserNo(), start, rowSize);
		int sumSell= purchaseService.sumSell(user.getUserNo());
		
		model.addAttribute("pictureInfo", pictureInfo);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("purchaseInfo", purchaseInfo);
		model.addAttribute("sumSell", sumSell);
		
		model.addAttribute("pg", page);
        model.addAttribute("allPage", allPage);
        model.addAttribute("block", block);
        model.addAttribute("fromPage", fromPage);
        model.addAttribute("toPage", toPage);
		
		return "mypage.sellhistory";
	}

	
	/**
	* 날      짜 : 2018. 7. 3.
	* 메소드명 : addCart
	* 작성자명 : 정도혁
	* 기      능 : 장바구니에 물건 담고 빼기
	*
	* @param model
	* @param userNo
	* @param picNo
	* @return View
	*/
	@RequestMapping("addCart.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public View addCart(Model model,int userNo, int picNo) {
		try {
			int result = purchaseService.cartConfirm(userNo, picNo);
			if(result!=0) {	 //장바구니에 담겨 있을때 -> 장바구니에서 삭제
				purchaseService.deleteCart(picNo, userNo);
				int again = purchaseService.cartCount(userNo);
				model.addAttribute("again",again);
			}else {	//장바구니에 없을때 -> 장바구니에 추가
				int count = purchaseService.cartCount(userNo);
				model.addAttribute("count",count);
				purchaseService.insertCart(picNo, userNo);
			}
			model.addAttribute("result",result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonview;
	}
	
	
	/**
	* 날      짜 : 2018. 7. 4.
	* 메소드명 : myCart
	* 작성자명 : 정도혁
	* 기      능 : 헤더에 장바구니 확인
	*
	* @param model
	* @param userNo
	* @return View
	*/
	@RequestMapping("myCart.ps")
	public View myCart(Model model, int userNo) {
		List<Picture> cartPicList =  purchaseService.selectCart(userNo);
		int count = purchaseService.cartCount(userNo);
		model.addAttribute("cartPicList",cartPicList);
		model.addAttribute("myCartCount",count);
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 7. 4.
	* 메소드명 : myCartPage
	* 작성자명 : 정도혁
	* 기      능 : 유저번호로 장바구니 페이지로 이동
	*
	* @param model
	* @param userNo
	* @return String
	*/
	@RequestMapping("myCartPage.ps")
	public String myCartPage(Model model, int userNo, HttpSession session) {
		User user = (User) session.getAttribute("user");
		List<Picture> myCartList = purchaseService.selectCart(userNo);
		List<User> CartPhotographer = purchaseService.CartPhotographer(userNo);
		int total = purchaseService.cartTotal(userNo);
		model.addAttribute("user",user);
		model.addAttribute("total", total);
		model.addAttribute("photographerName",CartPhotographer);
		model.addAttribute("myCartList",myCartList);
		return "purchase.buy";
	}
	
}
