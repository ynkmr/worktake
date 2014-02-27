package com.gallops.action;

import java.util.ArrayList;
import java.util.List;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class BaseAction<T> extends ActionSupport implements ModelDriven<T> {

	private static final long serialVersionUID = 1L;

	protected T model;
	protected List<T> list = new ArrayList<T>();

	public BaseAction(Class<T> clazz) {
		try {
			model = clazz.newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
	}

	@Override
	public T getModel() {
		return model;
	}

	public void setModel(T model) {
		this.model = model;
	}

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}
}
