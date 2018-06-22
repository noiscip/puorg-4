package kr.or.picsion.purchase.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.blame.dto.Blame;
import kr.or.picsion.purchase.dto.Purchase;
import kr.or.picsion.purchase.service.PurchaseService;

@Controller
@RequestMapping("/purchase/")
public class PurchaseController {

	@Autowired
	private View jsonview;

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
}
