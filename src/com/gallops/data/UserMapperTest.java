package com.gallops.data;

import java.io.IOException;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import com.gallops.model.User;

public class UserMapperTest {
	
	static SqlSessionFactory sqlSessionFactory = null; 
    static { 
       sqlSessionFactory = MyBatisUtil.getSqlSessionFactory(); 
    }
    
    @Test
    public void testAdd() { 
       SqlSession sqlSession = sqlSessionFactory.openSession();
       try { 
           UserMapper userMapper = sqlSession.getMapper(UserMapper.class); 
           User user = new User();
           user.setId("10003");
           user.setName("123333333");
           user.setCode("10003");
           userMapper.insert(user); 
           sqlSession.commit();
       } finally { 
           sqlSession.close(); 
       }
    } 
    
    @Test 
    public void getUser() {
       SqlSession sqlSession = sqlSessionFactory.openSession(); 
       try {
           UserMapper userMapper = sqlSession.getMapper(UserMapper.class); 
           User user = userMapper.findById("10002"); 
           System.out.println("name: "+user.getName()+"|code: "+user.getCode()); 
       } finally {
           sqlSession.close();
       }
    } 
}
