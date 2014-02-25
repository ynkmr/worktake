<%@page contentType="application/json; charset=utf-8" %>
<%@page import="cn.myapps.core.sso.SSOUtil"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.*" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.*"%>
<%@page import="java.lang.*"%>
<%@page import="cn.myapps.util.*"%>
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
<%
	String options = request.getParameter("options");
	String rownum = request.getParameter("rows");
	String pageidx = request.getParameter("page");
	String log_s_time = request.getParameter("log_s_time");
	//Class.forName("oracle.jdbc.driver.OracleDriver").newInstance(); 
	Class.forName("com.mysql.jdbc.Driver");
	ResultSet rs=null;  
	String oraUrl="jdbc:oracle:thin:@192.168.1.100:1521:gallops";
	String oraUser="project_mgm";  
	String oraPWD="gallops";
	String msqlUrl="jdbc:mysql://localhost:3307/obpm";
	String msqlobpmUrl="jdbc:mysql://localhost:3307/obpm_local";
	String msqlUser="root";
	String msqlPWD="root";
	WebUser user = (WebUser) session.getAttribute("FRONT_USER"); 
	String domainid = user.getDomainid();
	if(options.equals("getprojects")) {
		try  
		{  
			//DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver()); 		
			//Connection conn=DriverManager.getConnection(oraUrl,oraUser,oraPWD);
			Connection conn=DriverManager.getConnection(msqlUrl,msqlUser,msqlPWD);  
		    Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);  
			//rs=stmt.executeQuery("select id, parent, item_parent_id, to_char(item_name) item_name, //item_plan_take, to_char(item_plan_s_time,'yyyy-mm-dd') item_plan_s_time, //to_char(item_plan_e_time,'yyyy-mm-dd') item_plan_e_time, to_char(item_goal) item_goal,  //item_actual_take from tlk_project");
			rs=stmt.executeQuery("select id, parent, item_parent_id, item_name, item_plan_take, DATE_FORMAT(item_plan_s_time,'%Y-%m-%d') item_plan_s_time, DATE_FORMAT(item_plan_e_time,'%Y-%m-%d') item_plan_e_time, item_goal,  item_actual_take from tlk_project");
			ResultSetMetaData metaData = rs.getMetaData();
			String labels[] = new String[metaData.getColumnCount()];
			for (int i = 1; i <= labels.length; i++) {
				labels[i - 1] = metaData.getColumnLabel(i);
			}
			List<Map<String, Object>> ros = new ArrayList<Map<String,Object>>();
			while(rs.next())
			{
				Map<String, Object> row = new HashMap<String, Object>();
				for (String label : labels) {
					if(label.toLowerCase().equals("item_parent_id"))
						row.put("_parentId", rs.getObject(label));
					else
						row.put(label.toLowerCase(), rs.getObject(label));
				}
				ros.add(row);
			}
			rs.close();  
			stmt.close();  
			conn.close();
			Map<String, Object> objs = new HashMap<String, Object>();
			objs.put("rows", ros);
			objs.put("total", ros.size());
			Map<String, Object> footers = new HashMap<String, Object>();
			footers.put("name","所有项目/任务");
			objs.put("footer",footers);
			JSONObject res = JSONObject.fromObject(objs);
			out.println(res.toString());
		} catch (Exception e)  
		{
			out.println(e.toString());  
		}
	} else if(options.equals("gettraces")) {
		try  
		{
			String sql = " select t.id, t.PARENT, t.ITEM_CONTENT, t.ITEM_LOG_OFFICER, t.ITEM_LOG_TAKE, CONCAT(DATE_FORMAT(t.item_log_s_time,'%Y-%m-%d'),'至' ,DATE_FORMAT(t.item_log_e_time,'%Y-%m-%d')) log_date, a.item_name from tlk_trace_log t left outer join tlk_project a on t.parent = a.id  where t.item_log_officer like '%" + user.getId() + "%'   order by log_date desc ";
			if((pageidx != null) && (pageidx.length() > 0)) {
				int idx = Integer.parseInt(pageidx);
				int sizes = 15;
				if((rownum != null) && (rownum.length() > 0))
					sizes = Integer.parseInt(rownum);
				idx = (idx - 1) * sizes + 1;
				sql += " limit " + String.valueOf(idx) + " , " + String.valueOf(sizes);
			}
			Connection conn=DriverManager.getConnection(msqlUrl,msqlUser,msqlPWD);  
		    Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);  
			rs=stmt.executeQuery(sql);
			ResultSetMetaData metaData = rs.getMetaData();
			String labels[] = new String[metaData.getColumnCount()];
			for (int i = 1; i <= labels.length; i++) {
				labels[i - 1] = metaData.getColumnLabel(i);
			}
			List<Map<String, Object>> ros = new ArrayList<Map<String,Object>>();
			while(rs.next())
			{
				Map<String, Object> row = new HashMap<String, Object>();	
				for (String label : labels) {
					if(label.toLowerCase().equals("item_log_officer")) {			
						row.put(label.toLowerCase(), rs.getObject(label));
						if(rs.getObject(label) != null) {
							UserProcessBean userProcess=new UserProcessBean();
							UserVO userVO=(UserVO)userProcess.doView(rs.getObject(label).toString());
							String userName=userVO.getName();
							row.put(label.toLowerCase() + "_name", userName);
						}
					} else
						row.put(label.toLowerCase(), rs.getObject(label));
				}
				ros.add(row);
			}
			rs.close();  
			stmt.close();  
			
			Map<String, Object> objs = new HashMap<String, Object>();
			objs.put("rows", ros);
			objs.put("total", ros.size());
			int total = 0;
			Statement stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			sql = " select count(*) rowcount from tlk_trace_log t left outer join tlk_project a on t.parent = a.id  where t.item_log_officer like '%" + user.getId() + "%' ";
			rs=stmt1.executeQuery(sql);
			while(rs.next())
			{
				objs.put("total", rs.getObject("rowcount"));
			}
			rs.close(); 
			stmt.close();  
			conn.close();
			JSONObject res = JSONObject.fromObject(objs);
			out.println(res.toString());
			
		} catch (Exception e)  
		{
			out.println(e.toString());  
		}
	} else if(options.equals("addlog")) {
		Map<String, Object> row = new HashMap<String, Object>();
		row.put("parent","");
		row.put("parent_name","");
		row.put("id","");
		row.put("item_log_take","2");
		row.put("item_content","");
		List<Map<String, Object>> ros = new ArrayList<Map<String,Object>>();
		ros.add(row);
		JSONArray res = JSONArray.fromObject(row);
		out.println(res.toString());
	} else if(options.equals("editlog")) {
		String id = request.getParameter("id");
		if((id != null) && (id.length() > 0)) {
			String sql = " select DATE_FORMAT(a.item_log_e_time,'%Y-%m-%d') item_log_e_time, DATE_FORMAT(a.item_log_s_time,'%Y-%m-%d') item_log_s_time, t.item_log_take, t.item_content, t.PARENT, t.id, (select item_name from tlk_project where id = t.parent) parent_name from tlk_trace_log t, (SELECT ITEM_LOG_S_TIME, ITEM_LOG_E_TIME FROM `tlk_trace_log` where id = '" + id +"') a where t.ITEM_LOG_S_TIME >= a.ITEM_LOG_S_TIME and t.ITEM_LOG_E_TIME<= a.ITEM_LOG_E_TIME and t.item_log_officer ='" + user.getId() +"'";
			Connection conn=DriverManager.getConnection(msqlUrl,msqlUser,msqlPWD);  
			Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs=stmt.executeQuery(sql);
			ResultSetMetaData metaData = rs.getMetaData();
			String labels[] = new String[metaData.getColumnCount()];
			for (int i = 1; i <= labels.length; i++) {
				labels[i - 1] = metaData.getColumnLabel(i);
			}
			List<Map<String, Object>> ros = new ArrayList<Map<String,Object>>();
			while(rs.next())
			{
				Map<String, Object> row = new HashMap<String, Object>();	
				for (String label : labels) {
					row.put(label.toLowerCase(), rs.getObject(label));
				}
				ros.add(row);
			}
			rs.close();  
			stmt.close();
			conn.close();
			
			JSONArray res = JSONArray.fromObject(ros);
			out.println(res.toString());
		}
	} else if(options.equals("getusers")) {
		String sql = "select b.id , b.`name` text , b.superior from (select id, name, superior from t_department union select id,name,defaultdepartment SUPERIOR from t_user  ) b order by b.name";
		Connection conn=DriverManager.getConnection(msqlobpmUrl,msqlUser,msqlPWD); 	
		Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs=stmt.executeQuery(sql);
		ResultSetMetaData metaData = rs.getMetaData();
		String labels[] = new String[metaData.getColumnCount()];
		for (int i = 1; i <= labels.length; i++) {
			labels[i - 1] = metaData.getColumnLabel(i);
		}
		List<Map<String, Object>> ros = new ArrayList<Map<String,Object>>();
		while(rs.next())
		{
			Map<String, Object> row = new HashMap<String, Object>();	
			for (String label : labels) {
				if(label.toLowerCase().equals("superior"))
					row.put("_parentId", rs.getObject(label));
				else
					row.put(label.toLowerCase(), rs.getObject(label));
			}
			ros.add(row);
		}
		rs.close();  
		stmt.close();
		conn.close();
		
		JSONArray res = JSONArray.fromObject(ros);
		out.println(res.toString());
	}
%>