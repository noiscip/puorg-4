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
		Operation operation = null;
		List<Comment> comment = commentService.commentList(brdNo);		
		List<User> commentuser= commentService.commentuser(brdNo);
		List<OperationApply> list = operationApplyService.operationApplyList(brdNo, user.getUserNo());
		List<String> applyid = operationApplyService.operationApplyNameList(brdNo);
		if(boardInfo.getOperStateNo()==2) {
			operation=operationService.selectOper(brdNo);
		}
		
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
	public String boardList(Model model, String pg) {
		System.out.println("요청게시판 컨트롤러");
		List<Board> list=new ArrayList<Board>();
		List<Operation> operlist=new ArrayList<Operation>();
		int total=0;
		
		int page = 1;
		String Strpg = pg;
		if (Strpg != null) {
			page = Integer.parseInt(Strpg);
		}

		int rowSize = 5;
		int start = (page * rowSize) - (rowSize - 1);
		int end = page * rowSize;

		
		total = boardService.getBoardCount();

		System.out.println("start : " + start);
		System.out.println("end : " + end);
		System.out.println("total : " + total);

		// ... 목록
		int allPage = (int) Math.ceil(total / (double) rowSize); // 페이지수
		// int totalPage = total/rowSize + (total%rowSize==0?0:1);
		System.out.println("페이지수 : " + allPage);

		int block = 5; // 한페이지에 보여줄 범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9]
		// [10] >>
		int fromPage = ((page - 1) / block * block) + 1; // 보여줄 페이지의 시작
		// ((1-1)/10*10)
		int toPage = ((page - 1) / block * block) + block; // 보여줄 페이지의 끝
		if (toPage > allPage) { // 예) 20>17
			toPage = allPage;
		}

		// start , end
		HashMap<String, Integer> map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		try {
			list = boardService.boardList(map);
			operlist=operationService.operBoardList(map);
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(operlist);
		
		model.addAttribute("list", list);
		model.addAttribute("operlist", operlist);
		model.addAttribute("pg", page);
		model.addAttribute("allPage", allPage);
		model.addAttribute("block", block);
		model.addAttribute("fromPage", fromPage);
		model.addAttribute("toPage", toPage);	
		System.out.println("뷰단 보내기");
		return "board.board";
	}
	
	
}
