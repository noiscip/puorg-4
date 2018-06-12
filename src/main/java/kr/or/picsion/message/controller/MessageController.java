package kr.or.picsion.message.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.message.dto.Message;
import kr.or.picsion.message.service.MessageService;

@Controller
@RequestMapping("/message/")
public class MessageController {

	@Autowired
	private View jsonview;
	
	@Autowired
	private MessageService messageService;
	
	//메시지 보내기
	@RequestMapping("send.ps")
	public View messageSend(Message message) {
		
		System.out.println("잘 받아왔나???" + message);
		/*Message send = */
				
		int result = messageService.sendMessage(message);
		
		if(result!=0) {
			System.out.println("메시지 보내기 성공!");
		}else {
			System.out.println("메시지 보내기 실패");
		}
		return jsonview;
	}
	
}
