package com.gallops.data;

import java.util.List;

import com.gallops.model.Report;

public interface ReportMapper {

	List<Report> findAll();

	List<Report> findByConditions(Report report);

}
