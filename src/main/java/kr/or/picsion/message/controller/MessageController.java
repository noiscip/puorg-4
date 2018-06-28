package kr.or.picsion.message.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import com.amazonaws.services.appstream.model.Session;

import kr.or.picsion.message.dto.Message;
import kr.or.picsion.message.service.MessageService;
import kr.or.picsion.notice.service.NoticeService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

@Controller
@RequestMapping("/message/")
public class MessageController {

	@Autowired
	private View jsonview;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private UserService userService;
	
	//메시지 보내기
	@RequestMapping("send.ps")
	public View messageSend(Message message, Model model) {
		int result = messageService.sendMessage(message);
		User userinfo = userService.userInfo(message.getReceiveUserNo());
		
		if(result != 0) {
			System.out.println("메시지 보내기 성공!");
			
			HashMap<String, Object> noticeMap = new HashMap<String, Object>();
			
			noticeMap.put("no", message.getMsgNo());
			noticeMap.put("receiveUserNo", message.getReceiveUserNo());
			noticeMap.put("sendUserNo", message.getSendUserNo());
			noticeMap.put("table", "msgNo");
			noticeMap.put("tableNo", message.getTableNo());
			
			model.addAttribute("message", message);
			model.addAttribute("userinfo", userinfo);
			
			noticeService.insertNotice(noticeMap);
		}else {
			System.out.println("메시지 보내기 실패");
		}
		
		
		return jsonview;
	}
	
	//메시지 읽어오기 (socket)
	@RequestMapping("readmsg.ps")
	public View messageRead(HttpSession session, Message message, Model model) {
		System.out.println("리드메시지 컨트롤러~");
		System.out.println(message);
		User userinfo = userService.userInfo(message.getSendUserNo());
		Message msginfo = messageService.messageInfo(message.getMsgNo());
		System.out.println("********"+msginfo);
		model.addAttribute("userinfo", userinfo);
		model.addAttribute("msginfo", msginfo);
		
		return jsonview;
	}
	
	
	
	//메시지 리스트  6.21
	@RequestMapping("receivemessage.ps")
	public String receiveMessage(HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		
		List<Message> messageAll = messageService.messageAll(user.getUserNo());
		System.out.println("리시브 메시지 와라~~~~~99-----------------------------------");
		
		Map<Integer, Message> map = new HashMap<>();
		
		//메시지 검색해서 가져온거 id 중복제거를 하고 가장 최신 메시지만 담음
		for (Message m : messageAll) {
			map.put(m.getReceiveUserNo(), m);
			map.put(m.getSendUserNo(), m);
		}
		
		System.out.println(map.keySet());
		map.remove(user.getUserNo());
		System.out.println(map.keySet());
		
		List<Message> recentMsg = new ArrayList<>();
		
		Set<Map.Entry<Integer, Message>> ent = map.entrySet();
		Iterator<Map.Entry<Integer, Message>> i = ent.iterator();
		while(i.hasNext()) {
			Map.Entry<Integer, Message> ma = i.next();
			recentMsg.add(ma.getValue());
		}
		
		Collections.sort(recentMsg, new Comparator<Message>() {
			@Override
			public int compare(Message o1, Message o2) {
				if (o1.getMsgNo() < o2.getMsgNo()) {
					return 1;
				} else if (o1.getMsgNo() > o2.getMsgNo()) {
					return -1;
				}else {
					return 0;
				}
			}
		});
		
		model.addAttribute("recentMsg", recentMsg);
		
		for (Message m : recentMsg) {
			System.out.println(m);
		}
		
		return "mypage.message";
	}
	
	//한 회원과 주고받은 메시지 리스트 뽑아오기 6.22
	@RequestMapping("msglist.ps")
	public View messageList(int userNo, HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		List<Message> msgList = messageService.messageList(user.getUserNo(), userNo);
		
		model.addAttribute("msgList", msgList);
		
		return jsonview;
	}
	
	//한 회원의 메시지 목록을 모두 삭제
	@RequestMapping("msgdel.ps")
	public View messageDel(int userNo, HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		
		int reResult=messageService.receiveDel(user.getUserNo(), userNo);
		int seResult=messageService.sendDel(user.getUserNo(), userNo);
		
		if(reResult!=0&&seResult!=0) {
			System.out.println("둘다 삭제 완료");
		}
		
		model.addAttribute("reResult", reResult);
		model.addAttribute("seResult", seResult);
		
		return jsonview;
	}
	
	//메시지함 유저 검색
	@RequestMapping("msguser.ps")
	public View selectUserMsg(String userName, HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		List<Message> selectMsg = messageService.selectUserMsg(user.getUserNo(), userName);
		
		Map<Integer, Message> map = new HashMap<>();
		
		//메시지 검색해서 가져온거 id 중복제거를 하고 가장 최신 메시지만 담음
		for (Message m : selectMsg) {
			map.put(m.getReceiveUserNo(), m);
			map.put(m.getSendUserNo(), m);
		}
		
		map.remove(user.getUserNo());
		
		List<Message> recentSelMsg = new ArrayList<>();
		
		Set<Map.Entry<Integer, Message>> ent = map.entrySet();
		Iterator<Map.Entry<Integer, Message>> i = ent.iterator();
		while(i.hasNext()) {
			Map.Entry<Integer, Message> ma = i.next();
			recentSelMsg.add(ma.getValue());
		}
		
		Collections.sort(recentSelMsg, new Comparator<Message>() {
			@Override
			public int compare(Message o1, Message o2) {
				if (o1.getMsgNo() < o2.getMsgNo()) {
					return 1;
				} else if (o1.getMsgNo() > o2.getMsgNo()) {
					return -1;
				}else {
					return 0;
				}
			}
		});
		
		System.out.println("검색된 유저 검색 목록을 보여주세요~");
		model.addAttribute("recentSelMsg", recentSelMsg);
		
		return jsonview;
	}
	
	
	
	//////////////////////////////////////////////////////////////////////////////
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

	@RequestMapping("messageNotice.ps")
	public String messageNotice(HttpSession session,int userNo) {
		System.out.println("---------------------------------");
		System.out.println(userNo);
		User user = userService.userInfo(userNo);
		String msgUser = user.getUserNo() + "," + user.getUserName();
		session.setAttribute("msgNotice", msgUser);
		return "redirect:/message/receivemessage.ps";
	}
}
