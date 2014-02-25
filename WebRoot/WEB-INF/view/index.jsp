<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>工时管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="工时,项目">
	<meta http-equiv="description" content="工时管理">
	
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
    <!-- <div style="margin:10px 0;"></div>
    <div class="easyui-tabs" data-options="tabWidth:100,tabHeight:40" style="width:800px;height:450px">
        <div title="项目" style="padding:10px">
            <iframe frameborder="0" src="/WorkTakeService/workitem/view.do" style="width:100%;height:100%"></iframe>
        </div>
        <div title="用户" data-options="iconCls:'icon-help'" style="padding:10px">
            <iframe frameborder="0" src="/WorkTakeService/user/view.do" style="width:100%;height:100%"></iframe>
        </div>
        <div title="工时" style="padding:10px">
            <iframe frameborder="0" src="/WorkTakeService/result/view.do" style="width:100%;height:100%"></iframe>
        </div>
    </div> -->
    
    <div style="margin:5px 0;"></div>
    <div class="easyui-layout" style="width:95%;height:95%;margin:0px 10px;">
        <div data-options="region:'north'" style="height:75px;padding:10px">
        	<div class="form-group">
        		<p style="font-size:14px">云南腾俊驱动力商业有限公司-工时管理系统</p>
        		<div class="form-inline">
        			<label>${loginUser.name}</label>
        			<a href="/WorkTakeService/loginout.do">注销</a>
        		</div>
        	</div>
        </div>
        <!-- <div data-options="region:'south',split:true" style="height:50px;"></div>
        <div data-options="region:'east',split:true" title="East" style="width:180px;"></div> -->
        <div data-options="region:'west',split:true" title="工时管理" style="width:150px;">
        	<ul class="easyui-tree" id="tt" data-options="url:'get.json',method:'get',animate:true,lines:true,onClick:onClick"></ul>
        	<!-- <ul>
                <li><a href="javascript:void(0)" onclick="redirect('/WorkTakeService/dictionary/view.do');">项目类型</a></li>
                <li><a href="javascript:void(0)" onclick="redirect('/WorkTakeService/user/view.do');">用户管理</a></li>
                <li><a href="javascript:void(0)" onclick="redirect('/WorkTakeService/userwork/view.do');">填报工时</a></li>       
                <li><a href="javascript:void(0)" onclick="redirect('/WorkTakeService/approve/view.do');">工时记录审批</a></li>
            </ul> -->
        </div>
        <div data-options="region:'center',title:'',iconCls:'icon-ok'" style="margin:5px">
           	<iframe frameborder="0" id="frame" style="width:99%;height:100%"></iframe>
        </div>
    </div>
    <script type="text/javascript">
    	function onClick(node){
    		if(node.action)
				frame.location.href = node.action;
		}
		
    	function redirect(url) {
    		frame.location.href = url;
    	}
    </script>
  </body>
</html>
