package com.hanpang.framework.rbac.role.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.base.service.BaseServcie;
import com.hanpang.framework.rbac.menu.mapper.MenuMapper;
import com.hanpang.framework.rbac.menu.model.Menu;
import com.hanpang.framework.rbac.role.mapper.RoleMapper;
import com.hanpang.framework.rbac.role.model.Role;
import com.hanpang.framework.rbac.role.service.RoleService;
@Service("roleService")
public class RoleServiceImpl extends BaseServcie implements RoleService{
	
	private RoleMapper roleMapper;
	@Autowired
	public void setRoleMapper(RoleMapper roleMapper) {
		this.roleMapper = roleMapper;
	}
	
	private MenuMapper menuMapper;
	@Autowired
	public void setMenuMapper(MenuMapper menuMapper) {
		this.menuMapper = menuMapper;
	}

	@Override
	public Role load(Integer role_id) {
		return roleMapper.load(role_id);
	}

	@Override
	public void add(Role role) throws RbacException {
		try {
			this.roleMapper.add(role);
		} catch (Exception e) {
			throw new RbacException("角色新增失败,异常信息为:"+e.getMessage());
		}
		
	}

	@Override
	public void update(Role role) throws RbacException {
		try {
			this.roleMapper.update(role);
		} catch (Exception e) {
			throw new RbacException("角色更新失败,异常信息为:"+e.getMessage());
		}
		
	}

	@Override
	public void delete(Integer role_id) throws RbacException {
		try {
			String[] sqls = new String[3];
			//删除中间表的记录
			sqls[0]="delete from role_link_menu where fk_role_id="+role_id;
			sqls[1]="update sys_user set fk_role_id=null where fk_role_id="+role_id;
			sqls[2]="delete from sys_role where role_id="+role_id;
			
			this.jdbcTemplate.batchUpdate(sqls);
		} catch (Exception e) {
			throw new RbacException("注销失败,异常信息为:"+e.getMessage());
		}
		
		
	}

	@Override
	public List<Menu> getSelectedMenuByRoleId(Integer role_id) {
		return menuMapper.getSelectedMenuListByRoleId(role_id);
	}

	@Override
	public List<Menu> getUnSelectedMenuByRoleId(Integer role_id) {
		return menuMapper.getUnSelectedMenuListByRoleId(role_id);
	}

	@Override
	public void updateRolePermission(Integer role_id, Integer[] menus) throws RbacException {
		try {
			//第一种情况：对menus进行验证，看是否有值
			if(menus!=null&&menus.length>0){
				String[] sqls = new String[menus.length+1];
				//第一步:需要根据角色的ID，对中间表的数据进行删除操作
				sqls[0] = "delete from role_link_menu where fk_role_id="+role_id;
				//第二步:重新对于菜单信息进行添加操作，到中间表
				for (int i = 0; i < menus.length; i++) {
					sqls[i+1]="insert into role_link_menu (id,fk_role_id,fk_menu_id) values ('"+UUID.randomUUID().toString()+"',"+role_id+","+menus[i]+")";
				}
				//第三步:执行批量的sql语句
				this.jdbcTemplate.batchUpdate(sqls);
			}else{//第二种情况:如果menus为空，那么久直接情况中间表信息
				String sql = "delete from role_link_menu where fk_role_id="+role_id;
				this.jdbcTemplate.update(sql);
			}
			
		} catch (Exception e) {
			throw new RbacException("授权失败，异常信息为:"+e.getMessage());
		}
		
	}
	@Override
	public void validation(String role_name) throws RbacException {
		
		int count = this.roleMapper.validation(role_name);
		if(count>0){
			throw new RbacException("角色名称已经存在，请重新输入");
		}
		
		
		
	}

	@Override
	public List<Role> list() {
		return roleMapper.list();
	}

	@Override
	public List<Role> getEnableRoleList() {
		return this.roleMapper.getEnableRoleList();
	}

}
