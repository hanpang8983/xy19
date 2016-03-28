package com.hanpang.framework.rbac.role.model;

import java.util.List;

import com.hanpang.framework.rbac.menu.model.Menu;

public class Role implements java.io.Serializable{
	
	private static final long serialVersionUID = -8685923851170809260L;

	private Integer role_id;

    private String role_name;

    private String role_desc;

    private String role_status;
    
    private String role_photo;
    
    public String getRole_photo() {
		return role_photo;
	}

	public void setRole_photo(String role_photo) {
		this.role_photo = role_photo == null ? null : role_photo.trim();
	}

	private List<Menu> menuList;
    

    public List<Menu> getMenuList() {
		return menuList;
	}

	public void setMenuList(List<Menu> menuList) {
		this.menuList = menuList;
	}

	public Integer getRole_id() {
        return role_id;
    }

    public void setRole_id(Integer role_id) {
        this.role_id = role_id;
    }

    public String getRole_name() {
        return role_name;
    }

    public void setRole_name(String role_name) {
        this.role_name = role_name == null ? null : role_name.trim();
    }

    public String getRole_desc() {
        return role_desc;
    }

    public void setRole_desc(String role_desc) {
        this.role_desc = role_desc == null ? null : role_desc.trim();
    }

    public String getRole_status() {
        return role_status;
    }

    public void setRole_status(String role_status) {
        this.role_status = role_status == null ? null : role_status.trim();
    }
}