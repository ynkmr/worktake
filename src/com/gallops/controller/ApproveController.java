package com.gallops.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.gallops.model.User;
import com.gallops.model.UserWork;
import com.gallops.service.ApproveService;

@Controller
@SessionAttributes(value="loginUser") 
public class ApproveController {
	
	@Autowired
	ApproveService service;
	
	@RequestMapping("/approve/view.do")
	public String view_main() {
    	return "approve";
    }
	
	@RequestMapping("/approve/all.do")
	@ResponseBody
	public List<Map<String, String>> select(@ModelAttribute("loginUser") User user) {
		List<Map<String, String>> lst = service.select(user.getId());
    	return lst;
    }
	
	@RequestMapping("/approve/doapprove.do")
	@ResponseBody
	public List<Map<String, String>> approve(@RequestBody UserWork obj, @ModelAttribute("loginUser") User user) {
		List<Map<String, String>> lst = null;
    	return lst;
    }
}
