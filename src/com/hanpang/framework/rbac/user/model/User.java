package com.hanpang.framework.rbac.user.model;

import java.util.Date;

import com.hanpang.framework.rbac.role.model.Role;

public class User implements java.io.Serializable{
	private static final long serialVersionUID = 8793050767406942160L;

	private Integer user_id;

    private String account;

    private String password;

    private String user_name;

    private String sex;

    private String tel;

    private Date create_date;

    private String status;

    private Integer fk_role_id;
    
    private String user_image;
    
    
    //多对一的关系
    private Role role;
    

    public String getUser_image() {
		return user_image;
	}

	public void setUser_image(String user_image) {
		 this.user_image = user_image == null ? null : user_image.trim();
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name == null ? null : user_name.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public Date getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Date create_date) {
        this.create_date = create_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Integer getFk_role_id() {
        return fk_role_id;
    }

    public void setFk_role_id(Integer fk_role_id) {
        this.fk_role_id = fk_role_id;
    }
}