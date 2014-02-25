<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
<%@page import="cn.myapps.core.user.dao.*" %>
<head>
<script src="bootstrap/js/jquery-1.8.3.min.js"></script>  
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="bootstrap/js/jquery.bootstrap.min.js"></script>
<script src="bootstrap/js/jquery.easyui.min.js"></script>
<script src="bootstrap/js/jquery.edatagrid.js"></script>
<link href="bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="bootstrap/css/bootstrap/easyui.css" rel="stylesheet">
<link href="bootstrap/css/bootstrap/datagrid.css" rel="stylesheet">
<link href="bootstrap/css/bootstrap/window.css" rel="stylesheet">
<link href="bootstrap/css/bootstrap/splitbutton.css" rel="stylesheet">
<title>测试显示页面</title>
</head>
<body>
<div class="container">
<nav class="navbar navbar-default" role="navigation">
  <div class="nav navbar-nav">
  <form class="navbar-form form-inline" method="post" action="srvSumbit.jsp" role="search">
         <!--<div class="form-group">
            <label for="in_log_officer" >人员姓名：</label>
			<input type="text" name="q_log_officer" >
			
		</div>-->
		<div class="form-group">
			<label for="in_s_time">起始日期：</label>
			<input class="easyui-datebox" id="q_in_s_time" name="q_in_s_time" data-options="formatter:myformatter,parser:myparser" style="width:150px">
			<label for="in_e_time">结束日期：</label>
			<input class="easyui-datebox" id="q_in_e_time" name="q_in_e_time" data-options="formatter:myformatter,parser:myparser" style="width:150px">
			<button type="submit" class="btn btn-default">查询</button>
        </div> 
		<div class="form-group">
			<a href="javascript:void(0)" class="btn btn-primary" onclick="addLog();">新建</a>
			<!--<button type="submit" class="btn btn-primary">删除</button>-->
		</div>
  </form>
  </div>
</nav>
<!--<div id="users" class="easyui-window" title="选择用户" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:300px;padding:10px;">
<div style="margin:10px 0;">
        <a href="javascript:void(0)" class="btn btn-success">全部收起</a>
        <a href="javascript:void(0)" class="btn btn-success">全部展开</a>
</div>
<table id="tgusers" class="easyui-treegrid" style="width:480px;height:260px"
            data-options="
                iconCls: 'icon-ok',
                rownumbers: true,
                animate: true,
                collapsible: true,
                fitColumns: true,
                url: 'srv.jsp?options=getusers',
                method: 'get',
                idField: 'id',
                treeField: 'text'
            ">
        <thead>
            <tr>
				<th data-options="field:'text',width:240">部门</th>
                <th data-options="field:'text',width:240">人员名称</th>
            </tr>
        </thead>
</table>
</div>
<script type="text/javascript">
	function onSelect(node) {
		
	}
</script>-->
<div id="w" class="easyui-window" title="填报工时" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:750px;height:400px;padding:10px;">
	<form role="form" class="form-inline" action="srv.jsp" method="post">
		<div class="form-group">
			<label for="in_s_time">起始日期：</label>
			<input class="easyui-datebox" id="id_in_s_time" name="in_s_time" data-options="formatter:myformatter,parser:myparser"  required style="width:150px">
			<label for="in_e_time">结束日期：</label>
			<input class="easyui-datebox" id="id_in_e_time" name="in_e_time" data-options="formatter:myformatter,parser:myparser" required style="width:150px">
		</div>
			<p>
				<a href="javascript:void(0)" class="btn btn-success" onclick="append()">增加</a>
				<a href="javascript:void(0)" class="btn btn-success" onclick="removeit()">删除</a>
				<a href="javascript:void(0)" class="btn btn-success" onclick="save()">保存</a>
			</p>
        <table id="dg" class="easyui-datagrid" style="width:700px;height:260px"
			data-options="
                rownumbers: true,
                animate: true,
                collapsible: true,
                fitColumns: true,
				singleSelect: true,
				onClickRow: onClickRow,
                method: 'get',
                idField: 'id',
				iconCls: 'icon-edit'
            ">
			<thead>
				<tr>
					<th data-options="field:'item_log_take',width:90,editor:{type:'numberbox',options:{
					required:true, missingMessage:'使用工时不能为空!'}}">使用工时</th>
					<th data-options="field:'item_content',width:400,editor:{type:'validatebox',options:{
					required:true, missingMessage:'工作内容不能为空!'}}">工作内容</th>
					<th data-options="field:'parent_name',width:200,align:'right',editor:{type:'selEdit'},formatter:formatname">所属项目/任务</th>
				</tr>
			</thead>
		</table>
	</form>
