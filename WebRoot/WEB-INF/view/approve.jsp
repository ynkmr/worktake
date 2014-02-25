<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'approve.jsp' starting page</title>
    
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
	<script src="js/datagrid-groupview.js"></script>
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/bootstrap/easyui.css" rel="stylesheet">
	<link href="css/bootstrap/datagrid.css" rel="stylesheet">
	<link href="css/bootstrap/window.css" rel="stylesheet">
	<link href="css/bootstrap/splitbutton.css" rel="stylesheet">

  </head>
  
  <body>
    <!-- <div class="container" style="width:95%;height:450px"> -->
    <div class="easyui-tabs" data-options="tabWidth:100,tabHeight:30" style="width:100%px;height:100%px">
        <div title="审核" style="padding:10px">
	    	<div class="form-group">
				<table class="easyui-datagrid" id="dg"
			            data-options="
			                rownumbers: true,
			                singleSelect: true,
			                iconCls: 'icon-save',
			                url: '/WorkTakeService/approve/all.do',
			                method: 'get',
							idField: 'id',
							pagination:true,
							pagination: true,
							onClickCell: onClickCell,
							view:groupview,
                			groupField:'user_name',
                			groupFormatter:function(value,rows){
			                    return value + ' - ' + rows.length + ' Item(s)';
			                }
			            ">
					<thead>
						<tr>
							<th data-options="field:'log_date',width:200">填报期间</th>
							<th data-options="field:'user_name',width:100,align:'right'">填报人</th>
							<th data-options="field:'dic_name',width:150,align:'right'">项目大类</th>
							<th data-options="field:'all_name',width:150,align:'right'">项目明细</th>
							<th data-options="field:'memo',width:300,align:'right'">备注</th>
							<th data-options="field:'statusv',width:150,align:'center',formatter:formatname,editor:{type:'combobox',options:{data:[{value:'2',text:'批准','selected':'true'},{value:'0',text:'未提交'},{value:'1',text:'已提交'},{value:'3',text:'拒绝'}],panelHeight:'auto'}}">审批</th>
						</tr>
					</thead>
				</table>
			</div>
	    </div>
	    <div title="批量" style="padding:10px">
			<div class="form-group" style="margin:5px">
				<a href="javascript:void(0)" class="btn btn-success" plain="true" onclick="approve();">批准</a>
				<a href="javascript:void(0)" class="btn btn-success" plain="true" onclick="reject();">拒绝</a>
			</div>
	    	<div class="form-group">
				<table class="easyui-datagrid" id="dg1"
			            data-options="
			                rownumbers: true,
			                singleSelect: false,
			                iconCls: 'icon-save',
			                url: '/WorkTakeService/approve/all.do',
			                method: 'get',
							idField: 'id',
							pagination:true,
							pagination: true,
							selectOnCheck: true,
							checkOnSelect: true,
							view:groupview,
                			groupField:'user_name',
                			groupFormatter:function(value,rows){
			                    return value + ' - ' + rows.length + ' Item(s)';
			                }
			            ">
					<thead>
						<tr>
							<th data-options="field:'log_date',width:200">填报期间</th>
							<th data-options="field:'user_name',width:100,align:'right'">填报人</th>
							<th data-options="field:'dic_name',width:150,align:'right'">项目大类</th>
							<th data-options="field:'all_name',width:150,align:'right'">项目明细</th>
							<th data-options="field:'memo',width:300,align:'right'">备注</th>
							<th data-options="field:'statusv',width:120,align:'center',formatter:formatname,editor:{type:'combobox',options:{data:[{value:'2',text:'批准','selected':'true'},{value:'3',text:'拒绝'}],panelHeight:'auto'}}">审批</th>
							<th data-options="field:'ck',checkbox:true"></th>
						</tr>
					</thead>
				</table>
			</div>
	    </div>
    </div>
    <script type="text/javascript">
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
            if ($('#dg').datagrid('validateRow', editIndex)){
                $('#dg').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickCell(index, field){
            if (endEditing()){
                $('#dg').datagrid('selectRow', index)
                        .datagrid('editCell', {index:index,field:field});
                editIndex = index;
            }
        }
        function formatname(val,row){
            if(val == '0')
				return '未提交';
			else if(val == '1')
				return '已提交';
			else if(val == '2')
				return '批准';
			else if(val == '3')
				return '拒绝';
        }
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
		
		function approve(){
			
		}
		 
		function reject(row){
           
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
  </body>
</html>
