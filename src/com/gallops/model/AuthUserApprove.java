package com.gallops.model;

public class AuthUserApprove {
	private String id;
	private String user_id;
	private String approve_user_id;
	private int prity_level;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getApprove_user_id() {
		return approve_user_id;
	}
	public void setApprove_user_id(String approve_user_id) {
		this.approve_user_id = approve_user_id;
	}
	public int getPrity_level() {
		return prity_level;
	}
	public void setPrity_level(int prity_level) {
		this.prity_level = prity_level;
	}
	
}
