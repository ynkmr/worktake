package com.gallops.model;

public class Dictionary {
	private String id;
	private String name;
	private String code;
	private String parent_id;
	private int type;
	private String all_ids;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getAll_ids() {
		return all_ids;
	}
	public void setAll_ids(String all_ids) {
		this.all_ids = all_ids;
	}
	
}
