package com.gallops.data;

import java.util.List;

import com.gallops.model.WorkItem;;

public interface WorkItemMapper {
	public int insert(WorkItem obj);
	public WorkItem findById(String Id);
	public List<WorkItem> select();
	public int update(WorkItem obj);
	public int delete(String Id);
}
