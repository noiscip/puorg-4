package kr.or.picsion;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
public class NaverLoginController {

	@Autowired
	private NaverLoginConnectUrl naverLoginCon;
	
	@RequestMapping("/naverlogin.ps")
	public String naverLogin(HttpSession session, Model model) {
		System.out.println("네이버 로그인 컨트롤러");
		String naverAuthUrl = naverLoginCon.getAuthorizationUrl(session);
		model.addAttribute("url",naverAuthUrl);
		
	        /* 생성한 인증 URL을 View로 전달 */
	 	return "naver.naverlogin";
	}
	
	@RequestMapping("/callback.ps")
	public String callback(@RequestParam String code, @RequestParam String state, HttpSession session) throws IOException {
		System.out.println("네이버 콜백 컨트롤러");
		/* 네아로 인증이 성공적으로 완료되면 code 파라미터가 전달되며 이를 통해 access token을 발급 */
		OAuth2AccessToken oauthToken = naverLoginCon.getAccessToken(session, code, state);
    	return "naver.callback";
	}
}

