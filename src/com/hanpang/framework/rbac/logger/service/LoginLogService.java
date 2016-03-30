package com.hanpang.framework.rbac.logger.service;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.rbac.logger.model.LoginLog;

public interface LoginLogService {
	
	public void add(LoginLog loginLog)throws RbacException;

}
