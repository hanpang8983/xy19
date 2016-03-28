package com.hanpang.framework.base.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
/**
 * 登录拦截器
 * @author 刘文铭
 *
 */
public class SessionInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		System.out.println(session.getAttribute("session_user")+"*****");
		if(session.getAttribute("session_user")==null){
			//request.setAttribute("message", "您被拦截了，哈哈，正常登录去!");
			//request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
			
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.write("<script type='text/javascript'>alert('您非法操作，请重新登录!');window.top.location.href='"+request.getContextPath()+"/index.jsp';</script>");
			
			out.flush();
			out.close();
			
			
			return false;
		}
		return true;

	}
	

}
