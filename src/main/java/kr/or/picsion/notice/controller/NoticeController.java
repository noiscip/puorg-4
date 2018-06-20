/**
 * 
 */
package kr.or.picsion.notice.controller;

import java.util.Map;

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
	
	/**
	 * 날      짜 : 2018. 6. 19.
	 * 메소드명 : noticeList
	 * 작성자명 : 아윤근
	 *
	 * @param session
	 * @param model
	 * @return
	*/
	@RequestMapping("notice.ps")
	public View noticeList(HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		
		Map<Integer, Object> map = noticeService.noticeList(user.getUserNo());
		model.addAttribute("map",map);
		
		return jsonview;
	}
	
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
