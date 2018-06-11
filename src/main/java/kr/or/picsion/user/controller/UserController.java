package kr.or.picsion.user.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

@Controller
@RequestMapping("/user/")
public class UserController {

	@Autowired
	private View jsonview;

	@Autowired
	private UserService userService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@RequestMapping(value="register.ps", method=RequestMethod.GET)
    public String register(){
        return "user.register";
    }
	
	@RequestMapping(value="register.ps", method=RequestMethod.POST)
	public String userRegister(User user) {
		userService.register(user);
		return "redirect:/home.ps";
	}
	
	@RequestMapping(value="login.ps", method=RequestMethod.GET)
	public String userLogint() {
		return "user.login";
	}
	
	
	@RequestMapping(value="login.ps", method=RequestMethod.POST)
	public String userLogin(User user, HttpSession session) {
		System.out.println("로그인");
		
		User loginUser = userService.login(user);
		String result="";
		if(loginUser != null) {
			System.out.println("로그인 성공");
			session.setAttribute("user", loginUser);
			result = "redirect:/home.ps";
		}else {
			System.out.println("로그인 실패");
			result = "redirect:/user/login.ps";
		}
		return result;
	}
	
	@RequestMapping("logout.ps")
	public String userLogout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/home.ps";
	}
	
	@RequestMapping(value="userlist.ps")
	public String userList(Model model) {
		
		List<User> userList = userService.userList();
		model.addAttribute("testbb", userList);
		return "home.admin";
	}
	
}
