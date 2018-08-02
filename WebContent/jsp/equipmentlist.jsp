<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>物业设备管理</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
</head>
<body style="margin: 0;padding: 0;">
	<table id="dg" iconCls="icon-equipment"></table>
	<div id="toolbar">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">修改</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="repair()">报修</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
	</div>
	<div id="dlg" style="padding: 10px 30px;">
		<form id="fm" method="post">
			<div class="fitem">
				<label>设备名称:</label>
				<input name="equipmentName" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>设备品牌:</label>
				<input name="brand" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>设备型号:</label>
				<input name="version" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>所属部门:</label>
				<input name="department" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>购入日期:</label>
				<input id="costd" name="costd" class="easyui-datebox" required="true">
			</div>
			<div class="fitem">
				<label>购入成本:</label>
				<input id="cost" name="cost" class="easyui-validatebox" required="true" validType="num">
			</div>
			<div class="fitem">
				<label>启用日期:</label>
				<input id="startd" name="startd" class="easyui-datebox" required="true">
			</div>
			<div class="fitem">
				<label>设备状态:</label>
				<select name="status" class="easyui-combobox" required="true" style="width: 150px;" panelHeight="auto">
					<option value="正常">正常</option>
					<option value="维修">维修</option>
				</select>
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	
	<div id="dlg2" style="padding: 30px 30px;">
		<form id="fm2" method="post">	
			<input name="equipmentId" type="hidden">
			<div class="fitem">
				<label>设备名称:</label>
				<input name="equipmentName" class="easyui-validatebox" required="true">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>报修描述:</label>
				<input name="content" class="easyui-validatebox" required="true">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg2').dialog('close')">取消</a>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	/*easyui datagrid初始化*/
	$('#dg').datagrid({
	    url:'${pageContext.request.contextPath}/equipment/findByPagination.action',
	    fitColumns:true,
	    striped:true,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    title:'物业设备管理',
	    toolbar:'#toolbar',
	    columns:[[
			{field:'equipmentName',title:'设备名称',width:100,align:'center'},
			{field:'brand',title:'设备品牌',width:100,align:'center'},
			{field:'version',title:'型号',width:100,align:'center'},
			{field:'department',title:'部门',width:100,align:'center'},
			{field:'costdate',title:'购入日期',width:100,align:'center',formatter:myformatter},
			{field:'cost',title:'购入成本',width:100,align:'center'},
			{field:'startdate',title:'启用日期',width:100,align:'center',formatter:myformatter},
			{field:'status',title:'状态',width:100,align:'center'},
	    ]]
	});
	
	/*easyui dialog属性设置*/
	$('#dlg').dialog({
	    width: 400,
	    height: 370,
	    closed: true,
	    cache: false,
	    modal: true,
	    buttons:'#dlg-buttons'
	});
	
	$('#dlg2').dialog({
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
	url = '${pageContext.request.contextPath}/equipment/insert.action';
	form='#fm';
}

function edit(){
	$('#fm').form('clear');
	var row = $('#dg').datagrid('getSelected');
	if (row){
		$('#dlg').dialog('open').dialog('setTitle','编辑');
		$('#fm').form('load',row);
		$('#costd').datebox('setValue',myformatter(row.costdate));//easyui-datebox专用赋值方法
		$('#startd').datebox('setValue',myformatter(row.startdate));
		url = '${pageContext.request.contextPath}/equipment/update.action?equipmentId='+row.equipmentId;
		form='#fm';
	}else{
		$.messager.show({
			title: '信息',
			msg: '请选择编辑行'
		});
	}
}

function repair(){
	$('#fm2').form('clear');
	var row = $('#dg').datagrid('getSelected');
	if (row){
		if(row.status=='正常'){
			$('#dlg2').dialog('open').dialog('setTitle','报修');
			$('#fm2').form('load',row);
			url = '${pageContext.request.contextPath}/equipment/repair.action';
			form='#fm2';
		}else{
			$.messager.show({
				title: '信息',
				msg: '该设备已报修'
			});
		}
		
	}else{
		$.messager.show({
			title: '信息',
			msg: '请选择编辑行'
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
				$.post('${pageContext.request.contextPath}/equipment/delete.action',{eid:row.equipmentId},function(result){
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
	}else{
		$.messager.show({
			title: '信息',
			msg: '请选择删除行'
		});
	}
}
</script>
</html>