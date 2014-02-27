package com.gallops.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.gallops.model.Organization;
import com.gallops.util.StringConvert;

public class OrganizationService {

	private SqlSessionTemplate sqlSession;

	public SqlSessionTemplate getSqlSession() {
		return sqlSession;
	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	public Organization findById(String id) {
		Organization org = null;
		try {
			org = (Organization) sqlSession.selectOne(
					"OrganizationMapper.findById", id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return org;
	}

	public List<Map<String, String>> selectView() {
		List<Map<String, String>> organizations = null;
		try {
			organizations = sqlSession.selectList("OrganizationMapper.selectView");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return organizations;
	}
	
	public List<Map<String, Object>> selectTree() {
		List<Map<String, Object>> organizations = null;
		try {
			organizations = sqlSession.selectList("OrganizationMapper.selectTree");
			organizations = DictionaryService.recursionList(organizations);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return organizations;
	}

	public List<Organization> findAll() {
		List<Organization> organizations = null;
		try {
			organizations = sqlSession.selectList("OrganizationMapper.findAll");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return organizations;
	}

	public List<Map<String, Object>> findAllOthers(String id) {
		List<Map<String, Object>> organizations = null;
		try {
			organizations = sqlSession.selectList(
					"OrganizationMapper.findAllOthers", id);
			organizations = DictionaryService.recursionList(organizations);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return organizations;
	}

	public List<Organization> findByName(String name) {
		List<Organization> organizations = null;
		try {
			organizations = sqlSession.selectList(
					"OrganizationMapper.findByName", name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return organizations;
	}

	public List<Organization> findByUser(String userId) {
		List<Organization> organizations = null;
		try {
			organizations = sqlSession.selectList(
					"OrganizationMapper.findByUser", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return organizations;
	}

	public int insert(Organization obj) {
		int rtn = -1;
		try {
			String id = StringConvert.getUUIDString();
			obj.setId(id);
			rtn = sqlSession.insert("OrganizationMapper.insert", obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}

	public int update(Organization obj) {
		int rtn = -1;
		try {
			rtn = sqlSession.update("OrganizationMapper.update", obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}

	public int updateByMap(Map<String, String> obj) {
		int rtn = -1;
		try {
			rtn = sqlSession.update("OrganizationMapper.updateByMap", obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}

	public int insertByMap(Map<String, String> obj) {
		int rtn = -1;
		try {
			rtn = sqlSession.insert("OrganizationMapper.insertByMap", obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}

	public int delete(String id) {
		int rtn = -1;
		try {
			rtn = sqlSession.insert("OrganizationMapper.delete", id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rtn;
	}
}
