package kr.or.picsion.operation.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import kr.or.picsion.operation.service.OperationService;
import kr.or.picsion.operationapply.dto.OperationApply;

@Controller
public class OperationController {

	@Autowired
	private View jsonview;

	@Autowired
	private OperationService operationService;
	
	
	
	@RequestMapping(value="operok.ps")
	public String OperationApplyok(OperationApply operationApply, HttpSession session) {
		System.out.println("OperationApplyok컨트롤러");
		System.out.println(operationApply);
		return "board.boardInfo";
	}
		
}
