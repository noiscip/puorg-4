package kr.or.picsion.utils;

import java.io.IOException;

import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils 
 * @className NaverLoginConnectUrl
 * @date 2018. 6. 15.
 */
@Service
public class NaverLoginConnectUrl {

	@Value("#{config['naver.clientId']}")
	private String CLIENT_ID;
	@Value("#{config['naver.clientSecret']}")
	private String CLIENT_SECRET;
	private String REDIRECT_URI = "http://127.0.0.1:8090/picsion/naverlogin.ps";
	private String SESSION_STATE = "oauth_state";
	private String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";
	
	/**
	 * 날      짜 : 2018. 6. 15.
	 * 메소드명 : getAccessToken
	 * 작성자명 : 아윤근
	 *
	 * @param session
	 * @param code
	 * @param state
	 * @return
	*/
	/* 네아로 Callback 처리 및  AccessToken 획득 Method */
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state){
		/* Callback으로 전달받은 세선검증용 난수값과 세션에 저장되어있는 값이 일치하는지 확인 */
		setSession(session, state);
		String sessionState = getSession(session);
		if(StringUtils.equals(sessionState, state)){
			OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID)
					.apiSecret(CLIENT_SECRET).callback(REDIRECT_URI).state(state).build(NaverLoginApi.instance());
			/* Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token을 획득 */
			OAuth2AccessToken accessToken;
			try {
				accessToken = oauthService.getAccessToken(code);
				return accessToken;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	

	/**
	 * 날      짜 : 2018. 6. 15.
	 * 메소드명 : getSession
	 * 작성자명 : 아윤근
	 *
	 * @param session
	 * @return
	*/
	private String getSession(HttpSession session){
		return (String) session.getAttribute(SESSION_STATE);
	}

	/**
	 * 날      짜 : 2018. 6. 15.
	 * 메소드명 : setSession
	 * 작성자명 : 아윤근
	 *
	 * @param session
	 * @param state
	*/
	private void setSession(HttpSession session,String state){
		session.setAttribute(SESSION_STATE, state);		
	}

	/**
	 * 날      짜 : 2018. 6. 15.
	 * 메소드명 : getUserProfile
	 * 작성자명 : 아윤근
	 *
	 * @param oauthToken
	 * @return
	*/
	/* Access Token을 이용하여 네이버 사용자 프로필 API를 호출 */
	public String getUserProfile(OAuth2AccessToken oauthToken){
		OAuth20Service oauthService =new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI).build(NaverLoginApi.instance());
    	OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		oauthService.signRequest(oauthToken, request);
		Response response = request.send();
		try {
			return response.getBody();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
