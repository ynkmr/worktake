package com.gallops.data;

import java.util.List;

import com.gallops.model.Dictionary;

public interface DictionaryMapper {
	public int insert(Dictionary obj);
	public Dictionary findById(String Id);
	public List<Dictionary> select();
	public int update(Dictionary obj);
	public int delete(String Id);
	public List<Dictionary> selectOthers(String id);
}
