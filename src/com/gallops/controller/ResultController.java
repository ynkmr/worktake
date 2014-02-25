package com.gallops.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallops.model.Result;
import com.gallops.service.ResultService;

@Controller
public class ResultController {
	@Autowired
	ResultService service;
	
	@RequestMapping("/result/find.do")
	@ResponseBody
	public Result findById(@RequestParam("id")String id) {
		Result obj = service.findById(id);
		return obj;
	}
	
	@RequestMapping("/result/all.do")
	@ResponseBody
	public List<Result> select() {
		List<Result> lst = service.select();
		return lst;
	}
	
	@RequestMapping("/result/allapprove.do")
	@ResponseBody
	public List<Result> selectNotApprove(@RequestParam("id")String id) {
		List<Result> lst = service.selectNotApproved(id);
		return lst;
	}
	
	@RequestMapping("/result/add.do")
	@ResponseBody
	public int insert(@RequestBody Result obj) {
    	int rtn = service.insert(obj);
    	return rtn;
    }
	
	@RequestMapping("/result/edit.do")
	@ResponseBody
	public int update(@RequestBody Result obj) {
    	int rtn = service.update(obj);
    	return rtn;
    }
	
	@RequestMapping("/result/remove.do")
	@ResponseBody
	public int delete(@RequestBody Result obj) {
    	int rtn = service.delete(obj);
    	return rtn;
    }
	
	@RequestMapping("/result/save.do")
	@ResponseBody
	public int save(@RequestBody Result obj) {
    	int rtn = 0;
    	if(obj.getId() != null && (obj.getId().length() > 0))
    		rtn = service.update(obj);
    	else
    		rtn = service.insert(obj);
    	return rtn;
    }
	
	@RequestMapping("/result/view.do")
	public String view_main() {
    	return "approve";
    }
}
