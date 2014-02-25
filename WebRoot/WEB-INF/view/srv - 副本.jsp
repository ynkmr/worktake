<%@page contentType="text/html; charset=utf-8" %>
<%@page import="cn.myapps.core.sso.SSOUtil"%>
<%@page import="cn.myapps.core.dynaform.document.ejb.*" %>
<%@page import="java.util.*"%>
<%@page import="cn.myapps.util.*"%>
<%@page import="cn.myapps.base.dao.*" %>
<%@page import="cn.myapps.util.iProcessFactory"%>
<%@page import="cn.myapps.core.user.action.WebUser"%>  
<%@page import="cn.myapps.constans.Web"%>
<%@page import="cn.myapps.core.user.ejb.*" %>
<%@page import="cn.myapps.core.user.dao.*" %>;
<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%
	request.setCharacterEncoding("utf-8");
	Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();  
	ResultSet rs=null;  
	String oraUrl="jdbc:oracle:thin:@192.168.1.100:1521:gallops";
	String oraUser="project_mgm";  
	String oraPWD="gallops";
	JSONArray res = null;
	try  
	{  
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());   
		Connection conn=DriverManager.getConnection(oraUrl,oraUser,oraPWD);  
		Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);  
		rs=stmt.executeQuery("select * from tlk_project");
		
		while(rs.next())  
		{ 
			if(res != null) {
				res.add(rs);
			} else {
				res = JSONArray.fromObject(rs);
			}  
		}  
		rs.close();  
		stmt.close();  
		conn.close();  
	} catch (SQLException e)  
	{
		out.println(e.toString());  
	}

	String options = request.getParameter("options");
	String in_s_time = request.getParameter("in_s_time");
	if(options.equals("getlist")) {
		out.println("{\"total\":28, \"rows\":[{\"log_take\":\"2\",\"content\":\"Free\",\"parent\":\"test11111\"}, {\"log_take\":\"8\",\"content\":\"Free1\",\"parent\":\"\"}]}");
	} else {
		if (res != null)
			out.println(res.toString());
		else
			out.println("return null");
	}
%>


Accept:application/json, text/javascript, */*; q=0.01
Accept-Encoding:gzip,deflate,sdch
Accept-Language:zh-CN,zh;q=0.8
Connection:keep-alive
Content-Length:203
Content-Type:application/json; charset=UTF-8
Cookie:JSESSIONID=E7E627641DC1C251E86E39A9D582E5E1; AJS.conglomerate.cookie=""; __utma=1.1729509553.1387984472.1388034950.1388715589.6; __utmz=1.1387984472.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); obpmLoginAccount="QTM="; obpmDomainName="suLK1Nfp1q8="; obpmUserEmail=""; domainName=%E6%B5%8B%E8%AF%95%E7%BB%84%E7%BB%87; account=A3; password=123456; keepinfo=yes
Host:localhost:8080
Origin:http://localhost:8080
Referer:http://localhost:8080/obpm/portal/my/fill_take.jsp?application=11e3-6f7c-cf3e219b-80c3-cf174ab06e1d
User-Agent:Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.76 Safari/537.36
X-Requested-With:XMLHttpRequest