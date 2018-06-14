/**
 * 
 */
package kr.or.picsion.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.notice.service.NoticeService;

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
	public View noticeMsg() {
		System.out.println("과아아아아연");
		return jsonview;
	}
	
	
	
	
}
