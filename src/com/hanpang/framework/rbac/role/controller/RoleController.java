package com.hanpang.framework.rbac.role.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hanpang.framework.base.controller.SysControler;
import com.hanpang.framework.rbac.role.model.Role;
import com.hanpang.framework.rbac.role.service.RoleService;
@Controller
@Scope("prototype")
@RequestMapping("/sys/role")
public class RoleController extends SysControler {
	
	//private Logger logger = Logger.getLogger(RoleController.class);
	
	private RoleService roleService;
	@Autowired
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	/**
	 * 描述:跳转到角色列表页面
	 * 传递数据:角色列表数据List<Role>
	 * @return
	 */
	@RequestMapping("/list")
	public ModelAndView list(){
		ModelAndView mav = new ModelAndView();
		try {
			mav.addObject("roleList", this.roleService.list());
			mav.setViewName("jsp/role/list");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	/**
	 * 描述:跳转到角色授权页面
	 * 请求方式:GET
	 * 传递数据:占位符传递角色主键ID
	 * 		1.角色对象
	 * 		2.该角色未拥有的菜单信息
	 * 		3.该角色拥有的菜单信息
	 * @param role_id
	 * @return
	 */
	@RequestMapping(value="/permission/{role_id}",method=RequestMethod.GET)
	public ModelAndView toPermissionPage(@PathVariable Integer role_id){
		ModelAndView mav = new ModelAndView();
		try {
			mav.addObject("role",this.roleService.load(role_id));
			mav.addObject("unSelectedMenuList",this.roleService.getUnSelectedMenuByRoleId(role_id));
			mav.addObject("selectedMenuList",this.roleService.getSelectedMenuByRoleId(role_id));
			
			mav.setViewName("jsp/role/permission");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@RequestMapping(value="/permission",method=RequestMethod.PUT)
	public ModelAndView updatePermission(Integer role_id,Integer[] menus){
		ModelAndView mav = new ModelAndView();
		try {
			//调用授权更新
			this.roleService.updateRolePermission(role_id, menus);
			//提示信息
			mav.addObject("message", "授权成功，如果是当前用户会自动刷新!");
			mav.addObject("flag", "success");
		} catch (Exception e) {
			mav.addObject("message", e.getMessage());
			mav.addObject("flag", "error");
		}
		mav.setViewName("jsp/message");
		
		return mav;
	}
	
	@RequestMapping(value="/update/{role_id}",method=RequestMethod.GET)
	public ModelAndView toUpdatePage(@PathVariable Integer role_id){
		ModelAndView mav = new ModelAndView();
		try {
			mav.addObject("role", this.roleService.load(role_id));
			mav.setViewName("jsp/role/update");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	/**
	 * 描述:Ajax上传
	 * 返回数据:新的文件名称
	 * @param photo
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping(value="/upload",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadPhoto(MultipartFile photo) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			if(photo!=null){
				//1.获取绝对路径
				String path = this.session.getServletContext().getRealPath("/upload/role");
				//2.建立联系
				File folder = new File(path);
				if(!folder.isDirectory()){
					folder.mkdirs();
				}
				//3.获取上传文件的名称
				String fileName = photo.getOriginalFilename();
				//4.获取后缀名
				String ext = FilenameUtils.getExtension(fileName);
				//5.生成新的名
				String newName = UUID.randomUUID().toString()+"."+ext;
				//6.创建空的文件
				File newFile = new File(path+"/"+newName);
				//7.复制
				photo.transferTo(newFile);
				//8.返回数据
				map.put("newName", newName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
	/**
	 * 描述:角色更新操作
	 * 传递数据:角色对象
	 * 请求方式为:PUT请求
	 * @param role
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.PUT)
	public ModelAndView updateRole(Role role){
		ModelAndView mav = new ModelAndView();
		try {
			//调用授权更新
			this.roleService.update(role);
			//提示信息
			mav.addObject("message", "更新角色信息成功!");
			mav.addObject("flag", "success");
		} catch (Exception e) {
			mav.addObject("message", e.getMessage());
			mav.addObject("flag", "error");
		}
		mav.setViewName("jsp/message");
		
		return mav;
	}
	/**
	 * 描述:验证角色名称是否重复
	 * 传递数据:角色的名称
	 * @param role_name
	 * @return
	 */
	@RequestMapping(value="/name",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> validation(String role_name) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			this.roleService.validation(role_name);
			map.put("flag", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("message", e.getMessage());
			map.put("flag", "error");
		}
		
		
		return map;
	}
	/**
	 * 描述:更新角色的状态
	 * 传递数据:角色对象中包括主键ID和状态信息
	 * @param role
	 * @return
	 */
	@RequestMapping(value="/status",method=RequestMethod.PUT)
	@ResponseBody
	public Map<String, Object> updateStatus(Role role) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			this.roleService.update(role);
			map.put("flag", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("message", e.getMessage());
			map.put("flag", "error");
		}
		
		
		return map;
	}
	/**
	 * 描述:为的就是练习使用，多条SQL语句批量执行
	 * @param role_id
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> deleteRole(Integer role_id) {
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			this.roleService.delete(role_id);
			map.put("flag", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("message", e.getMessage());
			map.put("flag", "error");
		}
		
		
		return map;
	}
	/**
	 * 描述:跳转角色添加页面
	 * 
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String toAddPage(){
		return "jsp/role/add";
	}
	
	/**
	 * 描述:角色添加曹组
	 * 数据传递:页面上的所有数据
	 * @param role
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public ModelAndView addRole(Role role){
		ModelAndView mav = new ModelAndView();
		try {
			//调用授权更新
			this.roleService.add(role);
			//提示信息
			mav.addObject("message", "新增角色信息成功!");
			mav.addObject("flag", "success");
		} catch (Exception e) {
			mav.addObject("message", e.getMessage());
			mav.addObject("flag", "error");
		}
		mav.setViewName("jsp/message");
		
		return mav;
	}
	

}
