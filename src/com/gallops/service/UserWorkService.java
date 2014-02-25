package com.gallops.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.gallops.data.SQLAdapter;
import com.gallops.model.UserWork;
import com.gallops.util.StringConvert;

public class UserWorkService {
	private SqlSessionTemplate sqlSession;  
    
    public SqlSessionTemplate getSqlSession() {  
        return sqlSession;  
    }  
    public void setSqlSession(SqlSessionTemplate sqlSession) {  
        this.sqlSession = sqlSession;  
    }
      
    public UserWork findById(String id) {  
    	UserWork obj = null;  
        try {
        	obj = (UserWork)sqlSession.selectOne("UserWorkMapper.findById", id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return obj;
    }
    
    public List<UserWork> select() {  
    	List<UserWork> objs = null;  
        try {
        	objs = sqlSession.selectList("UserWorkMapper.select");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return objs;
    }
    
    public List<Map<String, String>> selectView(String userid) {  
    	List<Map<String, String>> objs = null;  
        try {
        	objs = sqlSession.selectList("UserWorkMapper.selectView", userid);
        	for(Map<String, String> item : objs) {
        		String allids = item.get("all_ids");
        		String[] ids = allids.split(";");
        		String sql = "";
    			for(int i = 0; i < ids.length; i++) {
        			String id = ids[i];
        			if(sql.length() >0)
        				sql += "," + "'/'" + ",";
        			sql += "(select name from e_dictionary where id = '" + id + "')";
        		}
    			sql = " select CONCAT( " + sql + " ) allnames ";
    			Map<String, String> names = sqlSession.selectOne("UserWorkMapper.selectSql", new SQLAdapter(sql));
    			item.put("all_name", names.get("allnames"));
        	}
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return objs;
    }
    
    public int insert(UserWork obj) {
    	int rtn = -1;
    	try {
    		String id = StringConvert.getUUIDString();
    		obj.setId(id);
    		rtn = sqlSession.insert("UserWorkMapper.insert", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int update(UserWork obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.update("UserWorkMapper.update", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int delete(UserWork obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.insert("UserWorkMapper.delete", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
}
