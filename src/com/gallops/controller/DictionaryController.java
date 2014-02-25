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

import com.gallops.model.Dictionary;
import com.gallops.service.DictionaryService;

@Controller
public class DictionaryController {
	@Autowired
	DictionaryService service;
	
	@RequestMapping("/dictionary/find.do")
	@ResponseBody
	public Dictionary findById(@RequestParam("id")String id) {
		Dictionary obj = service.findById(id);
		return obj;
	}
	
	@RequestMapping("/dictionary/all.do")
	@ResponseBody
	public Map<String, Object> select() {
		List<Dictionary> lst = service.select();
		Map<String, Object> obj = new HashMap<String, Object>();
		obj.put("rows", lst);
		obj.put("total", lst.size());
		return obj;
	}
	
	@RequestMapping("/dictionary/alltop.do")
	@ResponseBody
	public Map<String, Object> selectTop() {
		List<Dictionary> lst = service.selectTop();
		Map<String, Object> obj = new HashMap<String, Object>();
		obj.put("rows", lst);
		obj.put("total", lst.size());
		return obj;
	}
	
	@RequestMapping("/dictionary/allsub.do")
	@ResponseBody
	public Map<String, Object> selectSub() {
		List<Dictionary> lst = service.selectSub();
		Map<String, Object> obj = new HashMap<String, Object>();
		obj.put("rows", lst);
		obj.put("total", lst.size());
		return obj;
	}
	
	@RequestMapping("/dictionary/sublevel.do")
	@ResponseBody
	public List<Map<String, Object>> selectSubLevel(@RequestParam("dicid")String dicid) {
		List<Map<String, Object>> lst = service.selectSubLevel(dicid);
		return lst;
	}
	
	@RequestMapping("/dictionary/allsublevel.do")
	@ResponseBody
	public List<Map<String, Object>> selectAllSubLevel() {
		List<Map<String, Object>> lst = service.selectAllSubLevel();
		return lst;
	}
	
	@RequestMapping("/dictionary/toplevel.do")
	@ResponseBody
	public List<Dictionary> selectTopLevel() {
		List<Dictionary> lst = service.selectTopLevel();
		return lst;
	}
	
	@RequestMapping("/dictionary/allothers.do")
	@ResponseBody
	public List<Dictionary> selectOthers(@RequestParam("id")String id) {
		List<Dictionary> lst = service.selectOthers(id);
		return lst;
	}
	
	@RequestMapping("/dictionary/add.do")
	@ResponseBody
	public int insert(@RequestBody Dictionary obj) {
    	int rtn = service.insert(obj);
    	return rtn;
    }
	
	@RequestMapping("/dictionary/edit.do")
	@ResponseBody
	public int update(@RequestBody Dictionary obj) {
    	int rtn = service.update(obj);
    	return rtn;
    }
	
	@RequestMapping("/dictionary/remove.do")
	@ResponseBody
	public int delete(@RequestBody Dictionary obj) {
    	int rtn = service.delete(obj);
    	return rtn;
    }
	
	@RequestMapping(value="/dictionary/save.do", method=RequestMethod.POST)
	@ResponseBody
	public int save(@RequestBody Dictionary obj) {
    	int rtn = 0;
    	if(obj.getId() != null && (obj.getId().length() > 0))
    		rtn = service.update(obj);
    	else
    		rtn = service.insert(obj);
    	return rtn;
    }
	
	@RequestMapping("/dictionary/view.do")
	public String view_main() {
    	return "dictionary";
    }
	
	@RequestMapping("/dictionary/subview.do")
	public String view_sub() {
    	return "subdic";
    }
}
