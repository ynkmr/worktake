<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>工时系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script src="js/jquery-1.8.3.min.js"></script>  
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.bootstrap.min.js"></script>
	<script src="js/jquery.easyui.min.js"></script>
	<script src="js/jquery.edatagrid.js"></script>
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/bootstrap/easyui.css" rel="stylesheet">
	<link href="css/bootstrap/datagrid.css" rel="stylesheet">
	<link href="css/bootstrap/window.css" rel="stylesheet">
	<link href="css/bootstrap/splitbutton.css" rel="stylesheet">

  </head>
  
  <body>
    <div id="p" class="easyui-panel" title="用户登录" style="width:300px;height:250px;padding:10px;">
		<div class="form-group" style="padding:10px;">
        	<form id="fm" action="/WorkTakeService/login.do" method="post">
				<label for="code">用户编号：</label>
				<input class="easyui-validatebox" id="id_code" name="code" type="text">
				<label for="password">项目小类：</label>			
				<input class="easyui-validatebox" id="id_password" name="password" type="password">
				<div class="form-group">
					<!-- <a href="javascript:void(0)" class="btn btn-success" onclick="login();">登录</a> -->
					<input type="submit" class="btn btn-success" value="登录">
				</div>
      	    </form>
      	</div>
    </div>
    <script type="text/javascript">
    	function login(){
    		$('#fm').form("sumbit");
    	}      	
    	
		function login()1{
			var fdata = {
				code: $('#id_code').val(),
				password: $('#id_password').val()
			};
			var jsonText = JSON.stringify(fdata);				
			$.ajax({
				url: '/WorkTakeService/login.do',
				type: 'post',
				async: false,
				data: jsonText,
				dataType: 'JSON',
				contentType:'application/json; charset=utf-8',
				error: function(){alert('登录失败！请稍后重试');},
				success: function(result){

				}
			});
		}
	</script>
  </body>
</html>
