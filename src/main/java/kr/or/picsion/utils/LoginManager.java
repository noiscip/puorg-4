/**
 * 
 */
package kr.or.picsion.utils;

import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils 
 * @className LoginManager
 * @date 2018. 7. 13.
 */

public class LoginManager implements HttpSessionBindingListener{

    private static LoginManager loginManager = null;
    
    //로그인한 접속자를 담기위한 해시테이블
    private static Hashtable<HttpSession, String> loginUsers = new Hashtable<>();
    
    /*
     * 싱글톤 패턴 사용
     */
    public static synchronized LoginManager getInstance(){
        if(loginManager == null){
            loginManager = new LoginManager();
        }
        return loginManager;
    }

	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		loginUsers.put(event.getSession(), event.getName());
		System.out.println(event.getName() + " 님이 로그인 하셨습니다");
		System.out.println("현재 접속자 수 : " + loginManager.getUserCount());
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		loginUsers.remove(event.getSession());
		System.out.println(" " + event.getName() + " 님이 로그아웃 하셨습니다");
		System.out.println("현재 접속자 수 : " + loginManager.getUserCount());
	}

	//입력 받은 아이디를 이용해서 해시테이블에서 삭제
	public void removeSession(String userId) {
		
		Enumeration e = loginUsers.keys();
		HttpSession session = null;
		while(e.hasMoreElements()) {
			session = (HttpSession)e.nextElement();
			if(loginUsers.get(session).equals(userId)) {
				session.invalidate();
			}
		}
	}

	//해당 아이디의 동시 사용을 막기위해서 이미 사용중인 아이디인지를 확인한다.
	public boolean inUsing(String userId) {
		return loginUsers.containsValue(userId);
	}
	
	public int getUserCount(){
        return loginUsers.size();
    }

}
