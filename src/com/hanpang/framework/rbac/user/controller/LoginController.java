package com.hanpang.framework.rbac.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.hanpang.framework.base.controller.SysControler;
import com.hanpang.framework.rbac.user.model.User;
import com.hanpang.framework.rbac.user.service.UserService;
@Controller
@Scope("prototype")
public class LoginController extends SysControler {
	
	private UserService userService ;//接口回调
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public ModelAndView login(String account,String password,HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		try {
			User user = userService.login(account, password);
			//HttpSession
			HttpSession session = request.getSession();
			session.setAttribute("session_user", user);
			mav.setViewName("jsp/main/main");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("account", account);
			mav.addObject("message", e.getMessage());
			mav.setViewName("jsp/login");
			
		}
		
		return mav;
	}
	@RequestMapping("/loginOut")
	public String loginOut(){
		//手动移除属性
		request.getSession().removeAttribute("session_user");
		//手动销毁
		request.getSession().invalidate();
		
		return "jsp/login";
	}

}
