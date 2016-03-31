package com.hanpang.framework.rbac.logger.service;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.rbac.logger.model.LoginLog;
import com.hanpang.framework.rbac.logger.model.OperationLog;

public interface OperationLogService {
	
	public void add(OperationLog operationLog)throws RbacException;

}
