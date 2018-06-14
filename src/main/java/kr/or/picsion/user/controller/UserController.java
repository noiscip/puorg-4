package kr.or.picsion.user.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import kr.or.picsion.blame.dto.Blame;
import kr.or.picsion.blame.service.BlameService;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.purchase.dto.Purchase;
import kr.or.picsion.purchase.service.PurchaseService;
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
	private BlameService blameService;
	
	@Autowired
	private PurchaseService purchaseService;
	
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
			if(loginUser.getRoleNo()==3) {
				result = "redirect:/user/admin.ps";
			}else {
				result = "redirect:/home.ps";
			}
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
	
	@RequestMapping("admin.ps")
	public String adminPage(Model model) {
		
		List<User> userList = userService.userList();
		model.addAttribute("userList",userList);
		return "admin.admin";
	}
	
	@RequestMapping("adminComplainList.ps")
	public String complain(Model model) {
		
		
		List<Blame> blameList = blameService.complain();
		model.addAttribute("blameList",blameList);
		return "admin.complain";
	}
	
	@RequestMapping("adminPurchase.ps")
	public String purchase(Model model) {
		
		List<Purchase> purchaseList = purchaseService.purchaseList();
		model.addAttribute("purchaseList",purchaseList);
		return "admin.purchase";
	}
	
	@RequestMapping(value="popular.ps", method=RequestMethod.GET)
	public String getList(HttpSession session, Model model) {
		
		User user = (User) session.getAttribute("user");
		Map<Integer, Object> followingPicList = userService.mapObj(user.getUserNo());
		model.addAttribute("imagelistall", followingPicList);
		System.out.println(followingPicList);
		return "popular.followingpicall";
	}
	
	@RequestMapping(value="userlist.ps")
	public String userList(Model model) {
		
		List<User> userList = userService.userList();
		model.addAttribute("testbb", userList);
		return "home.admin";
	}
	
	//팔로잉 하고 있는지 확인
	@RequestMapping("following.ps")
	public View followingConfirm(int userNo, int followingUserNo, Model model) {
		
		int result = userService.followingConfirm(userNo, followingUserNo); 

		if(result!=0) {		//result가 1이면 팔로잉 취소 처리
			userService.deleteFollow(userNo, followingUserNo);
			System.out.println("팔로잉 취소 완료!!");
		}else {				//result가 0이면 팔로우 처리
			userService.insertFollow(userNo, followingUserNo);
			System.out.println("팔로잉 완료!!!");
		}		
		
		model.addAttribute("result", result);
		
		return jsonview;
	}
	
	//마이 페이지로 이동
	/*@RequestMapping("mypage.ps")
	public String myPage() {
		return "mypage.";
	}*/
	
}
