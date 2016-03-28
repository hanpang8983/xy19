package com.hanpang.framework.rbac.role.mapper;

import java.util.List;

import com.hanpang.framework.rbac.role.model.Role;

public interface RoleMapper {
    int delete(Integer role_id);

    int add(Role role);

    Role load(Integer role_id);

    int update(Role role);
    
    List<Role> list();
    
    int validation(String role_name);

}