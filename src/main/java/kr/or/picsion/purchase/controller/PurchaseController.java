package kr.or.picsion.purchase.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.purchase.service.PurchaseService;

@Controller
@RequestMapping("")
public class PurchaseController {

	@Autowired
	private View jsonview;

	@Autowired
	private PurchaseService purchaseService;
}
