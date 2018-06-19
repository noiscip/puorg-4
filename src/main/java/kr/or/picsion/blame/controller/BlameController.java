package kr.or.picsion.blame.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.blame.dto.Blame;
import kr.or.picsion.blame.service.BlameService;

@Controller
@RequestMapping("/blame/")
public class BlameController {

	@Autowired
	private View jsonview;

	@Autowired
	private BlameService blameService;
	
	@RequestMapping("adminComplainList.ps")
	public String complain(Model model) {
		
		
		List<Blame> blameList = blameService.complain();
		model.addAttribute("blameList",blameList);
		return "admin.complain";
	}
	
	@RequestMapping("adminComplainSearch.ps")
	public View complainSearch(Date date, Model model) {
		System.out.println("complainSearch");
		System.out.println(date);
		
		SimpleDateFormat reg = new SimpleDateFormat("yyyy-MM-dd");		
		List<Blame> blameList = blameService.complainSearch(reg.format(date));	
		model.addAttribute("blameList",blameList);
		
		return jsonview;
	}
}
