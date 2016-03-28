package com.hanpang.framework.rbac.user.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hanpang.framework.base.controller.SysControler;
import com.hanpang.framework.base.model.Pager;
import com.hanpang.framework.rbac.role.service.RoleService;
import com.hanpang.framework.rbac.user.model.User;
import com.hanpang.framework.rbac.user.service.UserService;
@Controller
@Scope("prototype")
@RequestMapping("/sys/user")
public class UserController extends SysControler {
	private UserService userService ;//接口回调
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	private RoleService roleService;
	@Autowired
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}

	@RequestMapping("/list")
	public ModelAndView list(){
		ModelAndView mav = new ModelAndView();
		try {//不会，就在这里捕获异常信息
			mav.addObject("userList", this.userService.list());
			mav.setViewName("jsp/user/list");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@RequestMapping("/find")
	public ModelAndView find(Pager pager,User user){
		ModelAndView mav = new ModelAndView();
		try {//不会，就在这里捕获异常信息
			mav.addObject("pager", this.userService.find(pager,user));
			mav.addObject("user", user);
			mav.setViewName("jsp/user/find");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public ModelAndView toAddPage(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsp/user/add");
		return mav;
	}
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public ModelAndView addUser(User user){
		ModelAndView mav = new ModelAndView();
		try {
			this.userService.add(user);
			
			mav.addObject("flag", "success");
			mav.addObject("message", "新增系统用户成功");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("flag", "error");
			mav.addObject("message", e.getMessage());
		}
		mav.setViewName("jsp/message");
		return mav;
	}
	
	@RequestMapping(value="/upload",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadPhoto(MultipartFile image) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			if(image!=null){
				//1.获取绝对路径
				String path = this.session.getServletContext().getRealPath("/upload/user");
				//2.建立联系
				File folder = new File(path);
				if(!folder.isDirectory()){
					folder.mkdirs();
				}
				//3.获取上传文件的名称
				String fileName = image.getOriginalFilename();
				//4.获取后缀名
				String ext = FilenameUtils.getExtension(fileName);
				//5.生成新的名
				String newName = UUID.randomUUID().toString()+"."+ext;
				//6.创建空的文件
				File newFile = new File(path+"/"+newName);
				//7.复制
				image.transferTo(newFile);
				//8.返回数据
				map.put("newName", newName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
	@RequestMapping(value="/account",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> validation(String account) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			this.userService.validation(account);
			map.put("flag", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("message", e.getMessage());
			map.put("flag", "error");
		}
		
		
		return map;
	}
	
	
	@RequestMapping(value="/update/{user_id}",method=RequestMethod.GET)
	public ModelAndView toUpdatePage(@PathVariable Integer user_id){
		ModelAndView mav = new ModelAndView();
		//通过主键获取用户信息
		mav.addObject("user", this.userService.load(user_id));
		
		mav.setViewName("jsp/user/update");
		return mav;
	}
	
	@RequestMapping(value="/update",method=RequestMethod.PUT)
	public ModelAndView updateUser(User user){
		ModelAndView mav = new ModelAndView();
		try {
			this.userService.update(user);
			
			mav.addObject("flag", "success");
			mav.addObject("message", "编辑系统用户成功");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("flag", "error");
			mav.addObject("message", e.getMessage());
		}
		mav.setViewName("jsp/message");
		return mav;
	}
	
	
	@RequestMapping(value="/status",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> changeUserStatus(User user) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			this.userService.update(user);
			map.put("flag", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("message", "更新用户的状态失败啦!");
			map.put("flag", "error");
		}
		
		return map;
	}
	
	@RequestMapping(value="/role",method=RequestMethod.GET)
	public ModelAndView toChangeRolePage(Integer user_id){//标准写法 @RequestParam(name="user_id")Integer user_id
		ModelAndView mav = new ModelAndView();
		//获取可用角色的列表信息
		mav.addObject("roleList", this.roleService.getEnableRoleList());
		//通过主键获取用户信息
		mav.addObject("user", this.userService.load(user_id));
		
		mav.setViewName("jsp/user/role");
		return mav;
	}
	
	
	@RequestMapping(value="/role",method=RequestMethod.PUT)
	public ModelAndView changeUserRole(User user){
		ModelAndView mav = new ModelAndView();
		try {
			this.userService.update(user);
			
			mav.addObject("flag", "success");
			mav.addObject("message", "更新用户角色成功!");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("flag", "error");
			mav.addObject("message", e.getMessage());
		}
		mav.setViewName("jsp/message");
		return mav;
	}
	
	@RequestMapping(value="/detail/{user_id}",method=RequestMethod.GET)
	public ModelAndView toDetailPage(@PathVariable Integer user_id){
		ModelAndView mav = new ModelAndView();
		//通过主键获取用户信息--做简单的显示
		mav.addObject("user", this.userService.load(user_id));
		
		mav.setViewName("jsp/user/detail");
		return mav;
	}

}
