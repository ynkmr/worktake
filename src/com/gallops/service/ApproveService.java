package com.gallops.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.gallops.data.SQLAdapter;
import com.gallops.model.UserWork;

public class ApproveService {
private SqlSessionTemplate sqlSession;  
    
    public SqlSessionTemplate getSqlSession() {  
        return sqlSession;  
    }  
    public void setSqlSession(SqlSessionTemplate sqlSession) {  
        this.sqlSession = sqlSession;  
    }
    
    public List<Map<String, String>> select(String appvid) {  
    	List<Map<String, String>> objs = null;  
        try {
        	objs = sqlSession.selectList("UserWorkMapper.selectToApprove", appvid);
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
}
