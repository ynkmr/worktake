<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'dictionary.jsp' starting page</title>
    
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
			                url: '/WorkTakeService/dictionary/alltop.do',
			                method: 'get',
			                idField: 'id',
			                treeField: 'name',
			                singleSelect: false,
							onDblClickRow: onDblClickRow">
			        <thead>
			            <tr>
			                <th data-options="field:'name',width:240">类型名称</th>
			                <th data-options="field:'code',width:60,align:'right'">编号</th>
			                <th data-options="field:'type',width:80,formatter:formatname">分类</th>
			            </tr>
			        </thead>
			</table>
		</div>
    </div>
    <div id="w" class="easyui-window" title="编辑项目" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:350px;height:300px;padding:10px;">
		<form role="form" id="fm" method="post">
			<div class="form-group">
				<label for="name">项目类型名称：</label>
				<input class="easyui-validatebox" id="id_name" name="name" type="text" data-options="required:true">
				<label for="code">编号：</label>
				<input class="easyui-validatebox" id="id_code" name="code" type="text" data-options="required:true">
				<label for="parent_id" style="display:none">父项目类型：</label>
				<div style="display:none"><input class="easyui-combotree" id="id_parent_id" name="parent_id" style="display:none"></div>
				<label for="type_id" style="display:none">分类：</label>
				<div style="display:none"><input class="easyui-combobox" id="id_type" name="type" data-options="data:[{id:'0',text: '大项'},{id: '1',text: '明细项'}],valueField:'id',textField:'text',required:true"></div>
				<input class="easyui-validatebox" id="id_all_ids" name="all_ids" type="text" style="display:none">
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
				$('#id_parent_id').combotree({url: '/WorkTakeService/dictionary/allothers.do?id=0'});
				$('#w').window('open');
			 }
			 
			 function onDblClickRow(row){
	            $('#fm').form('clear');
	            $('#id_parent_id').combotree({url: '/WorkTakeService/dictionary/allothers.do?id=' +row['id']});
	            $('#fm').form('load', '/WorkTakeService/dictionary/find.do?id=' + row['id']);
	            $('#w').window('open');
	        }
	        
	        function cancel() {
	        	$('#w').window('close');
	        }
        	
			function save(){
				var fdata = {
					name: $('#id_name').val(),
					code: $('#id_code').val(),
					type: 0,
					parent_id: $('#id_parent_id').combotree('getValue'),
					all_ids: $('#id_all_ids').val(),
					id: $('#id_id').val()
				};
				var jsonText = JSON.stringify(fdata);				
				$.ajax({
					url: '/WorkTakeService/dictionary/save.do',
					type: 'post',
					async: false,
					data: jsonText,
					dataType: 'JSON',
					contentType:'application/json; charset=utf-8',
					error: function(){alert('保存失败！请稍后重试');},
					success: function(result){
						$('#w').window('close');
						$('#tg').treegrid('reload', {
							url: '/WorkTakeService/dictionary/all.do',
							method: 'get'
						});
					}
				});
			}
			function formatname(val,row){
	            if(val == '0')
					return '大类';
				else
					return '明细类';
		    }
		</script>
	<!-- </div> -->
  </body>
</html>
