package com.hanpang.framework.rbac.user.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.base.model.Pager;
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

	@Override
	public Pager find(Pager pager) {
		//1.传递数据使用Map
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("pageNow", (pager.getPageNow()-1)*pager.getPageSize());
		map.put("pageSize", pager.getPageSize());
		
		//2.获取了分页的数据
		List<User> userList = this.userMapper.find(map);
		//存储到Pager里面
		pager.setDatas(userList);
		//3.总记录数
		int totalCount = this.userMapper.find_count();
		pager.setTotalCount(totalCount);
		//总页数
		int pageSize = pager.getPageSize();
		int totalPages = totalCount%pageSize==0?totalCount/pageSize:totalCount/pageSize+1;
		pager.setTotalPages(totalPages);
		
		return pager;
	}

}
