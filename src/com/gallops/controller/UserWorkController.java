package com.gallops.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.gallops.model.User;
import com.gallops.model.UserWork;
import com.gallops.service.UserWorkService;

@Controller
@SessionAttributes(value="loginUser") 
public class UserWorkController {
	@Autowired
	UserWorkService service;
	
	@RequestMapping("/userwork/find.do")
	@ResponseBody
	public UserWork findById(@RequestParam("id")String id) {
		UserWork obj = service.findById(id);
		return obj;
	}
	
	@RequestMapping("/userwork/all.do")
	@ResponseBody
	public List<Map<String, String>> selectView(@ModelAttribute("loginUser") User user) {
		List<Map<String, String>> lst = service.selectView(user.getId());
		return lst;
	}
	
	@RequestMapping("/userwork/add.do")
	@ResponseBody
	public int insert(@RequestBody UserWork obj, @ModelAttribute("loginUser") User user) {
    	obj.setUser_id(user.getId());
		int rtn = service.insert(obj);
    	return rtn;
    }
	
	@RequestMapping("/userwork/edit.do")
	@ResponseBody
	public int update(@RequestBody UserWork obj, @ModelAttribute("loginUser") User user) {
		obj.setUser_id(user.getId());
		int rtn = service.update(obj);
    	return rtn;
    }
	
	@RequestMapping("/userwork/remove.do")
	@ResponseBody
	public int delete(@RequestBody UserWork obj) {
    	int rtn = service.delete(obj);
    	return rtn;
    }
	
	@RequestMapping(value="/userwork/save.do", method=RequestMethod.POST)
	@ResponseBody
	public int save(@RequestBody UserWork obj, @ModelAttribute("loginUser") User user) {
    	int rtn = 0;
    	if(obj.getId() != null && (obj.getId().length() > 0)) {
    		obj.setUser_id(user.getId());
    		rtn = service.update(obj);
    	} else {
    		if(obj.getSub_dic_id().length() > 0) {
    			String[] subs = obj.getSub_dic_id().split(";");
    			for(String subid : subs) {
    				obj.setSub_dic_id(subid);
    				obj.setUser_id(user.getId());
    				rtn = service.insert(obj);
    			}
    		}
    	}
    	return rtn;
    }
	
	@RequestMapping("/userwork/view.do")
	public String view_main() {
    	return "userwork";
    }
}
