/**
 * 
 */
package kr.or.picsion.utils.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils.controller 
 * @className GoogleLoginController
 * @date 2018. 6. 18.
 */

@Controller
@RequestMapping("/google/")
public class GoogleLoginController {

	private final String GOOGLE = "google";

	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	@Autowired
	private UserService userService;
	
	/**
	 * 날      짜 : 2018. 6. 18.
	 * 메소드명 : login
	 * 작성자명 : 아윤근
	 *
	 * @param model
	 * @return
	*/
	@RequestMapping("login.ps")
	public String login(Model model) {
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("url",url);
		return "google.login";
	}
	
	/**
	 * 날      짜 : 2018. 6. 18.
	 * 메소드명 : doSessionAssignActionPage
	 * 작성자명 : 아윤근
	 *
	 * @param request
	 * @return
	*/
	@RequestMapping(value = "/callback.ps", method = RequestMethod.GET)
	public String doSessionAssignActionPage(HttpServletRequest request){
	  String code = request.getParameter("code");
	  OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
	  
	  AccessGrant accessGrant = oauthOperations.exchangeForAccess(code ,googleOAuth2Parameters.getRedirectUri() , null);
	  String accessToken = accessGrant.getAccessToken();
	  Long expireTime = accessGrant.getExpireTime();
	  
	  if (expireTime != null && expireTime < System.currentTimeMillis()) {
	    accessToken = accessGrant.getRefreshToken();
	    System.out.printf("accessToken is expired. refresh token = {}", accessToken);
	  }
	  Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);
	  Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();

	  PlusOperations plusOperations = google.plusOperations();
	  Person profile = plusOperations.getGoogleProfile();
	  System.out.println("id : " +profile.getId());
	  
	  HttpSession session = request.getSession();
	  User user = (User)session.getAttribute("user");
	  System.out.println("유저어 : " + user);
	  
	  String accountNo = profile.getId();
	  String result = "redirect:/home.ps";

	  if(user == null) { //유저가 null이면 로그인 되어 있지 않은 상태
			User accountUser = userService.selectAccountNo(accountNo,GOOGLE);
			
			if(accountUser == null) { //연동되어 있는 계정이 없음
				session.setAttribute("result", "F");
				result = "redirect:/user/login.ps";
			}else {
				session.setAttribute("user", userService.userInfo(accountUser.getUserNo()));
			}
	  }else { //널이 아니면 등록
		  if(userService.selectAccountNo(accountNo,GOOGLE) == null) {  //구글 등록이 안되어 있다면
			  if(userService.selectAccountUserNo(user.getUserNo()) == null) { //네이버 등록도 안되어 있다면 insert
				  userService.insertAccountNo(user.getUserNo(),accountNo,GOOGLE);
			  }else { //네이버 등록은 되어있다면
				  userService.updateAccountNo(user.getUserNo(),accountNo,GOOGLE);
			  }
			  session.setAttribute("user", userService.userInfo(user.getUserNo()));
		  }else { //구글 등록이 되어있다면
			  	session.setAttribute("result", "F");
				System.out.println("이미 연동되어있는 계쩡이야!");
		  }
	  }
	  return result;
	}	
	
	
}
