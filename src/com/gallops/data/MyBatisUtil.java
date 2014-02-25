package com.gallops.data;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyBatisUtil {
	private  final static SqlSessionFactory sqlSessionFactory; 
    static { 
       String resource = "com/gallops/data/mysql/Configuration.xml"; 
       Reader reader = null; 
       try {
           reader = Resources.getResourceAsReader(resource); 
       } catch (IOException e) { 
           System.out.println(e.getMessage()); 
           
       } 
       sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader); 
    } 
    
    public static SqlSessionFactory getSqlSessionFactory() { 
       return sqlSessionFactory; 
    } 
}