</div>
<script type="text/javascript">
        function myformatter(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            var d = date.getDate();
            return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
        }
        function myparser(s){
            if (!s) return new Date();
            var ss = (s.split('-'));
            var y = parseInt(ss[0],10);
            var m = parseInt(ss[1],10);
            var d = parseInt(ss[2],10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
                return new Date(y,m-1,d);
            } else {
                return new Date();
            }
        }
		function formatname(val,row){
            if(val)
				return val;
			else
				return '无';
        }
</script>
<div id="protask" class="easyui-window" title="项目/任务" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:770px;height:400px;padding:10px;">
<div style="margin:10px 0;">
        <a href="javascript:void(0)" class="btn btn-success" onclick="collapseAll()">全部收起</a>
        <a href="javascript:void(0)" class="btn btn-success" onclick="expandAll()">全部展开</a>
</div>
<table id="tg" class="easyui-treegrid" style="width:730px;height:250px"
            data-options="
                iconCls: 'icon-ok',
                rownumbers: true,
                animate: true,
                collapsible: true,
                fitColumns: true,
                url: 'srv.jsp?options=getprojects',
                method: 'get',
                idField: 'id',
                treeField: 'item_name',
				onDblClickRow: onDblClickRow
            ">
        <thead>
            <tr>
                <th data-options="field:'item_name',width:240">项目/任务名称</th>
                <th data-options="field:'item_plan_take',width:60,align:'right'">计划工时</th>
                <th data-options="field:'item_plan_s_time',width:80">起始日期</th>
                <th data-options="field:'item_plan_e_time',width:80">结整日期</th>
                <th data-options="field:'item_actual_take',width:60,align:'right'">实际工时</th>
            </tr>
        </thead>
</table>
<div  style="margin:10px 0;">
	<a href="javascript:void(0)" class="btn btn-success" onclick="cancelBind()">取消关联所属项目/任务</a>
</div>
</div>
<script type="text/javascript">
        function formatProgress(value){
            if (value){
                var s = '<div style="width:100%;border:1px solid #ccc">' +
                        '<div style="width:' + value + '%;background:#cc0000;color:#fff">' + value + '%' + '</div>'
                        '</div>';
                return s;
            } else {
                return '';
            }
        }
		function cancelBind(){
			accept();
			var backrow = $('#dg').datagrid('getSelected');
			var index = $('#dg').datagrid('getRowIndex', backrow);
			$('#dg').datagrid('updateRow',{
				index: index,
				row: {
					parent: "",
					parent_name: ""
				}
			});
			$('#protask').window('close');
		}
        function collapseAll(){
            $('#tg').treegrid('collapseAll');
        }
        function expandAll(){
            $('#tg').treegrid('expandAll');
        }
		function onDblClickRow(row){
			var id = row["id"];
			var itemname = row["item_name"];
			var backrow = $('#dg').datagrid('getSelected');
			var index = $('#dg').datagrid('getRowIndex', backrow);
			accept();
			$('#dg').datagrid('updateRow',{
				index: index,
				row: {
					parent: id,
					parent_name: itemname
				}
			});
			$('#protask').window('close');
		}
