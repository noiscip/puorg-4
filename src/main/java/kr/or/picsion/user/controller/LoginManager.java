/**
 * 
 */
package kr.or.picsion.user.controller;

import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.user.controller 
 * @className LoginController
 * @date 2018. 7. 13.
 */
@Controller
public class LoginManager implements HttpSessionBindingListener{

	private static final Logger logger = LoggerFactory.getLogger(LoginManager.class);
	
	private static LoginManager loginManager = null;
	private static Hashtable<Object, Object> loginUsers = new Hashtable<>();
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private View jsonview;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
		
	public LoginManager() {
		
	}
	public static synchronized LoginManager getInstance() {
		System.out.println("불러오긴해?");
		if(loginManager == null) {
			loginManager = new LoginManager();
		}
		return loginManager;
	}
	
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		loginUsers.put(event.getSession(), event.getName());
		logger.debug(event.getName() + " 님이 로그인 하셨습니다.");
		logger.debug("현재 접속자 수 : " + getUserCount());
		
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		logger.debug(event.getName() + " 님이 로그아웃 하셨습니다.");
		logger.debug("현재 접속자 수 : " + getUserCount());
	}

	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : userRegister
	* 작성자명 : 아윤근
	* 기      능 : 회원가입
	*
	* @param user
	* @return String
	*/
	@RequestMapping(value="register.ps", method=RequestMethod.POST)
	public String userRegister(User user) {
		user.setPwd(bCryptPasswordEncoder.encode(user.getPwd()));
		userService.register(user);
		return "redirect:/user/login.ps";
	}
	
	@RequestMapping(value="login.ps", method=RequestMethod.POST)
	public String isValid(User user, HttpSession session) {
		String result="";

		String password = user.getPwd();
		User loginUser = userService.searchUserId(user.getUserId());
		
		if(loginUser != null) {
			boolean login = bCryptPasswordEncoder.matches(password,loginUser.getPwd());

			if(login == true) {
				if(isUsing(loginUser.getUserId())) {
					removeSession(loginUser.getUserId());
				}
				
				setSession(session, loginUser);

				if(loginUser.getRoleNo()==3) {
					result = "redirect:/user/admin.ps";
				}else {
					result = "redirect:/home.ps";
				}
			}
		}else {
			result = "redirect:/user/login.ps";
		}
		return result;
	}
	
	@RequestMapping("logout.ps")
	public String removeSession(String userId){
		Enumeration e = loginUsers.keys();
		HttpSession session = null;
		while(e.hasMoreElements()) {
			session = (HttpSession)e.nextElement();
			System.out.println(session);
			if(loginUsers.get(session).equals(userId)) {
				System.out.println(userId +" 님이 로그아웃 하십니다?");
				loginUsers.remove(session);
				session.invalidate();
			}
		}
		return "redirect:/home.ps";
	}
	
	//세션에 추가
	public void setSession(HttpSession session, User user) {
		session.setAttribute("user", user);
		loginUsers.put(session, user.getUserId());
	}
	
	//유저가 접속되어 있는지 체크
	public boolean isUsing(String userId) {
		return loginUsers.containsValue(userId);
	}
	
	//현재 접속자 수
	public int getUserCount() {
		return loginUsers.size();
	}
	
	@RequestMapping("userCount.ps")
	public View getUserCount(Model model) {
		model.addAttribute("count",loginUsers.size());
		return jsonview;
	}
}
