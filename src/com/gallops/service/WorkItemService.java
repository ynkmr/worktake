package com.gallops.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.gallops.model.WorkItem;
import com.gallops.util.StringConvert;

public class WorkItemService {
	private SqlSessionTemplate sqlSession;  
    
    public SqlSessionTemplate getSqlSession() {  
        return sqlSession;  
    }  
    public void setSqlSession(SqlSessionTemplate sqlSession) {  
        this.sqlSession = sqlSession;  
    }
      
    public WorkItem findById(String id) {  
    	WorkItem obj = null;  
        try {
        	obj = (WorkItem)sqlSession.selectOne("WorkItemMapper.findById", id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return obj;
    }
    
    public List<WorkItem> select() {  
    	List<WorkItem> user = null;  
        try {
        	user = sqlSession.selectList("WorkItemMapper.select");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return user;
    }
    
    public int insert(WorkItem obj) {
    	int rtn = -1;
    	try {
    		String id = StringConvert.getUUIDString();
    		obj.setId(id);
    		rtn = sqlSession.insert("WorkItemMapper.insert", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int update(WorkItem obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.update("WorkItemMapper.update", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int delete(WorkItem obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.insert("WorkItemMapper.delete", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
}
