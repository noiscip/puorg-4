package kr.or.picsion.operation.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.board.service.BoardService;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.notice.service.NoticeService;
import kr.or.picsion.operation.dto.Operation;
import kr.or.picsion.operation.service.OperationService;
import kr.or.picsion.user.dto.User;

@Controller
@RequestMapping("/operation/")
public class OperationController {

	@Autowired
	private View jsonview;

	@Autowired
	private OperationService operationService;

	@Autowired
	private CommentService commentService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private NoticeService noticeService;

	/**
	 * 날 짜 : 2018. 6. 29. 메소드명 : OperationApplyok 작성자명 : 김준수 기 능 : 작업 신청 수락
	 *
	 * @param operation
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "operok.ps")
	public View OperationApplyok(Operation operation, Model model) {
		System.out.println("OperationApplyok컨트롤러");
		System.out.println(operation);

		Board board = boardService.selectBoard(operation.getBrdNo());
		board.setBrdExpectPrice(operation.getOperPrice());
		board.setBrdExpectEndDate(operation.getOperEndReg());
		board.setOperStateNo(2);
		commentService.deleteAllComment(board.getBrdNo());
		boardService.updateBoard(board);

		System.out.println(operation);
		int result = operationService.insertOperation(operation);
		System.out.println("두번째");
		System.out.println(operation);

		if (result != 0) {
			HashMap<String, Object> noticeMap = new HashMap<String, Object>();

			noticeMap.put("no", operation.getBrdNo());
			noticeMap.put("addNo", operation.getOperNo());
			noticeMap.put("receiveUserNo", operation.getOperatorNo());
			noticeMap.put("sendUserNo", operation.getRequesterNo());
			noticeMap.put("table", "brdNo, operNo");
			noticeMap.put("tableNo", 3);

			noticeService.insertNotice(noticeMap);
		}

		model.addAttribute("check", result);
		return jsonview;
	}

	/**
	 * 날 짜 : 2018. 6. 29. 메소드명 : operRequest 작성자명 : 김준수 기 능 : 요청, 작업 리스트
	 *
	 * @param session
	 * @param model
	 * @param operStateNo
	 * @return
	 */
	@RequestMapping(value = "operequest.ps")
	public String operRequest(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");

		model.addAttribute("requestList", operationService.requestList(user.getUserNo()));
		model.addAttribute("requestBoardList", boardService.requestBoardList(user.getUserNo()));
		model.addAttribute("operationList", operationService.operationList(user.getUserNo()));
		model.addAttribute("operationBoardList", boardService.operationBoardList(user.getUserNo()));
		return "mypage.operequest";
	}

}
