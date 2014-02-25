package com.gallops.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.gallops.model.AuthUserApprove;
import com.gallops.util.StringConvert;

public class AuthUserApprService {
private SqlSessionTemplate sqlSession;  
    
    public SqlSessionTemplate getSqlSession() {  
        return sqlSession;  
    }  
    public void setSqlSession(SqlSessionTemplate sqlSession) {  
        this.sqlSession = sqlSession;  
    }
      
    public AuthUserApprove findById(String id) {  
    	AuthUserApprove obj = null;  
        try {
        	obj = (AuthUserApprove)sqlSession.selectOne("AuthUserApprMapper.findById", id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return obj;
    }
    
    public List<AuthUserApprove> select() {  
    	List<AuthUserApprove> lst = null;  
        try {
        	lst = sqlSession.selectList("AuthUserApprMapper.select");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return lst;
    }
        
    public int insert(AuthUserApprove obj) {
    	int rtn = -1;
    	try {
    		String id = StringConvert.getUUIDString();
    		obj.setId(id);
    		rtn = sqlSession.insert("AuthUserApprMapper.insert", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int update(AuthUserApprove obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.update("AuthUserApprMapper.update", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int updateByMap(Map<String, String> obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.update("AuthUserApprMapper.updateByMap", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int insertByMap(Map<String, String> obj) {
    	int rtn = -1;
    	try {
    		String id = StringConvert.getUUIDString();
    		obj.put("id", id);
    		rtn = sqlSession.insert("AuthUserApprMapper.insertByMap", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int delete(String id) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.delete("AuthUserApprMapper.delete", id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int deleteByUserid(String userid) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.delete("AuthUserApprMapper.deleteByUserid", userid);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
}
