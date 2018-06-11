package kr.or.picsion.operationapply.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.operationapply.service.OperationApplyService;

@Controller
@RequestMapping("")
public class OperationApplyController {

	@Autowired
	private View jsonview;

	@Autowired
	private  OperationApplyService applyService;
}
