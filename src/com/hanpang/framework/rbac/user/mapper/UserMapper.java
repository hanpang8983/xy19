package com.hanpang.framework.rbac.user.mapper;

import java.util.List;
import java.util.Map;

import com.hanpang.framework.rbac.user.model.User;

public interface UserMapper {
    int delete(Integer user_id);

    int add(User user);
    
    User load(Integer user_id);

    int update(User user);
    
    User login(String account,String password);
    
    List<User> list();
    
    int validation(String account);
    
    List<User> find(Map<String,Object> map);
    
    int find_count();
    

}