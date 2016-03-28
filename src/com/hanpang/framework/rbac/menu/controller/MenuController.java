package com.hanpang.framework.rbac.menu.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hanpang.framework.base.controller.SysControler;
import com.hanpang.framework.rbac.menu.model.Menu;
import com.hanpang.framework.rbac.menu.service.MenuService;

/**
 * 控制器：处理表SYS_MENU的
 * 
 * @author 刘文铭
 *
 */
@Controller
@Scope("prototype")
@RequestMapping("/sys/menu")
public class MenuController extends SysControler {
	private MenuService menuService;
	@Autowired
	//@Qualifier("menuService")
	public void setMenuService(MenuService menuService) {
		this.menuService = menuService;
	}

	/**
	 * 描述:获取所有的父节点列表
	 * 
	 * @return
	 */
	@RequestMapping("/parent/list")
	public ModelAndView getParentMenuList() {
		ModelAndView mav = new ModelAndView();
		// 因为根节点的默认为-1，获取所有的父节点信息
		mav.addObject("parentMenuList", menuService.getMenuListByParentId(-1));
		// 跳转到显示parent_list.jsp页面
		mav.setViewName("jsp/menu/parent_list");

		return mav;
	}

	/**
	 * 描述:跳转父节点和子节点的添加操页面
	 * 
	 * @param type
	 *            parent：代表父节点添加页面 child:代表子节点添加页面
	 * @return
	 */
	@RequestMapping(value = "/{type}/add", method = RequestMethod.GET)
	public ModelAndView toAdd(@PathVariable String type) {
		ModelAndView mav = new ModelAndView();
		if (type.equals("parent")) {
			// 跳转到显示parent_add.jsp页面
			mav.setViewName("jsp/menu/parent_add");
		} else {
			// 因为根节点的默认为-1，获取所有的父节点信息
			mav.addObject("parentMenuList", menuService.getMenuListByParentId(-1));
			// 跳转到显示child_add.jsp页面
			mav.setViewName("jsp/menu/child_add");
		}

		return mav;

	}

	/**
	 * 描述:节点添加操作，不管父节点还是子节点都使用一个添加方式，POST请求
	 * 
	 * @param com.hanpang.framework.rbac.menu.model.Menu
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView add(Menu menu) {
		ModelAndView mav = new ModelAndView();
		try {
			menuService.add(menu);
			mav.addObject("message", "添加节点成功，节点名称为:" + menu.getMenu_name());
			mav.addObject("flag", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("message", "添加节点失败，详细信息为:" + e.getMessage());
			mav.addObject("flag", "error");
		}
		// 所有的更新页面和添加页面后的处理页面
		mav.setViewName("jsp/message");

		return mav;

	}

	/**
	 * 描述:通过父节点ID，验证菜单名称是否重复，在一个目录下的名称不允许重复
	 * 
	 * @see 使用的AJAX方式的验证
	 * @param menu_name
	 *            菜单名称
	 * @param parent_id
	 *            父节点ID
	 * @return Map<String, Object> 自动解析为JSON对象
	 */
	@RequestMapping("/{parent_id}/name")
	@ResponseBody
	public Map<String, Object> validation(String menu_name, @PathVariable Integer parent_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			menuService.validation(menu_name, parent_id);
			map.put("message", "该名称使用");
			map.put("flag", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("message", e.getMessage());
			map.put("flag", "error");
		}

		return map;
	}

	/**
	 * 描述:通过父节点显示子节点列表，通过的是AJAX方式显示
	 * 
	 * @param parent_id
	 *            父节点ID
	 * @return
	 */
	@RequestMapping("/child/list")
	@ResponseBody
	public List<Menu> getChildMenuListByParentId(Integer parent_id) {
		return menuService.getMenuListByParentId(parent_id);
	}

	/**
	 * 描述:更新操作，通过类型[TYPE]的判断，跳转到不同的更新页面
	 * 
	 * @param type
	 *            parent：代表父节点更新页面 child:代表子节点更新页面
	 * @param menu_id
	 * @return
	 */
	@RequestMapping(value = "/{type}/update/{menu_id}", method = RequestMethod.GET)
	public ModelAndView toUpdate(@PathVariable String type, @PathVariable Integer menu_id) {
		ModelAndView mav = new ModelAndView();
		if (type.equals("parent")) {
			// 通过主键获取节点信息
			mav.addObject("parent_menu", menuService.load(menu_id));
			mav.setViewName("jsp/menu/parent_update");
		} else {
			// 查询所有的父节点信息
			mav.addObject("parentMenuList", menuService.getMenuListByParentId(-1));
			// 通过主键获取节点信息
			mav.addObject("child_menu", menuService.load(menu_id));
			mav.setViewName("jsp/menu/child_update");
		}

		return mav;

	}

	/**
	 * 描述：节点的更新操作，前端使用的是PUT请求
	 * 
	 * @param com.hanpang.framework.rbac.menu.model.Menu
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.PUT)
	public ModelAndView update(Menu menu) {
		ModelAndView mav = new ModelAndView();
		try {
			menuService.update(menu);
			mav.addObject("message", "更新节点成功，节点名称为:" + menu.getMenu_name());
			mav.addObject("flag", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("message", "更新点失败，详细信息为:" + e.getMessage());
			mav.addObject("flag", "error");
		}
		// 所有的更新页面和添加页面后的处理页面
		mav.setViewName("jsp/message");

		return mav;

	}

	/**
	 * 描述:更新操作，通过类型[TYPE]的判断，进行子节点删除操作和父节点删除操作 AJAX方式，使用的是DELETE请求方式
	 * 
	 * @param type
	 * @param menu_id
	 * @return Map<String, Object>
	 */
	@RequestMapping(value = "/{type}/delete", method = RequestMethod.DELETE)
	@ResponseBody
	public Map<String, Object> deleteMenu(@PathVariable String type, Integer menu_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (type.equalsIgnoreCase("parent")) {
				menuService.deleteParentMenu(menu_id);
			} else {
				// 调用子节点删除操作
				menuService.deleteChildMenu(menu_id);
			}
			map.put("message", "删除节点成功!");
			map.put("flag", "success");
		} catch (Exception e) {
			map.put("message", "删除节点失败，异常信息为:" + e.getMessage());
			map.put("flag", "error");
		}
		return map;
	}

}
