package com.hanpang.framework.rbac.logger.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.rbac.logger.mapper.LoginLogMapper;
import com.hanpang.framework.rbac.logger.model.LoginLog;
import com.hanpang.framework.rbac.logger.service.LoginLogService;
@Service("loginLogService")
public class LoginLogServiceImpl implements LoginLogService {
	
	private LoginLogMapper loginLogMapper;
	@Autowired
	public void setLoginLogMapper(LoginLogMapper loginLogMapper) {
		this.loginLogMapper = loginLogMapper;
	}
	@Override
	public void add(LoginLog loginLog) throws RbacException {
		try {
			this.loginLogMapper.add(loginLog);
		} catch (Exception e) {
			throw new RbacException("登录日志失败");
		}
	}

}
