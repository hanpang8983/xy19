package com.hanpang.framework.rbac.logger.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanpang.framework.base.exception.RbacException;
import com.hanpang.framework.rbac.logger.mapper.OperationLogMapper;
import com.hanpang.framework.rbac.logger.model.OperationLog;
import com.hanpang.framework.rbac.logger.service.OperationLogService;
@Service("operationLogService")
public class OperationLogServiceImpl implements OperationLogService {
	
	private OperationLogMapper operationLogMapper;
	@Autowired
	public void setOperationLogMapper(OperationLogMapper operationLogMapper) {
		this.operationLogMapper = operationLogMapper;
	}



	@Override
	public void add(OperationLog operationLog) throws RbacException {
		try {
			this.operationLogMapper.add(operationLog);
		} catch (Exception e) {
			throw new RbacException("操作日志保存失败,原因为:"+e.getMessage());
		}

	}

}
