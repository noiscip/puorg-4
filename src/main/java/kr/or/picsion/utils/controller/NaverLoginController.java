package kr.or.picsion.utils.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;
import kr.or.picsion.utils.NaverLoginConnectUrl;

@Controller
@RequestMapping("/naver/")
public class NaverLoginController {

	@Autowired
	private NaverLoginConnectUrl naverLoginCon;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("naverlogin.ps")
	public String naverLogin() {
	 	return "naver.login";
	}
	
	@RequestMapping("login.ps")
	public String naverLogin(String code,String state, HttpSession session, Model model) {
		/* 네아로 인증이 성공적으로 완료되면 code 파라미터가 전달되며 이를 통해 access token을 발급 */
		System.out.println("로그인 실행 되었어요");
		OAuth2AccessToken oauthToken;
		String result = "redirect:/home.ps";
		try {
			oauthToken = naverLoginCon.getAccessToken(session, code, state);
			String apiResult = naverLoginCon.getUserProfile(oauthToken);
			
			String[] haha = apiResult.split("\"");
			
			User accountUser = userService.selectAccountLinked(haha[13]);
			
			if(accountUser == null) {
				session.setAttribute("result", "F");
				result = "redirect:/user/login.ps";
			}else {
				User user = userService.userInfo(accountUser.getUserNo());
				session.setAttribute("user", user);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}

		
    	return result;
	}
	
	@RequestMapping("naverinsert.ps")
	public String naverInsert() {
		
		return "";
	}

	@RequestMapping("insert.ps")
	public String naverInsert(String code,String state,HttpSession session) {
		System.out.println("인설트 실행되어야해요");
		OAuth2AccessToken oauthToken;
		String result = "redirect:/home.ps";
		try {
			oauthToken = naverLoginCon.getAccessToken(session, code, state);
			String apiResult = naverLoginCon.getUserProfile(oauthToken);
			
			String[] haha = apiResult.split("\"");
			String accountNo = haha[13]; 
			
			User user = (User)session.getAttribute("user");
			
			if(userService.selectAccountLinked(accountNo) == null) { 
				userService.insertAccountLinked(user.getUserNo(),accountNo);
				session.setAttribute("user", userService.userInfo(user.getUserNo()));
			}else {
				session.setAttribute("result", "F");
				System.out.println("으응??");
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
}

