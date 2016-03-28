package com.hanpang.framework.rbac.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.rbac.user.mapper.UserMapper;
import com.hanpang.framework.rbac.user.model.User;
import com.hanpang.framework.rbac.user.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {

	private UserMapper userMapper;

	@Autowired
	public void setUserMapper(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	@Override
	public User login(String account, String password) throws RbacException {

		User user = userMapper.login(account, password);
		// 判断
		if (user == null) {
			throw new RbacException("账号或者密码错误，请重新登录");
		} else {
			// 用户存在
			if (user.getStatus().equals("2")) {
				throw new RbacException("您的账号已经被冻结，请联系管理员");
			} else {
				// 是否拥有角色信息
				if (user.getRole() == null) {
					throw new RbacException("您暂时满员分配角色，登录没有用!");
				} else {
					// 判断角色的状态是否可用
					if (user.getRole().getRole_status().equals("2")) {
						throw new RbacException("角色正在审核或者禁用当中，您登录无效!");
					} else {
						return user;
					}
				}
			}

		}

	}

	@Override
	public void add(User user) throws RbacException {
		try {
			this.userMapper.add(user);
		} catch (Exception e) {
			throw new RbacException("新增系统用户失败,异常信息为:"+e.getMessage());
		}
	}

	@Override
	public void update(User user) throws RbacException {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(User user) throws RbacException {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateUserRole(Integer user_id, Integer role_id) throws RbacException {
		// TODO Auto-generated method stub

	}

	@Override
	public List<User> list() {
		return this.userMapper.list();
	}

	@Override
	public void validation(String account) {
		int count = this.userMapper.validation(account);
		if(count>0){
			throw new RbacException("改账号已经被使用,请重新输入");
		}
		
	}

}
