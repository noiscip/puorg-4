/**
 * 
 */
package kr.or.picsion.notice.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.notice.service.NoticeService;
import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.notice.controller 
 * @className NoticeController
 * @date 2018. 6. 14.
 */

@Controller
@RequestMapping("/notice/")
public class NoticeController {

	@Autowired
	private View jsonview;

	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("noticeMsg.ps")
	public View noticeMsg(HttpSession session,Model model) {
		User user = (User)session.getAttribute("user");
		
		int count = noticeService.readCheckCount(user.getUserNo());
		
		model.addAttribute("count",count);
		
		return jsonview;
	}

	@RequestMapping("noticeComment.ps")
	public View noticeComment(HttpSession session, Model model) {
		
		return jsonview;
	}
	
	
	
}
