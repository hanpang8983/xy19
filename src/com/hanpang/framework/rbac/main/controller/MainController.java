package com.hanpang.framework.rbac.main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hanpang.framework.rbac.menu.service.MenuService;
import com.hanpang.framework.rbac.user.model.User;

@Controller
@Scope("prototype")
@RequestMapping("/sys/frameset")
public class MainController  {
	
	private MenuService menuService;
	@Autowired
	//@Qualifier("menuService")
	public void setMenuService(MenuService menuService) {
		this.menuService = menuService;
	}
	@RequestMapping("/index")
	public String index(){
		return "jsp/main/frameset";
	}
	@RequestMapping("/top")
	public String top(){
		return "jsp/main/top";
	}
	@RequestMapping("/left")
	public String left(HttpServletRequest request,ModelMap modelMap){
		//获取当前登录用户的信息
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("session_user");
		//获取该用户的角色主键ID
		Integer role_id = user.getRole().getRole_id();
		//通过角色ID获取该角色拥有的菜单信息
		modelMap.addAttribute("leftMenuList", menuService.getLeftMenuList(role_id));
		//通过角色ID获取该角色拥有的父节点信息
		modelMap.addAttribute("leftParentMenuList", menuService.getLeftParentMenuList(role_id));
		
		return "jsp/main/left";
	}
	@RequestMapping("/right")
	public String right(){
		return "jsp/main/right";
	}
	
}
