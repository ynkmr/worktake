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
<link href="bootstrap/css/prettify.css" rel="stylesheet">
<title>测试显示页面</title>
</head>
<body>
<%
	try {
        String pageNow = request.getParameter("pageNow"); //当前页
        String pageNow2 = request.getParameter("_jumppage");//跳转页
    String applicationid="11e3-6f7c-cf3e219b-80c3-cf174ab06e1d";
    DocumentProcess process = null;
	
	process = (DocumentProcess) DocumentProcessBean.createMonitoProcess(applicationid);
    
    int page2 = 0;
    if(pageNow !=null)page2= Integer.parseInt(pageNow);

    if(pageNow2 !=null) page2=Integer.parseInt(pageNow2);

    if(page2 <1) page2=1;
    int lines =10;
    
    WebUser user = (WebUser) session.getAttribute("FRONT_USER");   //获取前台登陆用户的session,返回的是一个用户对象, FRONT_USER前台登录用户键名
    String domainid = user.getDomainid();   //获取前台用户session中存储的domainid.
	
	String sql = " select t.*, a.item_name from tlk_trace_log t, tlk_project a  where t.parent = a.id and t.item_log_officer like '%" + user.getId() + "%'   order by t.item_log_s_time ";

	long count = process.countBySQL(sql,domainid); 
    int rowCount = (int)count;

    int maxPage = 0;
    if(rowCount % lines == 0){
            maxPage = rowCount / lines;
    }else{
            maxPage = rowCount / lines+1;
    }

    if(page2 > maxPage){ page2 = maxPage;}

    DataPackage datePackage = null;
    datePackage = process.queryBySQLPage(sql,page2,lines,domainid);
    
    
%>
<!-- 数据表格 -->
<div class="container">
<nav class="navbar navbar-default" role="navigation">
  <div class="nav navbar-nav">
  <form class="navbar-form form-inline" role="search">
         <div class="form-group">
            <label for="in_log_officer" >人员姓名：</label>
			
			<input type="text" name="in_log_officer" class="form-control" placeholder="人员姓名">
			
		</div>
		<div class="form-group">
			<label for="in_s_time">起始日期：</label>

			<input type="text" name="in_s_time" class="form-control" placeholder="填报起始日期">
			<label for="in_e_time">结束日期：</label>
			<input type="text" name="in_e_time" class="form-control" placeholder="填报截止日期">
			<button type="submit" class="btn btn-default">查询</button>
        </div> 
		<div class="form-group">
			<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal"  >新建</button>
			<button type="submit" class="btn btn-primary" onClick="popup()">删除</button>
		</div>
  </form>
  </div>
</nav>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
	<form role="form" class="form-inline" action="srv.jsp" method="post">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">填报工时</h4>
      </div>
      <div class="modal-body">
		<div class="form-group">
			<label for="in_s_time">起始日期：</label>
			<input type="text" name="in_s_time" class="form-control input-small" placeholder="填报起始日期">
			<label for="in_e_time">结束日期：</label>
			<input type="text" name="in_e_time" class="form-control input-small" placeholder="填报截止日期">
		</div>
			<p>
				<a class="btn btn-success" onclick="insert()">增加</a>
			</p>
<script type="text/javascript">
function insert() {
  $('#tablewrap2').datagrid("insertRow", {index: 0, row: {"log_take":""}});
  }
  </script>
  <div id="w" class="easyui-window" title="填报工时" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:750px;height:400px;padding:10px;">
	<form role="form" class="form-inline" action="srv.jsp" method="post">
		<div class="form-group">
			<label for="in_s_time">起始日期：</label>
			<input type="text" name="in_s_time" class="form-control input-small" placeholder="填报起始日期">
			<label for="in_e_time">结束日期：</label>
			<input type="text" name="in_e_time" class="form-control input-small" placeholder="填报截止日期">
		</div>
			<p>
				<a href="javascript:void(0)" class="btn btn-success" onclick="append()">增加</a>
				<a href="javascript:void(0)" class="btn btn-success" onclick="removeit()">删除</a>
				<a href="javascript:void(0)" class="btn btn-success" onclick="accept()">Accept</a>
				<a href="javascript:void(0)" class="btn btn-success" onclick="reject()">Reject</a>
				<a href="javascript:void(0)" class="btn btn-success" onclick="getChanges()">GetChanges</a>
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
					<th data-options="field:'log_take',width:90,editor:{type:'numberbox',options:{
					required:true, missingMessage:'使用工时不能为空!'}}">使用工时</th>
					<th data-options="field:'content',width:400,editor:{type:'validatebox',options:{
					required:true, missingMessage:'工作内容不能为空!'}}">工作内容</th>
					<th data-options="field:'parent',width:200,align:'right',editor:{type:'selEdit'}">所属项目/任务</th>
				</tr>
			</thead>
		</table>
	</form>
