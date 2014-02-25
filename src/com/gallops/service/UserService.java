package com.gallops.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gallops.model.User;
import com.gallops.util.StringConvert;

public class UserService {
	
	private SqlSessionTemplate sqlSession;  
    
    public SqlSessionTemplate getSqlSession() {  
        return sqlSession;  
    }  
    public void setSqlSession(SqlSessionTemplate sqlSession) {  
        this.sqlSession = sqlSession;  
    }
      
    public User findById(String id) {  
    	User user = null;  
        try {
        	user = (User)sqlSession.selectOne("UserMapper.findById", id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return user;
    }
    
    public User findByCodeAndPwd(User login) {  
    	User user = null;  
        try {
        	user = (User)sqlSession.selectOne("UserMapper.findByCodeAndPwd", login);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return user;
    }
    
    public List<User> select() {  
    	List<User> user = null;  
        try {
        	user = sqlSession.selectList("UserMapper.select");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return user;
    }
    
    public List<Map<String, String>> selectView() {  
    	List<Map<String, String>> user = null;  
        try {
        	user = sqlSession.selectList("UserMapper.selectView");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return user;
    }
    
    public List<Map<String, String>> selectViewById(String Id) {
    	List<Map<String, String>> user = null;  
        try {
        	user = sqlSession.selectList("UserMapper.selectViewById", Id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return user;
    }
    
    public List<User> selectOthers(String id) {
    	List<User> user = null;  
        try {
        	user = sqlSession.selectList("UserMapper.selectOthers", id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return user;
    }
    
    public int insert(User obj) {
    	int rtn = -1;
    	try {
    		String id = StringConvert.getUUIDString();
    		obj.setId(id);
    		rtn = sqlSession.insert("UserMapper.insert", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int update(User obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.update("UserMapper.update", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int updateByMap(Map<String, String> obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.update("UserMapper.updateByMap", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int insertByMap(Map<String, String> obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.insert("UserMapper.insertByMap", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int delete(String id) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.insert("UserMapper.delete", id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
}
