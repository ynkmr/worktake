package com.gallops.model;

public class WorkItem {
	private String id;
	private String name;
	private String code;
	private String upper_work_id;
	private String upper_all_ids;
	private String type_id;
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
	public String getUpper_work_id() {
		return upper_work_id;
	}
	public void setUpper_work_id(String upper_work_id) {
		this.upper_work_id = upper_work_id;
	}
	
	public String getType_id() {
		return type_id;
	}
	public void setType_id(String type_id) {
		this.type_id = type_id;
	}
	public String getUpper_all_ids() {
		return upper_all_ids;
	}
	public void setUpper_all_ids(String upper_all_ids) {
		this.upper_all_ids = upper_all_ids;
	}
	
	public WorkItem() {
		
	}
	
}
