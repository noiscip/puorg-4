package kr.or.picsion.blame.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.blame.service.BlameService;

@Controller
@RequestMapping("")
public class BlameController {

	@Autowired
	private View jsonview;

	@Autowired
	private BlameService blameService;
}
