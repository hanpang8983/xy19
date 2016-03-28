package com.hanpang.framework.rbac.user.service;

import java.util.List;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.base.model.Pager;
import com.hanpang.framework.rbac.user.model.User;
/**
 * 关于SYS_USER的业务逻辑层
 * @author Administrator
 *
 */
public interface UserService {
	/**
	 * 描述:用户登录信息
	 * @param account
	 * @param password
	 * @return
	 * @throws RbacException
	 */
	public User login(String account,String password)throws RbacException;
	
	public void add(User user)throws RbacException;
	
	public void update(User user)throws RbacException;
	
	public void delete(User user)throws RbacException;
	
	public void updateUserRole(Integer user_id,Integer role_id)throws RbacException;
	
	public List<User> list();
	
	public Pager find(Pager pager);
	
	public void validation(String account);

}
