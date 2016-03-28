package com.hanpang.framework.base.controller;

import java.beans.PropertyEditorSupport;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.hanpang.framework.base.utils.DateUtils;


@Controller
public class BaseController {
	
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected HttpSession session;
	/**
	 * 解决日期传递时候的转换问题
	 * @param binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Date.class, new PropertyEditorSupport(){
			@Override
			public void setAsText(String text) throws IllegalArgumentException {
				setValue(DateUtils.parseDate(text));
			}
		});
	}
	/**
	 * 获取ServletAPI
	 * @param request
	 * @param response
	 */
	@ModelAttribute
	public void initServlet(HttpServletRequest request,HttpServletResponse response){
		this.request = request;
		this.response = response;
		this.session = request.getSession();
	}

}
