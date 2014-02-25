package com.gallops.data;

import java.util.List;
import java.util.Map;

import com.gallops.model.AuthUserApprove;

public interface AuthUserApprMapper {
	public int insert(AuthUserApprove obj);
	public AuthUserApprove findById(String Id);
	public List<AuthUserApprove> select();
	public int update(AuthUserApprove obj);
	public int delete(String Id);
	public int insertByMap(Map<String, String> obj);
	public int updateByMap(Map<String, String> obj);
	public int deleteByUserid(String userid);
}
