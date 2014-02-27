package com.gallops.action;

import java.awt.Font;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.data.general.DefaultPieDataset;
import org.springframework.beans.factory.annotation.Autowired;

import com.gallops.model.Report;
import com.gallops.service.ReportService;

public class ReportAction extends BaseAction<Report> {

	private static final long serialVersionUID = 1L;

	private String input_start_time;
	private String input_end_time;
	@Autowired
	private ReportService reportService;

	private JFreeChart chart;

	public ReportAction() {
		super(Report.class);
	}

	@Override
	public String execute() throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yy");
		if (StringUtils.isNotEmpty(input_start_time))
			model.setS_time(sdf.parse(input_start_time));
		if (StringUtils.isNotEmpty(input_end_time))
			model.setE_time(sdf.parse(input_end_time));
		list = reportService.findByConditions(model);
		return SUCCESS;
	}

	public String userReport() throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yy");
		if (StringUtils.isNotEmpty(input_start_time))
			model.setS_time(sdf.parse(input_start_time));
		if (StringUtils.isNotEmpty(input_end_time))
			model.setE_time(sdf.parse(input_end_time));
		list = reportService.findByConditions(model);
		DefaultPieDataset dataset = new DefaultPieDataset();
		createPieChart(model.getUser_name(), dataset);
		return SUCCESS;
	}

	public String subDicReport() throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yy");
		if (StringUtils.isNotEmpty(input_start_time))
			model.setS_time(sdf.parse(input_start_time));
		if (StringUtils.isNotEmpty(input_end_time))
			model.setE_time(sdf.parse(input_end_time));
		list = reportService.findByConditions(model);
		DefaultPieDataset dataset = new DefaultPieDataset();
		double percent;
		for (Report report : list) {
			percent = report.getTake_time() / report.getSub_sum_time();
			dataset.setValue(
					"[" + report.getUser_name() + "]-["
							+ report.getSub_dic_name() + "]-["
							+ report.getTake_time() + "小时("
							+ formatPercent(percent) + ")]", percent);
		}
		createPieChart(model.getSub_dic_name(), dataset);
		return SUCCESS;
	}

	public String topDicReport() throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yy");
		if (StringUtils.isNotEmpty(input_start_time))
			model.setS_time(sdf.parse(input_start_time));
		if (StringUtils.isNotEmpty(input_end_time))
			model.setE_time(sdf.parse(input_end_time));
		list = reportService.findByConditions(model);
		DefaultPieDataset dataset = new DefaultPieDataset();
		double percent;
		for (Report report : list) {
			percent = report.getTake_time() / report.getTop_sum_time();
			dataset.setValue(
					"[" + report.getUser_name() + "]-["
							+ report.getSub_dic_name() + "]-["
							+ report.getTake_time() + "小时("
							+ formatPercent(percent) + ")]", percent);
		}
		createPieChart(model.getTop_dic_name(), dataset);
		return SUCCESS;
	}

	private void createPieChart(String title, DefaultPieDataset dataset) {
		StandardChartTheme standardChartTheme = new StandardChartTheme("CN");
		standardChartTheme.setExtraLargeFont(new Font("微软雅黑", Font.BOLD, 20));
		standardChartTheme.setRegularFont(new Font("微软雅黑", Font.PLAIN, 15));
		standardChartTheme.setLargeFont(new Font("微软雅黑", Font.PLAIN, 15));
		ChartFactory.setChartTheme(standardChartTheme);
		chart = ChartFactory
				.createPieChart3D(title, dataset, true, true, false);
	}

	private String formatPercent(Double percent) {
		return new BigDecimal(percent * 100).setScale(2,
				BigDecimal.ROUND_HALF_UP).doubleValue()
				+ "%";
	}

	public void setReportService(ReportService reportService) {
		this.reportService = reportService;
	}

	public JFreeChart getChart() {
		return chart;
	}

	public void setChart(JFreeChart chart) {
		this.chart = chart;
	}

	public String getInput_start_time() {
		return input_start_time;
	}

	public void setInput_start_time(String input_start_time) {
		this.input_start_time = input_start_time;
	}

	public String getInput_end_time() {
		return input_end_time;
	}

	public void setInput_end_time(String input_end_time) {
		this.input_end_time = input_end_time;
	}

}
