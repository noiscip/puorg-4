package kr.or.picsion.blame.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.blame.dto.Blame;
import kr.or.picsion.blame.service.BlameService;
import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.blame.controller 
 * @className BlameController
 * @date 2018. 6. 4.
 */

@Controller
@RequestMapping("/blame/")
public class BlameController {

	@Autowired
	private View jsonview;

	@Autowired
	private BlameService blameService;

	/**
	 * 날      짜 : 2018. 6. 15.
	 * 메소드명 : complain
	 * 작성자명 : 김보경
	 * 기      능 : 관리자, 전체 신고 리스트 조회해서 신고 페이지로 이동
	 * 
	 * @param model
	 * @return String
	*/
	@RequestMapping("adminComplainList.ps")
	public String complain(Model model) {
		
		List<Blame> blameList = blameService.complain();
		model.addAttribute("blameList",blameList);
		return "admin.complain";
	}
	
	/**
	 * 날      짜 : 2018. 6. 19.
	 * 메소드명 : complainSearch
	 * 작성자명 : 김보경
	 * 기      능 : 관리자, 신고 기간으로 조회
	 *
	 * @param date
	 * @param model
	 * @return View
	*/
	@RequestMapping("adminComplainSearch.ps")
	public View complainSearch(Date date, Model model) {
		SimpleDateFormat reg = new SimpleDateFormat("yyyy-MM-dd");		
		List<Blame> blameList = blameService.complainSearch(reg.format(date));	
		model.addAttribute("blameList",blameList);
		
		return jsonview;
	}
	
	/**
	 * 날      짜 : 2018. 6. 15.
	 * 메소드명 : allComplain
	 * 작성자명 : 김보경
	 * 기      능 : 관리자, 비동기로 전체 신고 리스트 조회
	 *
	 * @param model
	 * @return View
	*/
	@RequestMapping("adminAllComplain.ps")
	public View allComplain(Model model) {
		List<Blame> blameList = blameService.complain();
		model.addAttribute("blameList",blameList);
		return jsonview;
	}
	
	/**
	 * 날      짜 : 2018. 6. 15.
	 * 메소드명 : complainInsert
	 * 작성자명 : 아윤근
	 * 기      능 : 신고 추가 
	 *
	 * @param blame
	 * @param session
	 * @param model
	 * @return View
	*/
	@RequestMapping("complainInsert.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public View complainInsert(Blame blame, HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		int result=0;
		try {
			blame.setBlaUserNo(user.getUserNo());
			result = blameService.complainInsert(blame);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("result", result);
		return jsonview;
	}
	
	
	
}
