package kr.or.picsion.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.board.service.BoardService;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.operation.dto.OperPicture;
import kr.or.picsion.operation.dto.Operation;
import kr.or.picsion.operation.service.OperPictureService;
import kr.or.picsion.operation.service.OperationService;
import kr.or.picsion.operationapply.dto.OperationApply;
import kr.or.picsion.operationapply.service.OperationApplyService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.board.controller 
 * @className BoardController
 * @date 2018. 6. 4.
 */

@Controller
@RequestMapping("/board/")
public class BoardController {

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

	@Autowired
	private OperPictureService operPictureService;
	
	/**
	 * 날      짜 : 2018. 6. 14. 
	 * 메소드명 : selectBoard 
	 * 작성자명 : 김준수 
	 * 기      능 : 요청게시판 상세보기
	 *
	 * @param brdNo
	 * @param model
	 * @param session
	 * @return String
	 */
	@RequestMapping(value = "boardInfo.ps")
	public String selectBoard(int brdNo, Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		Board boardInfo = boardService.selectBoard(brdNo);
		Operation operation = new Operation();
		List<Comment> comment = commentService.commentList(brdNo);
		List<User> commentuser = commentService.commentuser(brdNo);
		List<OperationApply> list = operationApplyService.operationApplyList(brdNo, user.getUserNo());
		List<String> applyid = operationApplyService.operationApplyNameList(brdNo);
		OperPicture operPicture = new OperPicture();
		if (boardInfo.getOperStateNo() != 1) {
			operation = operationService.selectOper(brdNo);
			operPicture = operPictureService.selectOperpicture(operation.getOperNo());
		}
		User requestUser = userService.userInfo(operation.getRequesterNo());
		User operatorUser = userService.userInfo(operation.getOperatorNo());
		model.addAttribute("operPicture", operPicture);
		model.addAttribute("operatorUser", operatorUser);
		model.addAttribute("requestUser", requestUser);
		model.addAttribute("operation", operation);
		model.addAttribute("commentuser", commentuser);
		model.addAttribute("applylist", list);
		model.addAttribute("applyid", applyid);
		model.addAttribute("boardInfo", boardInfo);
		model.addAttribute("comment", comment);
		return "board.boardInfo";
	}

	/**
	 * 날      짜 : 2018. 6. 15. 
	 * 메소드명 : postwriteBoard 
	 * 작성자명 : 김준수 
	 * 기      능 : 요청 글 작성
	 *
	 * @param board
	 * @param session
	 * @return String
	 */
	@RequestMapping(value = "writeboard.ps", method = RequestMethod.POST)
	@Transactional(propagation = Propagation.REQUIRED)    //글 작성 트랜잭션
	public String postwriteBoard(Board board, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		Board inboard = board;
		try {
			inboard.setUserNo(user.getUserNo());
			inboard.setTableNo(3);
			inboard.setOperStateNo(1);
			boardService.insertBoard(inboard);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/board/boardInfo.ps?brdNo="+inboard.getBrdNo();
	}

	/**
	 * 날      짜 : 2018. 6. 16. 
	 * 메소드명 : getwriteBoard 
	 * 작성자명 : 김준수 
	 * 기      능 : 요청글 작성 뷰단 보내기
	 *
	 * @return String
	 */
	@RequestMapping(value = "writeboard.ps", method = RequestMethod.GET)
	public String getwriteBoard() {
		return "board.writeBoard";
	}

	/**
	 * 날      짜 : 2018. 6. 19. 
	 * 메소드명 : boardList 
	 * 작성자명 : 김준수 
	 * 기      능 : 요청게시판 리스트
	 *
	 * @param model
	 * @return String
	 */
	@RequestMapping("board.ps")
	public String boardList(Model model) {
		List<Board> list = new ArrayList<Board>();
		List<Operation> operlist = new ArrayList<Operation>();
		list = boardService.boardList();
		operlist = operationService.operBoardList();
		model.addAttribute("list", list);
		model.addAttribute("operlist", operlist);
		return "board.board";
	}

}
