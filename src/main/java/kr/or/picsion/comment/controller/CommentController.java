package kr.or.picsion.comment.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.comment.service.CommentService;

@Controller
@RequestMapping("")
public class CommentController {

	@Autowired
	private View jsonview;

	@Autowired
	private CommentService commentService;
}
