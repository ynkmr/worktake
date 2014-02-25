package com.gallops.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.gallops.model.Result;

public class ResultService {
private SqlSessionTemplate sqlSession;  
    
    public SqlSessionTemplate getSqlSession() {  
        return sqlSession;  
    }  
    public void setSqlSession(SqlSessionTemplate sqlSession) {  
        this.sqlSession = sqlSession;  
    }
      
    public Result findById(String id) {  
    	Result obj = null;  
        try {
        	obj = (Result)sqlSession.selectOne("ResultMapper.findById", id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return obj;
    }
    
    public List<Result> select() {  
    	List<Result> user = null;  
        try {
        	user = sqlSession.selectList("ResultMapper.select");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return user;
    }
    
    public List<Result> selectNotApproved(String Id) {
    	List<Result> user = null;  
        try {
        	user = sqlSession.selectList("ResultMapper.selectNotApproved", Id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return user;
    }
    
    public int insert(Result obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.insert("ResultMapper.insert", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int insertByMap(Map<String, String> obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.insert("ResultMapper.insertByMap", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int update(Result obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.update("ResultMapper.update", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int updateByMap(Map<String, String> obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.update("ResultMapper.updateByMap", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int delete(Result obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.insert("ResultMapper.delete", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
}
