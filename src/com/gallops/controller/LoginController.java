package com.gallops.controller;

import java.net.BindException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.portlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gallops.model.User;
import com.gallops.service.UserService;

@Controller
@SessionAttributes(value="loginUser") 
public class LoginController {
	@Autowired
	UserService service;
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public String login(String code, String password, Model model) {
		User p = new User();
		p.setCode(code);
		p.setPassword(password);
		User obj = service.findByCodeAndPwd(p);
		if(obj.getId().length() > 0) {
			model.addAttribute("loginUser", obj);
			return "index";
		} else 
			return "error";
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public String loginByGet() {
		return "login";
	}
	
	@RequestMapping(value="/loginout.do")
	public String loginOut(Model model, SessionStatus status) {
		status.setComplete();
		return "login";
	}
	
}
