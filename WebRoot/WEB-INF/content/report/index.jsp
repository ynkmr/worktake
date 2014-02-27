<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sb" uri="/struts-bootstrap-tags"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> --%>
<head>
<sj:head jqueryui="true" locale="zh-CN" />
<sb:head />
<script type="javascript"
	src="<s:url value="/js/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript"
	src="<s:url value="/js/jquery.jqprint-0.3.js" />"></script>
<style media=print>
.no-print {
	display: none;
}
</style>
</head>
<div class="row-fluid no-print">
	<form class="form-search"
		action="<s:url namespace="/report" action="index"/>">
		<input class="input-small" value="${model.top_dic_name}" type="text"
			placeholder="<s:text name="keywords.top"/>" name="model.top_dic_name" />
		<input class="input-small" value="${model.sub_dic_name}" type="text"
			placeholder="<s:text name="keywords.sub"/>" name="model.sub_dic_name" />
		<input class="input-small" value="${model.org_name}" type="text"
			placeholder="<s:text name="keywords.org"/>" name="model.org_name" />
		<input class="input-small" value="${model.user_name}" type="text"
			placeholder="<s:text name="keywords.name"/>" name="model.user_name" />
		<sj:datepicker name="input_start_time" value="%{input_start_time}"
			placeholder="%{getText('keywords.startTime')}" />
		<sj:datepicker name="input_end_time" value="%{input_end_time}"
			placeholder="%{getText('keywords.endTime')}" />
		<s:a cssClass="btn" namespace="/report" action="index">
			<s:param name="model.top_dic_name" value="" />
			<s:param name="model.sub_dic_name" value="" />
			<s:param name="model.org_name" value="" />
			<s:param name="model.user_name" value="" />
			<s:param name="input_start_time" value="" />
			<s:param name="input_end_time" value="" />
			<s:text name="btn.reset" />
		</s:a>
		<button type="submit" class="btn">
			<s:text name="btn.search" />
		</button>
		<a class="btn" href="javascript:window.print();">打印</a>
	</form>
</div>
<div id="printObj">
	<div class="row-fluid">
		<table class="table table-striped">
			<tr>
				<th style="width: 8%"><s:text name="top.name" /></th>
				<th style="width: 12%"><s:text name="top.time" /></th>
				<th style="width: 15%"><s:text name="sub.name" /></th>
				<th style="width: 12%"><s:text name="sub.time" /></th>
				<th style="width: 15%"><s:text name="org.name" /></th>
				<th style="width: 8%"><s:text name="user.name" /></th>
				<th style="width: 10%"><s:text name="sub.start" /></th>
				<th style="width: 10%"><s:text name="sub.end" /></th>
				<th style="width: 10%"><s:text name="user.time" /></th>
			</tr>
			<s:iterator value="list" id="list">
				<tr>
					<td><%-- <s:a namespace="/report" action="index">
							<s:property value="top_dic_name" />
							<s:param name="model.top_dic_name" value="top_dic_name" />
						</s:a> --%>
					<s:property value="top_dic_name" /></td>
					<td><s:property value="top_sum_time" /></td>
					<td><%-- <s:a namespace="/report" action="index">
							<s:property value="sub_dic_name" />
							<s:param name="model.sub_dic_name" value="sub_dic_name" />
						</s:a> --%>
						<s:property value="sub_dic_name" /></td>
					<td><s:property value="sub_sum_time" /></td>
					<td><%-- <s:a namespace="/report" action="index">
							<s:property value="org_name" />
							<s:param name="model.org_name" value="org_name" />
						</s:a> --%>
						<s:property value="org_name" /></td>
					<td><%-- <s:a namespace="/report" action="index">
							<s:property value="user_name" />
							<s:param name="model.user_name" value="user_name" />
						</s:a> --%>
						<s:property value="user_name" /></td>
					<td><s:date name="s_time" format="MM/dd/yyyy" /></td>
					<td><s:date name="e_time" format="MM/dd/yyyy" /></td>
					<td><s:property value="take_time" /></td>
				</tr>
			</s:iterator>
		</table>
	</div>
	<div class="row-fluid pagination-centered">
		<s:if test="model.top_dic_name != null && model.top_dic_name != '' ">
			<img style="max-width: 100%;max-height: 100%"
				src="<s:url namespace="/report" action="topReport">
			<s:param name="model.top_dic_name" value="model.top_dic_name"/>
			<s:param name="input_start_time" value="input_start_time"/>
			<s:param name="input_end_time" value="input_end_time"/>
		</s:url>" />
		</s:if>
		<s:if test="model.sub_dic_name != null && model.sub_dic_name != '' ">
			<img style="max-width: 100%;max-height: 100%"
				src="<s:url namespace="/report" action="subReport">
			<s:param name="model.top_dic_name" value="model.top_dic_name"/>
			<s:param name="model.sub_dic_name" value="model.sub_dic_name"/>
			<s:param name="model.org_name" value="model.org_name"/>
			<s:param name="model.user_name" value="model.user_name"/>
			<s:param name="input_start_time" value="input_start_time"/>
			<s:param name="input_end_time" value="input_end_time"/>
		</s:url>" />
		</s:if>
	</div>
</div>
