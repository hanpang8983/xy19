package com.hanpang.framework.rbac.menu.mapper;

import java.util.List;
import java.util.Map;

import com.hanpang.framework.rbac.menu.model.Menu;
/**
 * 数据访问层:主要处理SYS_MENU和中间表ROLE_LINK_MENU的业务数据
 * @author 刘文铭
 *
 */
public interface MenuMapper {
	/**
	 * 描述:通过菜单主键删除菜单信息
	 * @param menu_id
	 * @return
	 */
	int delete(Integer menu_id);
	/**
	 * 描述:添加菜单操作
	 * @param menu
	 * @return
	 */
	int add(Menu menu);
	/**
	 * 描述:通过主键获取菜单信息
	 * @param menu_id
	 * @return com.hanpang.framework.rbac.menu.model.Menu
	 */
	Menu load(Integer menu_id);
	/**
	 * 描述:菜单更新操作
	 * @param menu
	 * @return int 更新的数据条数
	 */
	int update(Menu menu);
	/**
	 * 描述:通过角色ID获取子菜单的列表信息
	 * @param role_id
	 * @return List<Menu>
	 */
	List<Menu> getLeftMenuList(Integer role_id);
	/**
	 * 描述:通过角色ID获取子菜单的列表信息,所对应的父节点信息
	 * @param role_id
	 * @return
	 */
	List<Menu> getLeftParentMenuList(Integer role_id);
	/**
	 * 描述:通过父节点ID获取拥有的子节点信息
	 * @param parent_id
	 * @return
	 */
	List<Menu> getMenuListByParentId(Integer parent_id);
	/**
	 * 描述：验证操作，验证菜单名称是否重复
	 * @param map
	 * @return
	 */
	int validation(Map<String, Object> map);
	/**
	 * 描述:删除中间表的数据信息
	 * @param menu_id
	 */
	void deleteRoleLinkMenu(Integer menu_id);
	/**
	 * 描述:查询父节点下拥有的子节点的数量
	 * @param menu_id
	 * @return
	 */
	int queryChildCountByParentId(Integer menu_id);
	/**
	 * 描述:通过角色主键获取其拥有的菜单信息
	 * @param role_id
	 * @return
	 */
	List<Menu> getSelectedMenuListByRoleId(Integer role_id);
	/**
	 * 描述:通过角色主键获取其未拥有的菜单信息
	 * @param role_id
	 * @return
	 */
	List<Menu> getUnSelectedMenuListByRoleId(Integer role_id);
}