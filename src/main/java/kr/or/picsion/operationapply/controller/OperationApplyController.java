package kr.or.picsion.operationapply.controller;

import java.util.HashMap;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;


import kr.or.picsion.notice.service.NoticeService;
import kr.or.picsion.operationapply.dto.OperationApply;
import kr.or.picsion.operationapply.service.OperationApplyService;
import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.operationapply.controller 
 * @className OperationApplyController
 * @date 2018. 6. 4.
 */

@Controller
@RequestMapping("/operationApply/")
public class OperationApplyController {

	@Autowired
	private View jsonview;

	@Autowired
	private OperationApplyService applyService;

	@Autowired
	private NoticeService noticeService;

	/**
	 * 날 짜 : 2018. 6. 29. 메소드명 : insertOperationApply 작성자명 : 김준수 기 능 : 요청게시판 작업 신청
	 *
	 * @param operationApply
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "apply.ps")
	public View insertOperationApply(OperationApply operationApply, HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		String check="false";
		System.out.println("insertoperation 컨트롤러");
		operationApply.setOperUserNo(user.getUserNo());
		if(applyService.countOperationApply(operationApply)==1) {
			System.out.println("이미 초대 했음");
		}else {
			int result = applyService.insertOperationApply(operationApply);
	
			if (result == 1) {
				HashMap<String, Object> noticeMap = new HashMap<String, Object>();
	
				noticeMap.put("no", operationApply.getBrdNo());
				noticeMap.put("addNo", operationApply.getOperApplyNo());
				noticeMap.put("receiveUserNo", operationApply.getRequestUserNo());
				noticeMap.put("sendUserNo", operationApply.getOperUserNo());
				noticeMap.put("table", "brdNo, operApplyNo");
				noticeMap.put("tableNo", 3);
	
				noticeService.insertNotice(noticeMap);
			}
			check="true";
		}

		model.addAttribute("check", check);
		return jsonview;
	}

}
