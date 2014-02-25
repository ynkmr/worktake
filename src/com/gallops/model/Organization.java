package com.gallops.model;

public class Organization {

	private String id;
	private String name;
	private String code;
	private String memo;
	private String telephone;
	private String email;
	private String superior_id;
	private String parent_id;
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

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSuperior_id() {
		return superior_id;
	}

	public void setSuperior_id(String superior_id) {
		this.superior_id = superior_id;
	}

	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}

	public String getAll_ids() {
		return all_ids;
	}

	public void setAll_ids(String all_ids) {
		this.all_ids = all_ids;
	}

}
