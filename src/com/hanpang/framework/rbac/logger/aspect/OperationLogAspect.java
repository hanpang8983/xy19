package com.hanpang.framework.rbac.logger.aspect;

import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.hanpang.framework.rbac.logger.model.OperationLog;
import com.hanpang.framework.rbac.logger.service.OperationLogService;
import com.hanpang.framework.rbac.user.model.User;

public class OperationLogAspect {
	
	private OperationLogService operationLogService;
	@Autowired
	public void setOperationLogService(OperationLogService operationLogService) {
		this.operationLogService = operationLogService;
	}


	//保存操作
	public void returnAdvice(JoinPoint jp){
		//获取HttpServletRequest
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		
		HttpSession session = request.getSession();
		
		User user = (User) session.getAttribute("session_user");
		
		OperationLog operationLog = new OperationLog();
		operationLog.setLog_id(UUID.randomUUID().toString());
		operationLog.setAccount(user.getAccount());
		operationLog.setUser_name(user.getUser_name());
		operationLog.setIp(request.getRemoteAddr());
		operationLog.setLog_time(new Date());
		
		//拼接操作的内容
		String content = jp.getTarget().getClass().getName() + "." + jp.getSignature().getName() + "--" + "访问路径为:"
                + request.getServletPath();
		
		operationLog.setLog_content(content);
		
		this.operationLogService.add(operationLog);
	}

}
