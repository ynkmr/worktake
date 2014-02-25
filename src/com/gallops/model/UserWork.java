package com.gallops.model;

import java.util.Date;

public class UserWork {
	private String id;
	private String approve_user_id;
	private String dic_id;
	private String s_time;
	private String e_time;
	private String status;
	private String sub_dic_id;
	private String memo;
	private String user_id;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getApprove_id() {
		return approve_user_id;
	}
	public void setApprove_id(String approve_user_id) {
		this.approve_user_id = approve_user_id;
	}
	public String getDic_id() {
		return dic_id;
	}
	public void setDic_id(String dic_id) {
		this.dic_id = dic_id;
	}
	public String getS_time() {
		return s_time;
	}
	public void setS_time(String s_time) {
		this.s_time = s_time;
	}
	public String getE_time() {
		return e_time;
	}
	public void setE_time(String e_time) {
		this.e_time = e_time;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSub_dic_id() {
		return sub_dic_id;
	}
	public void setSub_dic_id(String sub_dic_id) {
		this.sub_dic_id = sub_dic_id;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
}
