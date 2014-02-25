package com.gallops.service;

import java.util.Date;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import yn.ck.util.StringEX;

import com.gallops.model.User;

public class UserServiceTest {
	
	static ApplicationContext context;
	static UserService userService;
	static {
		context = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserService userService = (UserService)context.getBean("userService");
	}
	
	@Test
	public void getUser() {	    
		User userInfo = userService.findById("10003");  
		System.out.println(userInfo.getCode());
	}
	
	@Test
	public void addUser() {
		User u = new User();
		String id = new StringEX().getUUIDString().toString();
		u.setId(id);
		u.setCode(id.substring(0,15));
		u.setName("name" + id.substring(0,15));
		userService.insert(u);
	}
	
	@Test
	public void editUser() {
		User u = userService.findById("10003"); 
		u.setCode(new Date().toString());
		u.setName("name" + new Date().toString().substring(0,15));
		userService.insert(u);
	}
	
	@Test
	public void removeUser() {
		userService.delete("10003");
	}
}
