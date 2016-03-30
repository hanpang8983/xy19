package com.hanpang.framework.rbac.logger.mapper;

import com.hanpang.framework.rbac.logger.model.LoginLog;

public interface LoginLogMapper {
    int delete(String log_id);

    int add(LoginLog loginLog);

    LoginLog load(String log_id);

    int update(LoginLog record);

}