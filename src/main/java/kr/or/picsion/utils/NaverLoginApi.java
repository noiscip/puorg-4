package kr.or.picsion.utils;

import com.github.scribejava.core.builder.api.DefaultApi20;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils 
 * @className NaverLoginApi
 * @date 2018. 6. 15.
 */

public class NaverLoginApi extends DefaultApi20{

	public NaverLoginApi() {}
	
 	private static class InstanceHolder{
 		private static final NaverLoginApi INSTANCE = new NaverLoginApi();
 	}
 	
 	
 	public static NaverLoginApi instance(){
 		return InstanceHolder.INSTANCE;
 	}
 	
	@Override
	public String getAccessTokenEndpoint() {
		return "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return "https://nid.naver.com/oauth2.0/authorize";
	}


}
