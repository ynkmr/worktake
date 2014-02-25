package com.gallops.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import org.mybatis.spring.SqlSessionTemplate;

import com.gallops.model.Dictionary;
import com.gallops.util.StringConvert;

public class DictionaryService {
	private SqlSessionTemplate sqlSession;  
    
    public SqlSessionTemplate getSqlSession() {  
        return sqlSession;  
    }  
    public void setSqlSession(SqlSessionTemplate sqlSession) {  
        this.sqlSession = sqlSession;  
    }
      
    public Dictionary findById(String id) {  
    	Dictionary obj = null;  
        try {
        	obj = (Dictionary)sqlSession.selectOne("DictionaryMapper.findById", id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return obj;
    }
    
    public List<Dictionary> select() {  
    	List<Dictionary> objs = null;  
        try {
        	objs = sqlSession.selectList("DictionaryMapper.select");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return objs;
    }
    
    public List<Dictionary> selectTop() {  
    	List<Dictionary> objs = null;  
        try {
        	objs = sqlSession.selectList("DictionaryMapper.selectTop");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return objs;
    }
    
    public List<Dictionary> selectSub() {  
    	List<Dictionary> objs = null;  
        try {
        	objs = sqlSession.selectList("DictionaryMapper.selectSub");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return objs;
    }
    
    public List<Dictionary> selectOthers(String id) {  
    	List<Dictionary> objs = null;  
        try {
        	objs = sqlSession.selectList("DictionaryMapper.selectOthers", id);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return objs;
    }
    
    public List<Dictionary> selectTopLevel() {  
    	List<Dictionary> objs = null;  
        try {
        	objs = sqlSession.selectList("DictionaryMapper.selectTopLevel");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return objs;
    }
    
	private List<Map<String, Object>> recursionList(List<Map<String, Object>> lst) {
		Map<String, Object> preitem = null;
		List<Map<String, Object>> rtn = new ArrayList<Map<String,Object>>();
		Map<Integer, List<Map<String, Object>>> stacks = new HashMap<Integer, List<Map<String,Object>>>();
		stacks.put(0, rtn);
		int len = 0;
		List<Map<String, Object>> target = null;
		for (Map<String, Object> item : lst) {
			len = item.get("all_ids").toString().split(";").length;
			if(preitem == null)
				target = stacks.get(0);
			else {
				int prelen = preitem.get("all_ids").toString().split(";").length;
				int curlen = item.get("all_ids").toString().split(";").length;
				if(prelen == curlen - 1) {
					List<Map<String, Object>> sub = (List<Map<String, Object>>) preitem.get("children");
					if(sub == null) {
						sub = new ArrayList<Map<String,Object>>();
						preitem.put("children", sub);
						stacks.put(curlen - 1, sub);
					}
				}
				target = stacks.get(curlen - 1);
			}
			target.add(item);
			preitem = item;
		}
    	return rtn;
    }
    
    public List<Map<String, Object>> selectSubLevel(String id) {  
    	List<Map<String, Object>> objs = null;  
        try {
        	objs = sqlSession.selectList("DictionaryMapper.selectSubLevel", "%" + id + "%");
        	objs = recursionList(objs);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return objs;
    }
    
    public List<Map<String, Object>> selectAllSubLevel() {  
    	List<Map<String, Object>> objs = null;  
        try {
        	objs = sqlSession.selectList("DictionaryMapper.selectAllSubLevel");
        	objs = recursionList(objs);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return objs;
    }
    
    public int insert(Dictionary obj) {
    	int rtn = -1;
    	try {
    		String id = StringConvert.getUUIDString();
    		obj.setId(id);
    		if(obj.getParent_id().length() >0) {
    			Dictionary dic = findById(obj.getParent_id());
    			if(dic.getAll_ids().length() >0) {
    				obj.setAll_ids(dic.getAll_ids() + ";" + obj.getId());
    			}
    		} else {
        		obj.setAll_ids(obj.getId());
    		}
    		rtn = sqlSession.insert("DictionaryMapper.insert", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int update(Dictionary obj) {
    	int rtn = -1;
    	try {
    		if(obj.getParent_id().length() >0) {
    			Dictionary dic = findById(obj.getParent_id());
    			if(dic.getAll_ids().length() >0) {
    				obj.setAll_ids(dic.getAll_ids() + ";" + obj.getId());
    			}
    		} else {
        		obj.setAll_ids(obj.getId());
    		}	
    		rtn = sqlSession.update("DictionaryMapper.update", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
    
    public int delete(Dictionary obj) {
    	int rtn = -1;
    	try {
    		rtn = sqlSession.insert("DictionaryMapper.delete", obj);
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return rtn;
    }
}