</div>			<table id="tablewrap2" class="table table-hover"></table>
<script type="text/javascript">
	  var rows =[{"log_take":"2","content":"Free","parent":""}];
	  var projects=[{"parent":"1","name":"test"}];
      var $editTable = $('#tablewrap2');

      $editTable.datagrid({
        columns:[[
            {title: "使用工时", field: "log_take"}
          , {title: "工作内容", field: "content"}
          , {title: "所属项目/任务", field: "parent"}
        ]]
        , edit: true
        , singleSelect: true
        , selectChange: function(selected, rowIndex, rowData, $row) {
            
          }
      }).datagrid("loadData", {rows: rows});
</script>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="sumbit" class="btn btn-primary">保存</button>
      </div>
	 </form>
    </div>
  </div>
</div>
<script type="text/javascript">
        var editIndex = undefined;
        function endEditing(){
            if (editIndex == undefined){return true}
            if ($('#dg').datagrid('validateRow', editIndex)){
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickRow(index){
            if (editIndex != index){
                if (endEditing()){
                    $('#dg').datagrid('selectRow', index)
                            .datagrid('beginEdit', index);
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
</script>
<script type="text/javascript">
	  var rows =[{"log_take":"2","content":"Free","parent":""}];
	  var projects=[{"parent":"1","name":"test"}];
      var $editTable = $('#dg');

      $editTable.edatagrid({
		url:"srv.jsp?options=getlist",
        columns: [[
			{field:'log_take',
				title:'使用工时',
				sortable:true,
				width:100,
				editor:{type:'numberbox',
				options:{
					required:true, missingMessage:'使用工时不能为空!'
				}
				}
			}
			, {field:'content',
			width:220,
				title:'工作内容',
				editor:{type:'validatebox',options:{
					required:true, missingMessage:'工作内容不能为空!'
				}}
			}
			, {field:'parent',
				title:'所属项目/任务',
				width:200,
				sortable:true,
				formatter:function(value,row){return row.name;},
				editor:{type:'combobox',
					options:{valueField:'id',
						textField:'name',
						data:projects
						
				}}
			}
			]]
        , singleSelect: true
		, onClickRow: onClickRow
		, iconCls: 'icon-edit'
      });
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
<table class="table table-striped table-bordered">
<caption>工时填报</caption>
<thead>
<tr>
<td>填报期间</td><td >使用工时</td><td>责任人</td><td>工作内容</td><td>所属项目/任务</td>
</tr>
</thead>
<tbody>
<%
   Iterator iter = datePackage.datas.iterator();
   while(iter.hasNext()){
        Document doc = (Document)iter.next();
        String userName="";
        if(doc.getItemValueAsString("log_officer")!=null){
                String userid=doc.getItemValueAsString("log_officer");
            if(!(userid.equals(""))){
                    UserProcessBean userProcess=new UserProcessBean();
                UserVO userVO=(UserVO)userProcess.doView(userid);
                userName=userVO.getName();
            }
        }
        String stime = doc.getItemValueAsString("log_s_time")!=null ? doc.getItemValueAsString("log_s_time") : "";
		String etime = doc.getItemValueAsString("log_e_time")!=null ? doc.getItemValueAsString("log_e_time") : "";
%>
<tr>
<td style="padding:10px"><%= stime + "至" + etime %></td>
<td style="padding:10px"><%=doc.getItemValueAsString("log_take")!=null ? doc.getItemValueAsString("log_e_time") : "" %></td>
<td style="padding:10px"><%=userName %></td>
<td style="padding:10px"><%=doc.getItemValueAsString("content")!=null ? doc.getItemValueAsString("content") : "" %></td>
<td style="padding:10px"><%=doc.getItemValueAsString("name")!=null ? doc.getItemValueAsString("name") : "" %></td>
</tr>
<% } %>
</tbody>
</table>

<%}catch (Exception e){out.print("<script type='text/javascript'>alert('" + e.getMessage() +"');</script>");} %>
</div>
</body>
</html>