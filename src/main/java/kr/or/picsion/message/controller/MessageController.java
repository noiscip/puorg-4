package kr.or.picsion.message.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.message.service.MessageService;

@Controller
@RequestMapping("")
public class MessageController {

	@Autowired
	private View jsonview;
	
	@Autowired
	private MessageService messageService;
}
