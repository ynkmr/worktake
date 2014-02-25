package com.gallops.data;

import java.util.List;
import java.util.Map;

import com.gallops.model.Organization;

public interface OrganizationMapper {
	public int insert(Organization obj);
	
	public List<Map<String, String>> selectView();

	public Organization findById(String Id);

	public List<Organization> findAll();
	
	public List<Organization> findAllOthers();

	public int update(Organization obj);

	public int delete(String Id);

	public List<Organization> findByName(String name);

	public List<Organization> findByUser(String userId);

	public int insertByMap(Map<String, String> obj);

	public int updateByMap(Map<String, String> obj);
}
