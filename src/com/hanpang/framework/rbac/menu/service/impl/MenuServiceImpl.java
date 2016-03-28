package com.hanpang.framework.rbac.menu.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.rbac.menu.mapper.MenuMapper;
import com.hanpang.framework.rbac.menu.model.Menu;
import com.hanpang.framework.rbac.menu.service.MenuService;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
	private MenuMapper menuMapper;

	@Autowired
	public void setMenuMapper(MenuMapper menuMapper) {
		this.menuMapper = menuMapper;
	}

	@Override
	public List<Menu> getLeftMenuList(Integer role_id) {
		return menuMapper.getLeftMenuList(role_id);
	}

	@Override
	public List<Menu> getLeftParentMenuList(Integer role_id) {
		return menuMapper.getLeftParentMenuList(role_id);
	}

	@Override
	public List<Menu> getMenuListByParentId(Integer parent_id) {
		return menuMapper.getMenuListByParentId(parent_id);
	}

	@Override
	public void add(Menu menu) {
		try {
			menuMapper.add(menu);
		} catch (RbacException e) {
			throw new RbacException("添加节点失败,异常信息:" + e.getMessage());
		}
	}

	@Override
	public void validation(String menu_name, Integer parent_id) throws RbacException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parent_id", parent_id);
		map.put("menu_name", menu_name);
		// ----------------
		// 验证的时候传递的数据为map
		int count = menuMapper.validation(map);
		if (count > 0) {
			throw new RbacException("改名称已经存在，请重新输入");
		}
	}

	@Override
	public Menu load(Integer menu_id) {
		return menuMapper.load(menu_id);
	}

	@Override
	public void update(Menu menu) {
		try {
			menuMapper.update(menu);
		} catch (RbacException e) {
			throw new RbacException("更新节点失败,异常信息:" + e.getMessage());
		}

	}

	@Override
	public void deleteChildMenu(Integer menu_id) throws RbacException {
		try {
			// 1.清空中间表的信息
			menuMapper.deleteRoleLinkMenu(menu_id);
			// 2.删除节点
			menuMapper.delete(menu_id);
		} catch (RbacException e) {
			throw new RbacException("删除子节点失败，异常信息为:"+e.getMessage());
		}

	}

	@Override
	public void deleteParentMenu(Integer menu_id) throws RbacException {
		try {
			// 1.如果有该父节点存在子节点，那么久提示客户需要自己先删除子节点后才能删除父节点
			int count = menuMapper.queryChildCountByParentId(menu_id);
			if (count > 0) {
				throw new RbacException("该父节点下存在子节点，不能进行删除操作!");
			} else {
				// 2.删除节点
				menuMapper.delete(menu_id);
			}
		} catch (Exception e) {
			throw new RbacException("删除父节点失败,异常信息:" + e.getMessage());
		}

	}

}
