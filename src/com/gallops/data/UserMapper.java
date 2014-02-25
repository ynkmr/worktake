package com.gallops.data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gallops.model.User;

public interface UserMapper {
	public int insert(User obj);
	public User findById(String Id);
	public List<User> select();
	public int update(User obj);
	public int delete(String Id);
	public List<Map<String, String>> selectView();
	public List<Map<String, String>> selectViewById(String Id);
	public List<User> selectOthers(String id);
	public int insertByMap(Map<String, String> obj);
	public int updateByMap(Map<String, String> obj);
}
