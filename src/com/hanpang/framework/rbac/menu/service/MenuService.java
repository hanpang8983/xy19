package com.hanpang.framework.rbac.menu.service;

import java.util.List;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.rbac.menu.model.Menu;
/**
 * 业务逻辑层:主要处理SYS_MENU和中间表ROLE_LINK_MENU的业务数据
 * @author 刘文铭
 *
 */
public interface MenuService {
	/**
	 * 描述:通过角色主键ID获取拥有的子节点信息
	 * @param role_id
	 * @return List<Menu>
	 */
	public List<Menu> getLeftMenuList(Integer role_id);
	/**
	 * 描述:通过角色主键ID获取拥有的子节点信息的父节点列表
	 * @param role_id
	 * @return List<Menu>
	 */
	public List<Menu> getLeftParentMenuList(Integer role_id);
	/**
	 * 描述:通过父节点ID获取对应的子节点列表
	 * @param parent_id
	 * @return List<Menu>
	 */
	public List<Menu> getMenuListByParentId(Integer parent_id);
	/**
	 * 描述:菜单的添加操作
	 * @param menu
	 * @throws RbacException
	 */
	public void add(Menu menu)throws RbacException;
	/**
	 * 描述:菜单的更新操作
	 * @param menu
	 * @throws RbacException
	 */
	public void update(Menu menu)throws RbacException;
	/**
	 * 描述:验证菜单名称是否重复
	 * @param menu_name 菜单名称
	 * @param parent_id 父节点ID
	 * @throws RbacException
	 */
	public void validation(String menu_name,Integer parent_id)throws RbacException;
	/**
	 * 描述:通过主键获取菜单对象信息
	 * @param menu_id
	 * @return com.hanpang.framework.rbac.menu.model.Menu
	 */
	public Menu load(Integer menu_id);
	/**
	 * 描述:通过菜单主键删除子节点信息
	 * @param menu_id
	 * @throws RbacException
	 */
	public void deleteChildMenu(Integer menu_id)throws RbacException;
	/**
	 * 描述:通过菜单主键删除父节点信息
	 * @param menu_id
	 * @throws RbacException
	 */
	public void deleteParentMenu(Integer menu_id)throws RbacException;
}
