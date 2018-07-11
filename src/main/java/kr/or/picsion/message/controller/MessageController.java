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
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import kr.or.picsion.message.dto.Message;
import kr.or.picsion.message.service.MessageService;
import kr.or.picsion.notice.service.NoticeService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.message.controller 
 * @className MessageController
 * @date 2018. 6. 4.
 */

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
	
	/**
	* 날      짜 : 2018. 6. 12.
	* 메소드명 : messageSend
	* 작성자명 : 박주원, 아윤근
	* 기      능 : 메시지 보내기, 알림 등록
	*
	* @param message
	* @param model
	* @return View
	*/
	@RequestMapping("send.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public View messageSend(Message message, Model model) {
		int result = 0;
		User userinfo = new User();
		try {
			result = messageService.sendMessage(message);
			userinfo = userService.userInfo(message.getReceiveUserNo());
			
			if(result != 0) {
				HashMap<String, Object> noticeMap = new HashMap<String, Object>();
				
				noticeMap.put("no", message.getMsgNo());
				noticeMap.put("receiveUserNo", message.getReceiveUserNo());
				noticeMap.put("sendUserNo", message.getSendUserNo());
				noticeMap.put("table", "msgNo");
				noticeMap.put("tableNo", message.getTableNo());
				
				model.addAttribute("message", message);
				model.addAttribute("userinfo", userinfo);
				
				noticeService.insertNotice(noticeMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("result", result);
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 21.
	* 메소드명 : receiveMessage
	* 작성자명 : 박주원
	* 기      능 : 메시지 리스트
	*
	* @param session
	* @param model
	* @return String
	*/
	@RequestMapping("receivemessage.ps")
	public String receiveMessage(HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		
		List<Message> messageAll = messageService.messageAll(user.getUserNo());
		
		Map<Integer, Message> map = new HashMap<>();
		
		//메시지 검색해서 가져온거 id 중복제거를 하고 가장 최신 메시지만 담음
		for (Message m : messageAll) {
			map.put(m.getReceiveUserNo(), m);
			map.put(m.getSendUserNo(), m);
		}
		
		map.remove(user.getUserNo());
		
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
		
		return "mypage.message";
	}
	
	/**
	* 날      짜 : 2018. 6. 22.
	* 메소드명 : messageList
	* 작성자명 : 박주원
	* 기      능 : 한 회원과 주고받은 메시지 리스트 뽑아오기
	*
	* @param userNo
	* @param session
	* @param model
	* @return View
	*/
	@RequestMapping("msglist.ps")
	public View messageList(int userNo, HttpSession session, Model model) {
		User user = (User)session.getAttribute("user");
		List<Message> msgList = messageService.messageList(user.getUserNo(), userNo);
		
		model.addAttribute("msgList", msgList);
		
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 24.
	* 메소드명 : messageRead
	* 작성자명 : 박주원
	* 기      능 : 메시지 읽어오기 (socket)
	*
	* @param session
	* @param message
	* @param model
	* @return View
	*/
	@RequestMapping("readmsg.ps")
	public View messageRead(HttpSession session, Message message, Model model) {
		User userinfo = userService.userInfo(message.getSendUserNo());
		Message msginfo = messageService.messageInfo(message.getMsgNo());
		
		model.addAttribute("userinfo", userinfo);
		model.addAttribute("msginfo", msginfo);
		
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 27.
	* 메소드명 : messageDel
	* 작성자명 : 박주원
	* 기      능 : 메시지함에서 한 회원과 주고 받은 대화내용 모두 삭제
	*
	* @param userNo
	* @param session
	* @param model
	* @return View
	*/
	@RequestMapping("msgdel.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public View messageDel(int userNo, HttpSession session, Model model) {
		try {
			User user = (User)session.getAttribute("user");
			
			int reResult=messageService.receiveDel(user.getUserNo(), userNo);
			int seResult=messageService.sendDel(user.getUserNo(), userNo);
			
			model.addAttribute("reResult", reResult);
			model.addAttribute("seResult", seResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 28.
	* 메소드명 : selectUserMsg
	* 작성자명 : 박주원
	* 기      능 : 메시지함 유저 검색
	*
	* @param userName
	* @param session
	* @param model
	* @return View
	*/
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
		
		model.addAttribute("recentSelMsg", recentSelMsg);
		
		return jsonview;
	}

	/**
	* 날      짜 : 2018. 6. 29.
	* 메소드명 : messageNotice
	* 작성자명 : 아윤근
	* 기      능 : 메시지 알림
	*
	* @param session
	* @param userNo
	* @return String
	*/
	@RequestMapping("messageNotice.ps")
	public String messageNotice(HttpSession session,int userNo) {
		User user = userService.userInfo(userNo);
		String msgUser = user.getUserNo() + "," + user.getUserName();
		session.setAttribute("msgNotice", msgUser);
		return "redirect:/message/receivemessage.ps";
	}
	
}