</script>
<script type="text/javascript">
$.extend($.fn.datagrid.defaults.editors, {
	selEdit : {
    init: function(container, options)
    {
		var editorContainer = $('<div/>');

		var button = $("<a href='javascript:void(0)' class='easyui-linkbutton'></a>")
             .appendTo(container);
		return button;
    },
	destroy: function(target){
        $(target).remove();
    },
    getValue: function(target)
    {
        return $(target).text();
    },
    setValue: function(target, value)
    {
        $(target).text(value);
    },
    resize: function(target, width)
    {
        var span = $(target);
        if ($.boxModel == true){
            span.width(width - (span.outerWidth() - span.width()) - 10);
        } else {
            span.width(width - 10);
        }
    }
    }
});
</script>
<script type="text/javascript">
        var editIndex = undefined;
		var deletedrows = [];
        function endEditing(){
            if (editIndex == undefined){return true}
            if ($('#dg').datagrid('validateRow', editIndex)){
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickRow(index, rowdata){
            if (editIndex != index){
                if (endEditing()){
                    $('#dg').datagrid('selectRow', index)
                            .datagrid('beginEdit', index);
					var editors = $('#dg').datagrid('getEditors', index);

					var selEditor = editors[2];
					var selReportButton = selEditor.target;
					
					selReportButton.linkbutton({text:rowdata["parent_name"]});
					selReportButton.bind("click",function()
					{
						$('#protask').window('open');
					});
                    editIndex = index;
                } else {
                    $('#dg').datagrid('selectRow', editIndex);
                }
            }
        }
		function insert() {
			$('#dg').datagrid("insertRow", {index: 0, row: {"log_take":""}});
		}
        function append(){
            if (endEditing()){
                $('#dg').datagrid('appendRow',{log_take:'8'});
                editIndex = $('#dg').datagrid('getRows').length-1;
                $('#dg').datagrid('selectRow', editIndex)
                        .datagrid('beginEdit', editIndex);
            }
        }
        function removeit(){
            if (editIndex == undefined){return}
            
			var rows = $('#dg').datagrid("getRows");
			var drow = rows[editIndex];
			deletedrows.push(drow);
			$('#dg').datagrid('cancelEdit', editIndex)
                    .datagrid('deleteRow', editIndex);
            editIndex = undefined;
        }
        function accept(){
            if (endEditing()){
                $('#dg').datagrid('acceptChanges');
            }
        }
        function reject(){
            $('#dg').datagrid('rejectChanges');
            editIndex = undefined;
        }
        function getChanges(){
            var rows = $('#dg').datagrid('getChanges');
            alert(rows.length+' rows are changed!');
        }
		function save(){
			accept();
			var datarows = $('#dg').datagrid('getRows');
			var sumdata = {
				log_s_time: $('#id_in_s_time').datebox('getValue'),
				log_e_time: $('#id_in_e_time').datebox('getValue'),
				rows: datarows,
				delrows: deletedrows,
				options: 'savelog'
			};
			var jsonText = JSON.stringify(sumdata);
			var jsonData = {
				info: jsonText
			}
			$.ajax({
				url: 'srvSumbit.jsp',
				type: 'post',
				async: false,
				data: jsonData,
				dataType: 'JSON',
				error: function(){alert('保存失败！请稍后重试');},
				success: function(result){
					$('#w').window('close');
					$('#main').datagrid('reload', {
						url: 'srv.jsp?options=gettraces',
						method: 'get'
					});
				}
			});
		}
</script>
<script type="text/javascript">
     function addLog(){
		 var $editTable = $('#dg');
		 var dt = new Date();
		 var y = dt.getFullYear();
         var m = dt.getMonth()+1;
         var d = dt.getDate();
         var dd = y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
		 $('#id_in_s_time').datebox('setValue',dd);
		 $('#id_in_e_time').datebox('setValue',dd);
		 $editTable.edatagrid({
			url:"srv.jsp?options=addlog"
		  });
		  $('#w').window('open');
	 }
	 
	 function editLog(rowIndex){
		 
		 var $mainTable = $('#main');
		 var $editTable = $('#dg');
		 var rows = $mainTable.datagrid("getRows");
		  $editTable.edatagrid({
			url:"srv.jsp?options=editlog&id=" + rows[rowIndex]["id"],
			onLoadSuccess: onLogLoadSuccess
		  });
	 }
	 function onLogLoadSuccess(data){
		if((data.rows != null) && (data.rows.length > 0)) {
			$('#id_in_s_time').datebox('setValue',data.rows[0]["item_log_s_time"]);
			$('#id_in_e_time').datebox('setValue',data.rows[0]["item_log_e_time"]);
			$('#w').window('open');
		}
	 }
</script>

<div class="hide">
<div id="loginwrap">
      <form id="loginform" role="form">
        <div class="form-group">
          <label for="username">Username</label>
          <input type="username" class="form-control"
           id="username">
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" class="form-control"
          id="password">
        </div>
      </form>
    </div>
</div>
<div class="form-group">
<table class="easyui-datagrid" id="main" title="工时填报" style="width:820px;height:460px"
            data-options="
                rownumbers: true,
                singleSelect: true,
                iconCls: 'icon-save',
                url: 'srv.jsp?options=gettraces',
                method: 'get',
				idField: 'id',
				pagination:true,
                onLoadSuccess: onLoadSuccess,
				onClickCell: onClickCell,
				pagination: true
            ">
	<thead>
		<tr>
			<th data-options="field:'log_date',width:160">填报期间</th>
			<th data-options="field:'item_log_take',width:60">使用工时</th>
			<th data-options="field:'item_log_officer_name',width:80,align:'right'">责任人</th>
			<th data-options="field:'item_content',width:300">工作内容</th>
			<th data-options="field:'item_name',width:167,align:'right',formatter:formatname">所属项目/任务</th>
		</tr>
	</thead>
</table>
</div>
<script type="text/javascript">
	function onLoadSuccess(data){
		var rowspan = 1;
		var precontent = "";
		var content = "";
		var index = 0;
		for(var i=0; i<data.rows.length; i++){
			content = data.rows[i]["log_date"];
			
			if(precontent == content)
				rowspan++;
			else {
				$(this).datagrid('mergeCells',{
					index: index,
					field: 'log_date',
					rowspan: rowspan
				});
				rowspan=1;
				index = i;
			}
			precontent = content;
		}
		if(rowspan > 1) {
			$(this).datagrid('mergeCells',{
					index: index,
					field: 'log_date',
					rowspan: rowspan
				});
		}
	}
	function onClickCell(rowIndex, field, value){
		if(field == "log_date") {
			editLog(rowIndex);
		}
	}
	function formatname(val,row){
            if(val)
				return val;
			else
				return '无';
    }
</script>
</div>
</body>
</html>