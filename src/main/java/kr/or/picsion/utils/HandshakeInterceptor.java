/**
 * 
 */
package kr.or.picsion.utils;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils 
 * @className HandshakeInterceptor
 * @date 2018. 6. 15.
 */

public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor {
	  
    @Override
    public boolean beforeHandshake(ServerHttpRequest request,ServerHttpResponse response, WebSocketHandler wsHandler,
        Map<String, Object> attributes) throws Exception {    
    	
        // 위의 파라미터 중, attributes 에 값을 저장하면 웹소켓 핸들러 클래스의 WebSocketSession에 전달된다
        System.out.println("Before Handshake");
          
        ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;
        System.out.println("URI:"+request.getURI());
  
        HttpServletRequest req =  ssreq.getServletRequest();

        // HttpSession 에 저장된 이용자의 아이디를 추출하는 경우
        User user = (User)req.getSession().getAttribute("user");
        
        attributes.put("userNo", user.getUserNo());
        
        System.out.println(attributes.values());
        
        System.out.println("HttpSession에 저장된 id:"+user.getUserNo());
        
        return super.beforeHandshake(request, response, wsHandler, attributes);
    }
  
    @Override
    public void afterHandshake(ServerHttpRequest request,
            ServerHttpResponse response, WebSocketHandler wsHandler,
            Exception ex) {
        System.out.println("After Handshake");
  
        super.afterHandshake(request, response, wsHandler, ex);
    }
  
}

