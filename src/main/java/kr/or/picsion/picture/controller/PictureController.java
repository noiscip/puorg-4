package kr.or.picsion.picture.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.picture.service.PictureService;

@Controller
@RequestMapping("")
public class PictureController {

	@Autowired
	private View jsonview;

	@Autowired
	private PictureService pictureService;
}
