package kr.or.picsion.message.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
		User user = (User)session.getAttribute("user");
		
		//받은 메시지에 대한 정보
		List<Message> receiveList = messageService.receiveMessageList(user.getUserNo());
		List<User> receiveInfo = messageService.receiveMessageInfo(user.getUserNo());
		List<String> receiveMsgReg = new ArrayList<>();
		
		java.text.SimpleDateFormat reg = new java.text.SimpleDateFormat("yy-MM-dd HH:mm");
		for(Message m : receiveList) {
			receiveMsgReg.add(reg.format(m.getMsgReg()));
		}
		
		//보낸 메시지에 대한 정보
		List<Message> sendList = messageService.sendMessageList(user.getUserNo());
		List<User> sendInfo = messageService.sendMessageInfo(user.getUserNo());
		List<String> sendMsgReg = new ArrayList<>();
		
		for(Message m : sendList) {
			sendMsgReg.add(reg.format(m.getMsgReg()));
		}
		
		model.addAttribute("receiveList", receiveList);
		model.addAttribute("receiveInfo", receiveInfo);
		model.addAttribute("receiveMsgReg", receiveMsgReg);
		
		model.addAttribute("sendList", sendList);
		model.addAttribute("sendInfo", sendInfo);
		model.addAttribute("sendMsgReg", sendMsgReg);
		
		/*model.addAttribute("receiveMap", receiveMap);*/
		
		return "mypage.message";
	}
	
	//메시지 확인시 messageState update
	@RequestMapping("stateup.ps")
	public View messageState(String msgNo, String msgState, Model model) {
		int result =0;
		
		if(msgState.equals("안읽음")) {
			result = messageService.messageState(Integer.parseInt(msgNo));
		}
		
		model.addAttribute("result", result);
		
		return jsonview;
	}
	
	//받은 메시지함에서 메시지 삭제
	@RequestMapping("receivedel.ps")
	public View receiveMessageDel(String msgNo, Model model) {
		int result = messageService.receiveMessageDel(Integer.parseInt(msgNo));
		
		model.addAttribute("result", result);
		
		return jsonview;
	}
	
	
	//보낸 메시지함에서 메시지 삭제
	@RequestMapping("senddel.ps")
	public View sendMessageDel(String msgNo, Model model) {
		int result = messageService.sendMessageDel(Integer.parseInt(msgNo));
		
		model.addAttribute("result", result);
		
		return jsonview;
	}
	
	
	//받은 메시지함에서 userName으로 메시지 검색
	@RequestMapping("receiveselect.ps")
	public View receiveSelect(String userName, HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		
		//받은 메시지에 대한 정보
		List<Message> receiveSelect = messageService.selectReceiveMsg(user.getUserNo(), userName);
		List<User> receiveSelInfo = messageService.selectReceiveInfo(user.getUserNo(), userName);
		List<String> receiveSelReg = new ArrayList<>();
		
		java.text.SimpleDateFormat reg = new java.text.SimpleDateFormat("yy-MM-dd HH:mm");
		for(Message m : receiveSelect) {
			receiveSelReg.add(reg.format(m.getMsgReg()));
		}
		
		model.addAttribute("receiveSelect", receiveSelect);
		model.addAttribute("receiveSelInfo", receiveSelInfo);
		model.addAttribute("receiveSelReg", receiveSelReg);
		
		return jsonview;
	}
	
	
	//보낸 메시지함에서 userName으로 메시지 검색
	@RequestMapping("sendselect.ps")
	public View sendSelect(String userName, HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		
		//보낸 메시지에 대한 정보
		List<Message> sendSelect = messageService.selectSendMsg(user.getUserNo(), userName);
		List<User> sendSelInfo = messageService.selectSendInfo(user.getUserNo(), userName);
		List<String> sendSelReg = new ArrayList<>();
		
		java.text.SimpleDateFormat reg = new java.text.SimpleDateFormat("yy-MM-dd HH:mm");
		for(Message m : sendSelect) {
			sendSelReg.add(reg.format(m.getMsgReg()));
		}
		
		model.addAttribute("sendSelect", sendSelect);
		model.addAttribute("sendSelInfo", sendSelInfo);
		model.addAttribute("sendSelReg", sendSelReg);
		
		return jsonview;
	}
	
}
