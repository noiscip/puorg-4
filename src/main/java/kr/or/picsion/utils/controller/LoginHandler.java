/**
 * 
 */
package kr.or.picsion.utils.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils.controller 
 * @className LoginHandler
 * @date 2018. 7. 3.
 */

public class LoginHandler extends HandlerInterceptorAdapter {
	   @Override
	    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler){
	        try {
	            //user 세션key를 가진 정보가 널일경우 메인 페이지로 이동
	            if(request.getSession().getAttribute("user") == null ){
	                    response.sendRedirect("/picsion/");
	                    return false;
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return true;
	    }
	 
	    @Override
	    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
	        super.postHandle(request, response, handler, modelAndView);
	    }
	 
	    @Override
	    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
	        super.afterCompletion(request, response, handler, ex);
	    }
	 
	    @Override
	    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	        super.afterConcurrentHandlingStarted(request, response, handler);
	    }


}
