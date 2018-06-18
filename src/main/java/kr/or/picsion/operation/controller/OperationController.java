package kr.or.picsion.operation.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.board.service.BoardService;
import kr.or.picsion.operation.dto.Operation;
import kr.or.picsion.operation.service.OperationService;
import kr.or.picsion.operationapply.dto.OperationApply;

@Controller
public class OperationController {

	@Autowired
	private View jsonview;

	@Autowired
	private OperationService operationService;
	

	@Autowired
	private BoardService boardService;
	
	
	
	@RequestMapping(value="operok.ps")
	public View OperationApplyok(Operation operation, Model model) {
		System.out.println("OperationApplyok컨트롤러");
		System.out.println(operation);
		
		Board board = boardService.selectBoard(operation.getBrdNo());
		board.setBrdExpectPrice(operation.getOperPrice());
		board.setBrdExpectEndDate(operation.getOperEndReg());
		board.setOperStateNo(2);
		boardService.updateBoard(board);
		int result=operationService.insertOperation(operation);
		model.addAttribute("check", result);
		return jsonview	;
	}
		
}
