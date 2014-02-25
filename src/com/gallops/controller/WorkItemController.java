package com.gallops.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallops.model.WorkItem;
import com.gallops.service.WorkItemService;

@Controller
public class WorkItemController {
	@Autowired
	WorkItemService service;
	
	@RequestMapping("/workitem/find.do")
	@ResponseBody
	public WorkItem findById(@RequestParam("id")String id) {
		WorkItem obj = service.findById(id);
		return obj;
	}
	
	@RequestMapping("/workitem/all.do")
	@ResponseBody
	public List<WorkItem> select() {
		List<WorkItem> lst = service.select();
		return lst;
	}
	
	@RequestMapping("/workitem/add.do")
	@ResponseBody
	public int insert(@RequestBody WorkItem obj) {
    	int rtn = service.insert(obj);
    	return rtn;
    }
	
	@RequestMapping("/workitem/edit.do")
	@ResponseBody
	public int update(@RequestBody WorkItem obj) {
    	int rtn = service.update(obj);
    	return rtn;
    }
	
	@RequestMapping("/workitem/remove.do")
	@ResponseBody
	public int delete(@RequestBody WorkItem obj) {
    	int rtn = service.delete(obj);
    	return rtn;
    }
	
	@RequestMapping(value="/workitem/save.do", method=RequestMethod.POST)
	@ResponseBody
	public int save(@RequestBody WorkItem obj) {
    	int rtn = 0;
    	if(obj.getId() != null && (obj.getId().length() > 0))
    		rtn = service.update(obj);
    	else
    		rtn = service.insert(obj);
    	return rtn;
    }
	
	@RequestMapping("/workitem/view.do")
	public String view_main() {
    	return "workitems";
    }
}
