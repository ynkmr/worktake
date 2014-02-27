package com.gallops.model;

import java.util.Date;

public class Report {
	private String top_dic_name;
	private String top_dic_id;
	private String user_name;
	private String user_id;
	private Date s_time;
	private Date e_time;
	private String status;
	private String sub_dic_id;
	private String sub_dic_name;
	private String org_name;
	private String org_id;
	private Double take_time;
	private Double sub_sum_time;
	private Double top_sum_time;

	public String getTop_dic_name() {
		return top_dic_name;
	}

	public void setTop_dic_name(String top_dic_name) {
		this.top_dic_name = top_dic_name;
	}

	public String getTop_dic_id() {
		return top_dic_id;
	}

	public void setTop_dic_id(String top_dic_id) {
		this.top_dic_id = top_dic_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getS_time() {
		return s_time;
	}

	public void setS_time(Date s_time) {
		this.s_time = s_time;
	}

	public Date getE_time() {
		return e_time;
	}

	public void setE_time(Date e_time) {
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

	public String getSub_dic_name() {
		return sub_dic_name;
	}

	public void setSub_dic_name(String sub_dic_name) {
		this.sub_dic_name = sub_dic_name;
	}

	public Double getTake_time() {
		return take_time;
	}

	public void setTake_time(Double take_time) {
		this.take_time = take_time;
	}

	public Double getSub_sum_time() {
		return sub_sum_time;
	}

	public void setSub_sum_time(Double sub_sum_time) {
		this.sub_sum_time = sub_sum_time;
	}

	public Double getTop_sum_time() {
		return top_sum_time;
	}

	public void setTop_sum_time(Double top_sum_time) {
		this.top_sum_time = top_sum_time;
	}

	public String getOrg_name() {
		return org_name;
	}

	public void setOrg_name(String org_name) {
		this.org_name = org_name;
	}

	public String getOrg_id() {
		return org_id;
	}

	public void setOrg_id(String org_id) {
		this.org_id = org_id;
	}

}
