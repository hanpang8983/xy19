package com.hanpang.framework.rbac.user.controller;

import java.awt.image.BufferedImage;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.hanpang.framework.base.controller.SysControler;
import com.hanpang.framework.rbac.logger.model.LoginLog;
import com.hanpang.framework.rbac.logger.service.LoginLogService;
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
	
	private LoginLogService loginLogService;
	@Autowired
	public void setLoginLogService(LoginLogService loginLogService) {
		this.loginLogService = loginLogService;
	}
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public ModelAndView login(String account,String password,String code,HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		try {
			//判断验证码输入的是否正确
			if(code.equalsIgnoreCase(session.getAttribute(Constants.KAPTCHA_SESSION_KEY).toString())){
				User user = userService.login(account, password);
				if(session.getAttribute("session_user")==null){
					//登录成功后，添加信息到日志当中
					LoginLog loginLog = new LoginLog();
					loginLog.setLog_id(UUID.randomUUID().toString());
					loginLog.setIp(request.getRemoteAddr());//获取客户端的IP地址
					loginLog.setLog_time(new Date());
					loginLog.setAccount(user.getAccount());
					loginLog.setUser_name(user.getUser_name());
					
					loginLogService.add(loginLog);
				}
				
		
				session.setAttribute("session_user", user);
				mav.setViewName("jsp/main/main");
			}else{
				mav.addObject("account", account);
				mav.addObject("message", "您输入的验证码有误，请重新输入");
				mav.setViewName("jsp/login");
			}
			
			
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
	
	/** 关于验证码的配置 */
	private Producer captchaProducer;

	@Autowired
	@Qualifier(value = "captchaProducer")
	public void setCaptchaProducer(Producer captchaProducer) {
		this.captchaProducer = captchaProducer;
	}
	
	/**
	 * 生成验证码代码
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/code")
	public ModelAndView getKaptchaImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		// String code =
		// (String)session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
		// System.out.println("******************验证码是: " + code +
		// "******************");
		response.setDateHeader("Expires", 0);
		// Set standard HTTP/1.1 no-cache headers.
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		// Set IE extended HTTP/1.1 no-cache headers (use addHeader).
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		// Set standard HTTP/1.0 no-cache header.
		response.setHeader("Pragma", "no-cache");
		// return a jpeg
		response.setContentType("image/jpeg");
		// create the text for the image
		String capText = captchaProducer.createText();
		// store the text in the session
		session.setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);

		// create the image with the text
		BufferedImage bi = captchaProducer.createImage(capText);
		ServletOutputStream out = response.getOutputStream();
		// write the data out
		ImageIO.write(bi, "jpg", out);
		try {
			out.flush();
		} finally {
			out.close();
		}
		return null;
	}
	
	

}
