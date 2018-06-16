package kr.or.picsion.operationapply.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.operationapply.dto.OperationApply;
import kr.or.picsion.operationapply.service.OperationApplyService;
import kr.or.picsion.user.dto.User;

@Controller
@RequestMapping("")
public class OperationApplyController {

	@Autowired
	private View jsonview;

	@Autowired
	private  OperationApplyService applyService;
	
	
	@RequestMapping(value = "apply.ps")
	public String insertOperationApply(OperationApply operationApply, HttpSession session) {
		User user = (User)session.getAttribute("user");
		System.out.println("insertoperation 컨트롤러");
		operationApply.setOperUserNo(user.getUserNo());
		System.out.println(operationApply);
		applyService.insertOperationApply(operationApply);
		return "board.boardInfo";
	}
}
