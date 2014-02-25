<%@page contentType="application/json; charset=utf-8" %>
<%@page import="cn.myapps.core.sso.SSOUtil"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.*" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.StringBuilder"%>
<%@page import="cn.myapps.util.*"%>
<%@page import="cn.myapps.util.sequence.Sequence"%>
<%@page import="cn.myapps.base.dao.*" %>
<%@page import="cn.myapps.util.iProcessFactory"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>  
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.ejb.*" %>
<%@page import="cn.myapps.core.user.dao.*" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%@page import="net.sf.ezmorph.Morpher" %>
<%@page import="net.sf.ezmorph.MorpherRegistry" %>
<%@page import="net.sf.ezmorph.bean.BeanMorpher" %>
<%@page import="java.net.URLDecoder" %>
<%
	request.setCharacterEncoding("utf-8");
	try {
		String infoStr= request.getParameter("info");
		String jsonStr= URLDecoder.decode(infoStr,"utf-8"); 
		JSONObject jsonObj = JSONObject.fromObject(jsonStr);
		String log_s_time = jsonObj.getString("log_s_time");
		String log_e_time = jsonObj.getString("log_e_time");
		JSONArray rows = jsonObj.getJSONArray("rows");
		JSONArray delrows = jsonObj.getJSONArray("delrows");
		StringBuilder sqls = new StringBuilder();
		Iterator<JSONObject> iter = rows.iterator();
		String sql = "";
		String sets = "";
		String value = "";
		String applicationid="11e3-6f7c-cf3e219b-80c3-cf174ab06e1d";
		String formid="11e3-75ad-c2900ffd-a897-bb870f88a2a3";
		WebUser user = (WebUser) session.getAttribute("FRONT_USER");
		String uid = user.getId();
		String depts = user.getDeptlist();
		String domainid = user.getDomainid();
		//Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
		Class.forName("com.mysql.jdbc.Driver"); 
		String oraUrl="jdbc:oracle:thin:@192.168.1.100:1521:gallops";
		String oraUser="project_mgm";
		String oraPWD="gallops";
		String msqlUrl="jdbc:mysql://localhost:3307/obpm";
		String msqlUser="root";
		String msqlPWD="root";
		Connection conn=DriverManager.getConnection(msqlUrl,msqlUser,msqlPWD);  
		Statement stmt=conn.createStatement();
		conn.setAutoCommit(false);
		while(iter.hasNext()) {
			JSONObject obj = iter.next();
			sets = "";
			value = "";
			sql = "";
			if(obj.has("id") && (obj.getString("id").length() > 0) ) {
				if(obj.has("item_log_take") && (obj.getString("item_log_take").length() > 0)) {
					value = "item_log_take=" + "'" + obj.getString("item_log_take") + "'";
					if(sets.length() > 0)
						sets += ",";
					sets += value;
				}
				if(obj.has("parent")) {
					value = "parent=";
					if(obj.getString("parent").length() > 0)
						value += "'" + obj.getString("parent") + "'";
					else
						value += "null";
					if(sets.length() > 0)
						sets += ",";
					sets += value;
				}
				if(obj.has("item_content") && (obj.getString("item_content").length() > 0)) {
					value = "item_content=" + "'" + obj.getString("item_content") + "'";
					if(sets.length() > 0)
						sets += ",";
					sets += value;
				}
				
				value = "item_log_s_time=" + "str_to_date('" + log_s_time + "', '%Y-%m-%d')";
				if(sets.length() > 0)
					sets += ",";
				sets += value;
				
				value = "item_log_e_time=" + "str_to_date('" + log_e_time + "', '%Y-%m-%d')";
				if(sets.length() > 0)
					sets += ",";
				sets += value;
				
				value = "versions= versions + 1";
				if(sets.length() > 0)
					sets += ",";
				sets += value;
				
				if(sets.length() > 0) {
					sql = " update tlk_trace_log set " + sets + " where id = '" + obj.getString("id") + "'";
				}
			} else {
				if(obj.has("item_log_take") && (obj.getString("item_log_take").length() > 0)) {
					sets += "item_log_take,";
					value += "'" + obj.getString("item_log_take") + "',";
				}
				if(obj.has("parent") && (obj.getString("parent").length() > 0)) {
					sets += "parent,";
					value += "'" + obj.getString("parent") + "',";
				}
				if(obj.has("item_content") && (obj.getString("item_content").length() > 0)) {
					sets += "item_content,";
					value += "'" + obj.getString("item_content") + "',";
				}
				sets += "item_log_s_time,";
				value += "'" + log_s_time + "',";
				sets += "item_log_e_time,";
				value += "'" + log_e_time + "',";
				sets += "item_log_officer,";
				value += "'" + uid + "',";
				sets += "author,";
				value += "'" + uid + "',";
				sets += "author_dept_index,";
				value += depts + ",";
				sets += "formid,";
				value += "'" + formid + "',";
				sets += "applicationid,";
				value += "'" + applicationid + "',";
				sets += "domainid,";
				value += "'" + domainid + "',";
				sets += "versions,";
				value += "1,";
				if(sets.length() > 0) {
					sets += "id";
					value += "'" + Sequence.getSequence() + "'";
					sql = " insert into tlk_trace_log ( " + sets + " ) value ( " + value + ")";
				}
			}
			stmt.addBatch(sql);
			sqls.append(sql + ";");
		}
		Iterator<JSONObject> iter1 = delrows.iterator();
		while(iter1.hasNext()){
			JSONObject obj = iter1.next();
			sql = "";
			if(obj.has("id") && (obj.getString("id").length() > 0) ) {
				sql = " DELETE FROM tlk_trace_log where id ='" + obj.getString("id") +"'";
			}
			stmt.addBatch(sql);
			sqls.append(sql + ";");
		}
		stmt.executeBatch();
		conn.commit();
		stmt.close();  
		conn.close();
		out.println(1);
	} catch(Exception e) {
		out.println(e.getMessage());
	}
	
%>

