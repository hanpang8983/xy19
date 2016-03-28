package com.hanpang.framework.rbac.role.service;

import java.util.List;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.rbac.menu.model.Menu;
import com.hanpang.framework.rbac.role.model.Role;

/**
 * 关于SYS_ROLE表的业务逻辑层
 * @author 刘文铭
 *
 */
public interface RoleService {
	/**
	 * 描述:获取所有的角色信息
	 * @return
	 */
	public List<Role> list();
	/**
	 * 描述:通过主键获取角色对象
	 * @param role_id
	 * @return
	 */
	public Role load(Integer role_id);
	/**
	 * 描述:添加角色操作
	 * @param role
	 * @throws RbacException
	 */
	public void add(Role role)throws RbacException;
	/**
	 * 描述:更新角色操作
	 * @param role
	 * @throws RbacException
	 */
	public void update(Role role)throws RbacException;
	/**
	 * 描述:删除角色操作
	 * 	实际上操作了中间表信息/用户表/角色表
	 * @param role
	 * @throws RbacException
	 */
	public void delete(Integer role_id)throws RbacException;
	/**
	 * 通过角色主键信息，获取该角色拥有的菜单信息
	 * @param role_id
	 * @return
	 */
	public List<Menu> getSelectedMenuByRoleId(Integer role_id);
	/**
	 * 通过角色主键信息，得到该角色未曾选择的角色信息
	 * @param role_id
	 * @return
	 */
	public List<Menu> getUnSelectedMenuByRoleId(Integer role_id);
	/**
	 * 描述:跟新该角色拥有的权限[其实就是操作中间表的维护]
	 * @param role_id
	 * @param menus
	 * @throws RbacException
	 */
	public void updateRolePermission(Integer role_id,Integer[] menus)throws RbacException;
	/**
	 * 检查角色名称是否重复
	 * @param role_name
	 * @throws RbacException
	 */
	public void validation(String role_name)throws RbacException;
	/**
	 * 描述:获取可用角色的列表信息，状态为1的为可用角色
	 * @return
	 */
	public List<Role> getEnableRoleList();
}
