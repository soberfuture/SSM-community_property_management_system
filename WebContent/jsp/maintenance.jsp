<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>物业设备管理</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
	<style type="text/css">
		.fitem{
			margin-top: 10px;
		}
	</style>
</head>
<body style="margin: 0;padding: 0;">
	<table id="dg" iconCls="icon-repair"></table>
	<div id="toolbar">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">修改</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-deal" plain="true" onclick="deal()">处理</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
	</div>
	<div id="dlg" style="padding: 40px 40px;">
		<form id="fm" method="post">
			<div class="fitem">
				<label>设备名称:</label>
				<input name="equipmentName" class="easyui-validatebox" required="true">
			</div>
			<div style="height: 40px"></div>
			<div class="fitem">
				<label>报修内容:</label>
				<input name="content" class="easyui-validatebox" required="true">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	
	<div id="dlg2" style="padding: 20px 30px;">
		<form id="fm2" method="post">
			<div class="fitem">
				<label>设备名称:</label>
				<input name="equipmentName" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>报修内容:</label>
				<input name="content" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>报修日期:</label>
				<input id="maintenanceD" name="maintenanceD" class="easyui-datebox" required="true">
			</div>
			<div class="fitem">
				<label>完成日期:</label>
				<input id="finishedd" name="finishedd" class="easyui-datebox">
			</div>
			<div class="fitem">
				<label>维修费用:</label>
				<input name="maintenanceFee" class="easyui-validatebox" validType="num">
			</div>
			<div class="fitem">
				<label>维修人员:</label>
				<input name="maintenanceMan" class="easyui-validatebox">
			</div>
			<div class="fitem">
				<label>维修状态:</label>
				<select id="maintenanceStatus" name="maintenanceStatus" style="width:150px;" panelHeight="auto" class="easyui-combobox" required="true">
					<option value="未修">未修</option>
					<option value="已修">已修</option>
				</select>
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg2').dialog('close')">取消</a>
	</div>
	
	<div id="dlg3" style="padding: 20px 30px;">
		<form id="fm3" method="post">
			<div class="fitem">
				<label>维修费用:</label>
				<input name="equipmentId" type="hidden">
				<input name="maintenanceFee" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>维修人员:</label>
				<input name="maintenanceMan" class="easyui-validatebox" required="true">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg3').dialog('close')">取消</a>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	/*easyui datagrid初始化*/
	$('#dg').datagrid({
	    url:'${pageContext.request.contextPath}/maintenance/findByPagination.action',
	    fitColumns:true,
	    pagination:true,
	    striped:true,
	    rownumbers:true,
	    singleSelect:true,
	    title:'设备维修管理',
	    toolbar:'#toolbar',
	    columns:[[
			{field:'equipmentName',title:'设备名称',width:100,align:'center'},
			{field:'content',title:'维修信息',width:100,align:'center'},
			{field:'maintenanceDate',title:'报修日期',width:100,align:'center',formatter:myformatter},
			{field:'finisheddate',title:'完成日期',width:100,align:'center',formatter:myformatter},
			{field:'maintenanceFee',title:'维修费用',width:100,align:'center'},
			{field:'maintenanceMan',title:'维修人',width:100,align:'center'},
			{field:'maintenanceStatus',title:'维修状态',width:100,align:'center'},
	    ]]
	});
	
	/*easyui dialog属性设置*/
	$('#dlg').dialog({
	    width: 400,
	    height: 350,
	    closed: true,
	    cache: false,
	    modal: true,
	    buttons:'#dlg-buttons'
	});
	
	/*easyui dialog属性设置*/
	$('#dlg2').dialog({
	    width: 400,
	    height: 350,
	    closed: true,
	    cache: false,
	    modal: true,
	    buttons:'#dlg-buttons'
	});
	
	/*easyui dialog属性设置*/
	$('#dlg3').dialog({
	    width: 400,
	    height: 350,
	    closed: true,
	    cache: false,
	    modal: true,
	    buttons:'#dlg-buttons'
	});
});

function myformatter(date){
	if(date==null){
		return null;
	}
	var o = new Object(date);//必须先接收到object才能调用.time
	var d = new Date(o.time);
	var y = d.getFullYear();
	var m = d.getMonth()+1;
	var d = d.getDate();
	return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}

var url;
var form;
function add(){
	$('#dlg').dialog('open').dialog('setTitle','新增');
	$('#fm').form('clear');
	url = '${pageContext.request.contextPath}/maintenance/insert.action';
	form = '#fm';
}

function edit(){
	$('#fm2').form('clear');
	var row = $('#dg').datagrid('getSelected');
	if (row){
		$('#dlg2').dialog('open').dialog('setTitle','编辑');
		$('#fm2').form('load',row);
		$('#maintenanceD').datebox('setValue',myformatter(row.maintenanceDate));//easyui-datebox专用赋值方法
		$('#finishedd').datebox('setValue',myformatter(row.finisheddate));
		url = '${pageContext.request.contextPath}/maintenance/update.action?maintenanceId='+row.maintenanceId;
		form = '#fm2';
	}else{
		$.messager.show({
			title: '信息',
			msg: '请选择编辑行'
		});
	}
}

function deal(){
	$('#fm3').form('clear');
	var row = $('#dg').datagrid('getSelected');
	if (row){
		if(row.maintenanceStatus=='未修'){
			$('#dlg3').dialog('open').dialog('setTitle','处理');
			$('#fm3').form('load',row);
			url = '${pageContext.request.contextPath}/maintenance/deal.action?maintenanceId='+row.maintenanceId;
			form = '#fm3';
		}else{
			$.messager.show({
				title: '信息',
				msg: '该维修已处理！'
			});
		}
	}else{
		$.messager.show({
			title: '信息',
			msg: '请选择处理行'
		});
	}
}

function save(){
	$(form).form('submit',{
		url: url,
		onSubmit: function(){
			return $(this).form('validate');
		},
		success: function(result){
			var result = eval('('+result+')');
			if (result.success){
				$('#dlg').dialog('close');		// close the dialog
				$('#dlg2').dialog('close');
				$('#dlg3').dialog('close');
				$('#dg').datagrid('reload');	// reload the user data
				$.messager.show({	// show error message
					title: '成功',
					msg: result.message
				});
			} else {
				$.messager.show({
					title: '错误',
					msg: result.message
				});
			}
		}
	});
}

function remove(){
	var row = $('#dg').datagrid('getSelected');
	if (row){
		$.messager.confirm('删除','您确定要删除这一条记录吗?',function(r){
			if (r){
				$.post('${pageContext.request.contextPath}/maintenance/delete.action',{mid:row.maintenanceId},function(result){
					if (result.success){
						$('#dg').datagrid('reload');	// reload the user data
						$.messager.show({	// show error message
							title: '成功',
							msg: result.message
						});
					} else {
						$.messager.show({	// show error message
							title: '错误',
							msg: result.message
						});
					}
				},'json');
			}
		});
	}
}
</script>
</html>