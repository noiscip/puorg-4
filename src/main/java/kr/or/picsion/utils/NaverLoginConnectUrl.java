package kr.or.picsion.utils;

import java.io.IOException;

import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Service
public class NaverLoginConnectUrl {

	private final static String CLIENT_ID = "AavwsVovOeUd6Ijvt3W0";
	private final static String CLIENT_SECRET = "Hqxt01G0DF";
	private final static String REDIRECT_URI = "http://127.0.0.1:8090/picsion/naverlogin.ps";
	private final static String SESSION_STATE = "oauth_state";
	private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";
	
	/* 네아로 Callback 처리 및  AccessToken 획득 Method */
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException{
		/* Callback으로 전달받은 세선검증용 난수값과 세션에 저장되어있는 값이 일치하는지 확인 */
		setSession(session, state);
		
		String sessionState = getSession(session);
		if(StringUtils.equals(sessionState, state)){
		
			OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET).callback(REDIRECT_URI).state(state).build(NaverLoginApi.instance());
					
			/* Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token을 획득 */
			OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
			return accessToken;
		}
		return null;
	}
	
	/* http session에서 데이터 가져오기 */	
	private String getSession(HttpSession session){
		return (String) session.getAttribute(SESSION_STATE);
	}
	
	/* http session에 데이터 저장 */
	private void setSession(HttpSession session,String state){
		session.setAttribute(SESSION_STATE, state);		
	}

	/* Access Token을 이용하여 네이버 사용자 프로필 API를 호출 */
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException{
		OAuth20Service oauthService =new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET).callback(REDIRECT_URI).build(NaverLoginApi.instance());
    	
    	OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
    	
		oauthService.signRequest(oauthToken, request);
		Response response = request.send();
		return response.getBody();
	}
}
