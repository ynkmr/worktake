package com.gallops.data;

import java.util.List;
import java.util.Map;

import com.gallops.model.Result;

public interface ResultMapper {
	public int insert(Result obj);
	public int insertByMap(Map<String, String> obj);
	public Result findById(String Id);
	public List<Result> select();
	public int update(Result obj);
	public int updateByMap(Map<String, String> obj);
	public int delete(String Id);
	public List<Result> selectNotApproved(String Id);
}
