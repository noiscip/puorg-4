package kr.or.picsion.board.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.board.service.BoardService;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.operation.dto.Operation;
import kr.or.picsion.operation.service.OperationService;
import kr.or.picsion.operationapply.dto.OperationApply;
import kr.or.picsion.operationapply.service.OperationApplyService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

@Controller
@RequestMapping("/board/")
public class BoardController {

	@Autowired
	private View jsonview;

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private OperationApplyService operationApplyService;
	
	@Autowired
	private OperationService operationService;
		
	@Autowired
	private UserService userService;
	
	@Autowired
	private CommentService commentService;

	@RequestMapping(value = "boardInfo.ps")
	public String selectBoard(int brdNo, Model model, HttpSession session) {
		System.out.println("보드인포 컨트롤");
		User user = (User)session.getAttribute("user");
		Board boardInfo = boardService.selectBoard(brdNo);
		Operation operation = new Operation();
		List<Comment> comment = commentService.commentList(brdNo);		
		List<User> commentuser= commentService.commentuser(brdNo);
		List<OperationApply> list = operationApplyService.operationApplyList(brdNo, user.getUserNo());
		List<String> applyid = operationApplyService.operationApplyNameList(brdNo);
		if(boardInfo.getOperStateNo()==2) {
			operation=operationService.selectOper(brdNo);
		}
		System.out.println(operation);
		model.addAttribute("operation", operation);
		model.addAttribute("commentuser", commentuser);
		model.addAttribute("applylist", list);
		model.addAttribute("applyid", applyid);		
		model.addAttribute("boardInfo", boardInfo);
		model.addAttribute("comment",comment);
		return "board.boardInfo";
	}
		
	
	
	
	@RequestMapping(value = "writeboard.ps", method = RequestMethod.POST)
	public String postwriteBoard(Board board, HttpSession session) {		
		User user = (User)session.getAttribute("user");
		Board inboard = board;
		System.out.println(board);
		inboard.setUserNo(user.getUserNo());
		inboard.setTableNo(3);
		inboard.setOperStateNo(1);
		System.out.println(inboard);
		boardService.insertBoard(inboard);
		return "board.writeBoard";
	}
		
	
	
	
	@RequestMapping(value = "writeboard.ps", method = RequestMethod.GET)
	public String getwriteBoard() {
		System.out.println("겟 보드");
		return "board.writeBoard";
	}
		
	
	@RequestMapping("board.ps")
	public String boardList(Model model) {
		System.out.println("요청게시판 컨트롤러");
		List<Board> list=new ArrayList<Board>();
		List<Operation> operlist=new ArrayList<Operation>();
		try {
			list = boardService.boardList();
			operlist=operationService.operBoardList();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(list);
		System.out.println(operlist);
		
		model.addAttribute("list", list);
		model.addAttribute("operlist", operlist);
		System.out.println("뷰단 보내기");
		return "board.board";
	}
	
	
}
