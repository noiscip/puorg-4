package kr.or.picsion.utils.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.scribejava.core.model.OAuth2AccessToken;

import kr.or.picsion.user.controller.LoginManager;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;
import kr.or.picsion.utils.NaverLoginConnectUrl;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils.controller 
 * @className NaverLoginController
 * @date 2018. 6. 15.
 */

@Controller
@RequestMapping("/naver/")
public class NaverLoginController {

	private final String NAVER="naver";
	
	@Autowired
	private NaverLoginConnectUrl naverLoginCon;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private LoginManager loginManager;
	
	@RequestMapping("login.ps")
	public String naverLogin() {
	 	return "naver.login";
	}
	
	/**
	 * 날      짜 : 2018. 6. 15.
	 * 메소드명 : naverLogin
	 * 작성자명 : 아윤근
	 *
	 * @param code
	 * @param state
	 * @param session
	 * @param model
	 * @return
	*/
	@RequestMapping("callback.ps")
	@Transactional(propagation = Propagation.REQUIRED)
	public String naverLogin(String code,String state, HttpSession session, Model model) {
		/* 네아로 인증이 성공적으로 완료되면 code 파라미터가 전달되며 이를 통해 access token을 발급 */
		OAuth2AccessToken oauthToken = naverLoginCon.getAccessToken(session, code, state);
		String apiResult = naverLoginCon.getUserProfile(oauthToken);
		
		User user = (User)session.getAttribute("user");
		String accountNo  = apiResult.split("\"")[13];
		String result = "redirect:/home.ps";
		try {
			if(user == null) { //유저가 null이면 로그인이 안되어 있는 상태 
				User accountUser = userService.selectAccountNo(accountNo,NAVER);
				if(accountUser == null) { //연동되어 있는 계정이 없음
					session.setAttribute("result", "F");
					result = "redirect:/user/login.ps";
				}else { // 연동된 계정이 있으면
					loginManager.setSession(session, userService.userInfo(accountUser.getUserNo()));
				}
			}else { //유저가 존재 한다면 계정 연동
				if(userService.selectAccountNo(accountNo,NAVER) == null) { //네이버 등록이 안되어 있다면
					userService.updateAccountNo(user.getUserNo(),accountNo,NAVER);
					userService.updateRole(user.getUserNo());
					loginManager.setSession(session, userService.userInfo(user.getUserNo()));
				}else { //네이버 등록이 되어 있다면
					session.setAttribute("result", "F");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return result;
	}
}

