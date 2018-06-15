package kr.or.picsion.message.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import com.sun.javafx.collections.MappingChange.Map;

import kr.or.picsion.message.dto.Message;
import kr.or.picsion.message.service.MessageService;
import kr.or.picsion.user.dto.User;

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
	
	//받은 메시지 리스트 
	@RequestMapping("receivemessage.ps")
	public String receiveMessage(HttpSession session, Model model) {
		System.out.println("receiveMessage 컨트롤~~");
		User user = (User)session.getAttribute("user");
		
		List<Message> receiveList = messageService.receiveMessageList(user.getUserNo());
		List<User> receiveInfo = messageService.receiveMessageInfo(user.getUserNo());
		
		/*HashMap<String, Object> receiveMap = new HashMap<String, Object>();
		
		receiveMap.put("receiveList", receiveList);
		receiveMap.put("receiveInfo", receiveInfo);
		
		System.out.println("****************************Map은????"+receiveMap);*/
		
		model.addAttribute("receiveList", receiveList);
		model.addAttribute("receiveInfo", receiveInfo);
		
		/*model.addAttribute("receiveMap", receiveMap);*/
		
		return "mypage.message";
	}
}
