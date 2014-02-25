<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>项目/任务</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="项目,任务">
	<meta http-equiv="description" content="workitems">
	
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
			<a href="javascript:void(0)" class="btn btn-success" plain="true" onclick="collapseAll()">全部收起</a>
	        <a href="javascript:void(0)" class="btn btn-success" plain="true" onclick="expandAll()">全部展开</a>
		</div>
    	<div class="form-group">
			<table id="tg" class="easyui-treegrid"
			            data-options="iconCls: 'icon-ok',
			                rownumbers: true,
			                animate: true,
			                collapsible: true,
			                fitColumns: true,
			                url: '/WorkTakeService/workitem/all.do',
			                method: 'get',
			                idField: 'id',
			                treeField: 'name',
			                singleSelect: false,
							onDblClickRow: onDblClickRow">
			        <thead>
			            <tr>
			                <th data-options="field:'name',width:240">名称</th>
			                <th data-options="field:'code',width:60,align:'right'">编号</th>
			                <th data-options="field:'type_id',width:80">类型</th>
			            </tr>
			        </thead>
			</table>
		</div>
    </div>
    <div id="w" class="easyui-window" title="编辑项目" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:350px;height:300px;padding:10px;">
		<form role="form" id="fm" method="post">
			<div class="form-group">
				<label for="name">项目名称：</label>
				<input class="easyui-validatebox" id="id_name" name="name" type="text" data-options="required:true">
				<label for="code">编号：</label>
				<input class="easyui-validatebox" id="id_code" name="code" type="text" data-options="required:true">
				<label for="type_id">类型：</label>
				<input class="easyui-combotree" id="id_type_id" name="type_id" data-options="url:'js/itemtypes.json',method:'get',required:true">
				<input class="easyui-validatebox" id="id_upper_work_id" name="upper_work_id" type="text" style="display:none">
				<input class="easyui-validatebox" id="id_upper_all_ids" name="upper_all_ids" type="text" style="display:none">
				<input class="easyui-validatebox" id="id_id" name="id" type="text" style="display:none">
			</div>
			<div class="form-group" style="margin:10px 0">	
				<a href="javascript:void(0)" class="btn btn-success" onclick="save()">保存</a>
				<a href="javascript:void(0)" class="btn btn-success" onclick="cancel()">取消</a>
			</div>
		</form>
		<script type="text/javascript">
			function collapseAll(){
            	$('#tg').treegrid('collapseAll');
        	}
        	
        	function expandAll(){
            	$('#tg').treegrid('expandAll');
        	}
        
			function add(){
				$('#fm').form('clear');
				$('#w').window('open');
			 }
			 
			 function onDblClickRow(row){
	            $('#fm').form('clear');
	            $('#fm').form('load', '/WorkTakeService/workitem/find.do?id=' + row['id']);
	            $('#w').window('open');
	        }
	        
	        function cancel() {
	        	$('#w').window('close');
	        }
        	
			function save(){
				var fdata = {
					name: $('#id_name').val(),
					code: $('#id_code').val(),
					type_id: $('#id_type_id').combotree('getValue'),
					upper_work_id: $('#id_upper_work_id').val(),
					upper_all_ids: $('#id_upper_all_ids').val(),
					id: $('#id_id').val()
				};
				var jsonText = JSON.stringify(fdata);				
				$.ajax({
					url: '/WorkTakeService/workitem/save.do',
					type: 'post',
					async: false,
					data: jsonText,
					dataType: 'JSON',
					contentType:'application/json; charset=utf-8',
					error: function(){alert('保存失败！请稍后重试');},
					success: function(result){
						$('#w').window('close');
						$('#tg').treegrid('reload', {
							url: '/WorkTakeService/workitem/all.do',
							method: 'get'
						});
					}
				});
			}
		</script>
	<!-- </div> -->
  </body>
</html>
