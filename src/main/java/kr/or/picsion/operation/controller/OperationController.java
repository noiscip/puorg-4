package kr.or.picsion.operation.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.board.service.BoardService;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.notice.service.NoticeService;
import kr.or.picsion.operation.dto.Operation;
import kr.or.picsion.operation.service.OperPictureService;
import kr.or.picsion.operation.service.OperationService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.operation.controller 
 * @className OperationController
 * @date 2018. 6. 4.
 */

@Controller
@RequestMapping("/operation/")
public class OperationController {

	@Autowired
	private View jsonview;

	@Autowired
	private OperationService operationService;
	
	@Autowired
	private OperPictureService operPictureService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private CommentService commentService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private NoticeService noticeService;

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : OperationApplyok 
	 * 작성자명 : 김준수 
	 * 기 능 : 작업 신청 수락
	 *
	 * @param operation
	 * @param model
	 * @return View
	 */
	@RequestMapping(value = "operok.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public View OperationApplyok(Operation operation, Model model) {
		int result=0;
		User user = userService.userInfo(operation.getRequesterNo());
		try {
			if(operationService.selectOper(operation.getBrdNo())==null) 
			{
				Board board = boardService.selectBoard(operation.getBrdNo());
				board.setBrdExpectPrice(operation.getOperPrice());
				board.setBrdExpectEndDate(operation.getOperEndReg());
				board.setOperStateNo(2);
				commentService.deleteAllComment(board.getBrdNo());
				boardService.updateBoard(board);
				operation.setStep(1);
				result = operationService.insertOperation(operation);
				
				userService.pointCharge((-1*board.getBrdExpectPrice()), user.getUserNo());
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

			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("check", result);
		return jsonview;
	}

	/**
	 * 날 짜 : 2018. 6. 29. 
	 * 메소드명 : operRequest 
	 * 작성자명 : 김준수 
	 * 기 능 : 요청, 작업 리스트
	 *
	 * @param session
	 * @param model
	 * @param operStateNo
	 * @return String
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
	
	
	/**
	* 날      짜 : 2018. 7. 4.
	* 메소드명 : operComplete
	* 작성자명 : 김준수 
	* 기      능 : 사진 작업 완료
	* 
	* @param model
	* @param brdNo
	* @return View
	*/
	@RequestMapping(value = "opercomplete.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public View operComplete(HttpSession session, Model model,Operation oper) {
		try {
			Operation operation = operationService.selectOper(oper.getBrdNo());
			System.out.println(operation);
			operation.setRequesterEnd("T");
			operation.setStep(2);
			operationService.updateOperation(operation);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return jsonview;
	}
	
	
	
	/**
	* 날      짜 : 2018. 7. 12.
	* 메소드명 : operPictureCancle
	* 작성자명 : 김준수 
	* 기      능 : 작업 취소
	*
	* @param operNo
	* @param model
	* @return
	*/
	@RequestMapping(value = "operPictureCancle.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public View operPictureCancle(int operNo, Model model) {
		int result = operPictureService.operPictureCancle(operNo);		
		model.addAttribute("result", result);		
		return jsonview;
	}
}
