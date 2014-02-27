package com.gallops.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.portlet.ModelAndView;

import com.gallops.model.AuthUserApprove;
import com.gallops.model.User;
import com.gallops.model.WorkItem;
import com.gallops.service.AuthUserApprService;
import com.gallops.service.ResultService;
import com.gallops.service.UserService;
import com.gallops.util.StringConvert;

@Controller
public class UserController {
	@Autowired
	UserService service;
	@Autowired
	AuthUserApprService authService;
	
	@RequestMapping("/user/find.do")
	@ResponseBody
	public User findById(@RequestParam("id")String id) {
		User obj = service.findById(id);
		return obj;
	}
	
	@RequestMapping("/user/all.do")
	@ResponseBody
	public List<User> select() {
		List<User> lst = service.select();
		return lst;
	}
	
	@RequestMapping("/user/allview.do")
	@ResponseBody
	public List<Map<String, String>> selectView() {
		List<Map<String, String>> lst = service.selectView();
		return lst;
	}
	
	@RequestMapping("/user/viewbyid.do")
	@ResponseBody
	public List<Map<String, String>> selectViewById(@RequestParam("id")String id) {
		List<Map<String, String>> lst = service.selectViewById(id);
		return lst;
	}
	
	@RequestMapping("/user/allothers.do")
	@ResponseBody
	public List<User> selectOthers(@RequestParam("id")String id) {
		List<User> lst = service.selectOthers(id);
		return lst;
	}
	
	@RequestMapping("/user/add.do")
	@ResponseBody
	public int insert(@RequestBody User obj) {
    	int rtn = service.insert(obj);
    	return rtn;
    }
	
	@RequestMapping("/user/edit.do")
	@ResponseBody
	public int update(@RequestBody User obj) {
    	int rtn = service.update(obj);
    	return rtn;
    }
	
	@RequestMapping(value="/user/save.do", method=RequestMethod.POST)
	@ResponseBody
	public int saveUser(@RequestBody Map<String, String> obj) {
    	int rtn = -1;
    	if(obj.containsKey("id") && (obj.get("id").length() > 0)) {
    		rtn = service.updateByMap(obj);
    	} else {
    		String id = StringConvert.getUUIDString();
    		obj.put("id", id);
    		rtn = service.insertByMap(obj);
    	}
    	return rtn;
    }
	
	@RequestMapping(value="/auth/saveauthapprove.do", method=RequestMethod.POST)
	@ResponseBody
	public int saveAuthApprove(@RequestBody Map<String, String> obj) {
    	int rtn = -1;
    	if(obj.containsKey("id") && (obj.get("id").length() > 0)) {
			String first = obj.get("first_approve_id");
			String second = obj.get("second_approve_id");
			String third = obj.get("third_approve_id");
			authService.deleteByUserid(obj.get("id"));
			if(first.length() > 0) {
				AuthUserApprove item = new AuthUserApprove();
				item.setApprove_user_id(first);
				item.setPrity_level(1);
				item.setUser_id(obj.get("id"));
				authService.insert(item);
			}
			if(second.length() > 0) {
				AuthUserApprove item = new AuthUserApprove();
				item.setApprove_user_id(second);
				item.setPrity_level(2);
				item.setUser_id(obj.get("id"));
				authService.insert(item);
			}
			if(third.length() > 0) {
				AuthUserApprove item = new AuthUserApprove();
				item.setApprove_user_id(third);
				item.setPrity_level(3);
				item.setUser_id(obj.get("id"));
				authService.insert(item);
			}
    	}
    	return rtn;
    }
	
	@RequestMapping("/user/remove.do")
	@ResponseBody
	public int delete(@RequestParam("id")String id) {
    	int rtn = service.delete(id);
    	return rtn;
    }
	
	@RequestMapping("/user/view.do")
	public String view_main() {
    	return "users";
    }
	
	@RequestMapping("/auth/approve_view.do")
	public String view_auth_approve() {
    	return "authapprove";
    }
	
}
