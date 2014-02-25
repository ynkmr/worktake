<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'userwork.jsp' starting page</title>
    
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
    <!-- <div class="container">
		<nav class="navbar navbar-default" role="navigation">
		  <div class="nav navbar-nav"> -->
		<div id="p" class="easyui-panel" title="填报工时" >
			<div class="form-group" style="padding:10px;">
	        <form id="fm">
	        	<div class="form-inline">
					<label for="s_time">日期：</label>
					<input class="easyui-datebox" id="id_s_time" name="s_time" data-options="formatter:myformatter,parser:myparser,required:true" style="width:125px">
					<label for="e_time">至：</label>
					<input class="easyui-datebox" id="id_e_time" name="e_time" data-options="formatter:myformatter,parser:myparser,required:true" style="width:125px">
				</div>
					<label for="dic_id">项目大类：</label>
					<input class="easyui-combobox" id="id_dic_id" name="dic_id" data-options="url:'/WorkTakeService/dictionary/toplevel.do',method:'get',valueField:'id',textField:'text',required:true,onSelect: onSelect" style="width:330px">
					<label for="sub_dic_id">项目小类：</label>
					<input class="easyui-combotree" id="id_sub_dic_id" name="sub_dic_idv" multiple data-options="url:'/WorkTakeService/dictionary/allsublevel.do',cascadeCheck:false,onlyLeafCheck:true,required:true" style="width:330px">
					<label for="memo">备注：</label>
					<textarea rows="2" id="id_memo" name="memo"  style="width:330px"></textarea>
					<input class="easyui-validatebox" id="id_user_id" name="user_id" type="text" style="display:none">
					<input class="easyui-validatebox" id="id_status" name="status" type="text" style="display:none">
					<input class="easyui-validatebox" id="id_id" name="id" type="text" style="display:none">
					<div class="form-group">
						<a href="javascript:void(0)" class="btn btn-success" onclick="add();">新建</a>
						<a href="javascript:void(0)" class="btn btn-success" onclick="save();">保存</a>
					</div>
       	    </form>
       	    </div>
	    </div>
		  <!-- </div>
		</nav> -->
		<div class="form-group">
		<table class="easyui-datagrid" id="main" 
		            data-options="
		                rownumbers: true,
		                singleSelect: true,
		                iconCls: 'icon-save',
		                url: '/WorkTakeService/userwork/all.do',
		                method: 'get',
						idField: 'id',
						pagination:true,
						onClickCell: onClickCell,
						pagination: true
		            ">
			<thead>
				<tr>
					<th data-options="field:'log_date',width:200">填报期间</th>
					<th data-options="field:'dic_name',width:250,align:'center'">项目大类</th>
					<th data-options="field:'all_name',width:250,align:'left'">项目明细</th>
					<th data-options="field:'memo',width:300,align:'left'">备注</th>
					<th data-options="field:'statusv',width:80,align:'center', editor:{type:'checkbox',options:{on:'1',off:'0'}},formatter:formatname">操作</th>
				</tr>
			</thead>
		</table>
		</div>
		<script type="text/javascript">	
			$(function(){  
    			var dt = new Date();
				var y = dt.getFullYear();
		        var m = dt.getMonth()+1;
		        var d = dt.getDate();
		        var dd = y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
				$('#id_s_time').datebox('setValue',dd);
				$('#id_e_time').datebox('setValue',dd); 
			});
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
			function add(){
				 $('#fm').form('clear');
				 var dt = new Date();
				 var y = dt.getFullYear();
		         var m = dt.getMonth()+1;
		         var d = dt.getDate();
		         var dd = y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
				 $('#id_s_time').datebox('setValue',dd);
				 $('#id_e_time').datebox('setValue',dd);
			 }
			 
			 ///////////////////////
			 $.extend($.fn.datagrid.methods, {
	            editCell: function(jq,param){
	                return jq.each(function(){
	                    var opts = $(this).datagrid('options');
	                    var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
	                    for(var i=0; i<fields.length; i++){
	                        var col = $(this).datagrid('getColumnOption', fields[i]);
	                        col.editor1 = col.editor;
	                        if (fields[i] != param.field){
	                            col.editor = null;
	                        }
	                    }
	                    $(this).datagrid('beginEdit', param.index);
	                    for(var i=0; i<fields.length; i++){
	                        var col = $(this).datagrid('getColumnOption', fields[i]);
	                        col.editor = col.editor1;
	                    }
	                });
	            }
	        });
	        
	        var editIndex = undefined;
	        function endEditing(){
	            if (editIndex == undefined){return true}
	            if ($('#main').datagrid('validateRow', editIndex)){
	                $('#main').datagrid('endEdit', editIndex);
	                editIndex = undefined;
	                return true;
	            } else {
	                return false;
	            }
	        }
	        function onClickCell(index, field){
	            if (endEditing()){
	                $('#main').datagrid('selectRow', index)
	                        .datagrid('editCell', {index:index,field:field});
	                editIndex = index;
	            } 
	            if(field != "log_date") {
					$('#fm').form('clear');
					var rows = $('#main').datagrid("getRows");
					var drow = rows[index];
				  	$('#fm').form('load', '/WorkTakeService/userwork/find.do?id=' + drow['id']);
					$('#id_sub_dic_id').combotree('setValue', drow.sub_dic_id);
				}
	        }
        /////////////////////////////////
	
			function onSelect(row) {
				$('#id_sub_dic_id').combotree({
					onBeforeSelect: function(node) {
            			if (!$(this).tree('isLeaf', node.target)) {
                			return false;
            			}
            		},
            		onClick: function(node) {
            			if (node.state == undefined) {
                    		alert("this is leaf");
                		}	
            		}
				});
			}
			function formatname(val,row){
		            if(val == '0')
						return '未提交';
					else if(val == '1')
						return '已提交';
		    }
		    function save(){
		    	var subidsa = $('#id_sub_dic_id').combotree('getValues');
		    	var subids = "";
		    	for (i = 0; i < subidsa.length; i++) {
		    		if(subids != "")
		    			subids += ";";
		    		subids += subidsa[i];
		    	}
				var fdata = {
					s_time: $('#id_s_time').datebox('getValue'),
					e_time: $('#id_e_time').datebox('getValue'),
					user_id: $('#id_user_id').val(),
					status: $('#id_status').val(),
					dic_id: $('#id_dic_id').combobox('getValue'),
					sub_dic_id: subids,
					memo: $('#id_memo').val(),
					id: $('#id_id').val()
				};
				var jsonText = JSON.stringify(fdata);				
				$.ajax({
					url: '/WorkTakeService/userwork/save.do',
					type: 'post',
					async: false,
					data: jsonText,
					dataType: 'JSON',
					contentType:'application/json; charset=utf-8',
					error: function(){alert('保存失败！请稍后重试');},
					success: function(result){
						$('#w').window('close');
						$('#main').datagrid('reload', {
							url: '/WorkTakeService/userwork/all.do',
							method: 'get'
						});
					}
				});
			}
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
		</script>
	</div>
  </body>
</html>
