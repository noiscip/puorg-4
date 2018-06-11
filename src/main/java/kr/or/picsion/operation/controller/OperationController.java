package kr.or.picsion.operation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.operation.service.OperationService;

@Controller
@RequestMapping("")
public class OperationController {

	@Autowired
	private View jsonview;

	@Autowired
	private OperationService operationService;
}
