package com.gallops.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.gallops.model.Report;

public class ReportService {
	private SqlSessionTemplate sqlSession;

	public SqlSessionTemplate getSqlSession() {
		return sqlSession;
	}

	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Report> findAll() {
		return this.sqlSession.selectList("ReportMapper.findAll");
	}
	
	public List<Report> findByConditions(Report report){
		return this.sqlSession.selectList("ReportMapper.findByConditions",report);
	}
 

}
