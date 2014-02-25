<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'users.jsp' starting page</title>
    
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
    <!-- <div class="container" style="width:95%;height:450px"> -->
    	
		<div class="form-group" style="margin:5px">
			<a href="javascript:void(0)" class="btn btn-success" plain="true" onclick="add();">新建</a>
			<a href="javascript:void(0)" class="btn btn-success" plain="true" onclick="del();">删除</a>
		</div>
    	<div class="form-group">
			<table id="tg" class="easyui-datagrid"
			            data-options="iconCls: 'icon-ok',
			                rownumbers: true,
			                animate: true,
			                collapsible: true,
			                fitColumns: true,
			                url: '/WorkTakeService/user/allview.do',
			                method: 'get',
			                idField: 'id',
			                treeField: 'name',
			                singleSelect: true,
							onDblClickRow: onDblClickRow">
			        <thead>
			            <tr>
			                <th data-options="field:'name',width:240">姓名</th>
			                <th data-options="field:'code',width:60,align:'right'">编号</th>
			                <th data-options="field:'password',width:80">登录密码</th>
			                <th data-options="field:'first_approve_name',width:80">一级审核人</th>
			                <th data-options="field:'second_approve_name',width:80">二级审核人</th>
			                <th data-options="field:'third_approve_name',width:80">三级审核人</th>
			                <th data-options="field:'mobie_phone',width:80">手机</th>
			                <th data-options="field:'email',width:80">电子邮箱</th>
			                <th data-options="field:'memo',width:80">备注</th>
			            </tr>
			        </thead>
			</table>
		</div>
    </div>
    <div id="w" class="easyui-window" title="编辑项目" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:320px;height:550px;padding:10px;">
		<form role="form" id="fm">
			<div class="form-group">
				<label for="name">姓名：</label>
				<input class="easyui-validatebox" id="id_name" name="name" type="text" data-options="required:true">
				<label for="code">编号：</label>
				<input class="easyui-validatebox" id="id_code" name="code" type="text" data-options="required:true">
				<label for="password">登录密码：</label>
				<input class="easyui-validatebox" id="id_password" name="password" type="password" data-options="required:true">
				<label for="mobie_phone">手机：</label>
				<input class="easyui-validatebox" id="id_mobie_phone" name="mobie_phone" type="text">
				<label for="email">电子邮箱：</label>
				<input class="easyui-validatebox" id="id_email" name="email" type="text">
				<label for="memo">备注：</label>
				<input class="easyui-validatebox" id="id_memo" name="memo" type="text">
				<input class="easyui-validatebox" id="id_id" name="id" type="text" style="display:none">
			</div>
			<div class="form-group">	
				<label for="first_approve_id">一级审批人：</label>
				<select class="easyui-combogrid" id="id_first_approve_id" name="first_approve_id" data-options="
			            panelWidth: 250,
			            idField: 'id',
			            textField: 'name',
			            method: 'get',
			            columns: [[
			                {field:'name',title:'姓名',width:120},
			                {field:'code',title:'编号',width:130}
			            ]],
			            fitColumns: true
			        ">
			    </select>
			</div>
			<div class="form-group">
				<label for="second_approve_id">二级审批人：</label>
				<select class="easyui-combogrid" id="id_second_approve_id" name="second_approve_id" data-options="
			            panelWidth: 250,
			            idField: 'id',
			            textField: 'name',
			            method: 'get',
			            columns: [[
			                {field:'name',title:'姓名',width:120},
			                {field:'code',title:'编号',width:130}
			            ]],
			            fitColumns: true
			        ">
			    </select>
			</div>
			<div class="form-group">
				<label for="third_approve_id">三级审批人：</label>
				<select class="easyui-combogrid" id="id_third_approve_id" name="third_approve_id" data-options="
			            panelWidth: 250,
			            idField: 'id',
			            textField: 'name',
			            method: 'get',
			            columns: [[
			                {field:'name',title:'姓名',width:120},
			                {field:'code',title:'编号',width:130}
			            ]],
			            fitColumns: true
			        ">
			    </select>
			</div>
			<div class="form-group" style="margin:10px 0">	
				<a href="javascript:void(0)" class="btn btn-success" onclick="save()">保存</a>
				<a href="javascript:void(0)" class="btn btn-success" onclick="cancel()">取消</a>
			</div>
		</form>
		<script type="text/javascript">
        
			function add(){
				$('#fm').form('clear');
				$('#id_first_approve_id').combogrid({
    				url: '/WorkTakeService/user/allothers.do?id=0'});
    			$('#id_second_approve_id').combogrid({
    				url: '/WorkTakeService/user/allothers.do?id=0'});	
    			$('#id_third_approve_id').combogrid({
    				url: '/WorkTakeService/user/allothers.do?id=0'});
				$('#w').window('open');
			 }
			 
			 function onDblClickRow(index){
	            $('#fm').form('clear');
	            var row = $('#tg').datagrid('getRows')[index];
	            var id = row['id'];

	            $('#id_first_approve_id').combogrid({
    				url: '/WorkTakeService/user/allothers.do?id=' + id});
    			$('#id_second_approve_id').combogrid({
    				url: '/WorkTakeService/user/allothers.do?id=' + id});	
    			$('#id_third_approve_id').combogrid({
    				url: '/WorkTakeService/user/allothers.do?id=' + id});
    				
	            $('#fm').form('load', row);
	            $('#w').window('open');
	        }
	        
	        function cancel() {
	        	$('#w').window('close');
	        }
        	
			function save(){
				var fdata = {
					name: $('#id_name').val(),
					code: $('#id_code').val(),
					first_approve_id: $('#id_first_approve_id').combogrid('getValue'),
					second_approve_id: $('#id_second_approve_id').combogrid('getValue'),
					third_approve_id: $('#id_third_approve_id').combogrid('getValue'),
					memo: $('#id_memo').val(),
					email: $('#id_email').val(),
					memo: $('#id_memo').val(),
					mobie_phone: $('#mobie_phone').val(),
					password: $('#id_password').val(),
					user_id: $('#id_id').val(),
					id: $('#id_id').val()
				};
				var jsonText = JSON.stringify(fdata);				
				$.ajax({
					url: '/WorkTakeService/user/save.do',
					type: 'post',
					async: false,
					data: jsonText,
					dataType: 'JSON',
					contentType:'application/json; charset=utf-8',
					error: function(){alert('保存失败！请稍后重试');},
					success: function(result){
						$('#w').window('close');
						$('#tg').datagrid('reload', {
							url: '/WorkTakeService/user/allview.do',
							method: 'get'
						});
					}
				});
			}
		</script>
	<!-- </div> -->
  </body>
</html>
