<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告页面</title>
<jsp:include page="default.jsp" flush="true"></jsp:include>
</head>
<body style="margin: 0;padding: 0;">
	<table id="dg_notice" iconCls="icon-stat"></table>
	<div id="toolbar_notice">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="revise()">修改</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a> 
	</div>
	<div id="dlg_notice" style="padding: 40px 40px;">
		<form id="fm_notice" method="post">
			<div class="fitem">
				<label>标题:</label>
				<input name="title" class="easyui-validatebox" required="true">
			</div>
			<div style="height: 40px"></div>
			<div class="fitem">
				<label>内容:</label>
				<input name="content" class="easyui-validatebox" required="true">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_notice').dialog('close')">取消</a>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#dg_notice').datagrid({
			    url:'${pageContext.request.contextPath}/notice/findByPagination.action',
			    fitColumns:true,
			    striped:true,
			    rownumbers:true,
			    pagination:true,
			    singleSelect:true,
			    title:'公告管理',
			    toolbar:'#toolbar_notice',
			    columns:[[
					{field:'title',title:'标题',width:100,align:'center'},
					{field:'content',title:'内容',width:100,align:'center'},
					{field:'date',title:'发布日期',width:100,align:'center'},
					{field:'person',title:'发布人',width:100,align:'center'},
					]]
			});
			
			$('#dlg_notice').dialog({
			    width: 400,
			    height: 350,
			    closed: true,
			    cache: false,
			    modal: true,
			    buttons:'#dlg-buttons'
			});
		});
		
		function add(){
			$('#dlg_notice').dialog('open').dialog('setTitle','新增');
			$('#fm_notice').form('clear');
			url = '${pageContext.request.contextPath}/notice/insert.action';
		}

		function revise(){
			$('#fm_notice').form('clear');
			var row = $('#dg_notice').datagrid('getSelected');
			if (row){
				$('#dlg_notice').dialog('open').dialog('setTitle','编辑');
				$('#fm_notice').form('load',row);
				url = '${pageContext.request.contextPath}/notice/update.action?nid='+row.nid;
			}else{
				$.messager.show({
					title: '信息',
					msg: '请选择编辑行'
				});
			}
		}
		
		function remove(){
			var row = $('#dg_notice').datagrid('getSelected');
			if (row){
				$.messager.confirm('删除','您确定要删除这一条记录吗?',function(r){
					if (r){
						$.post('${pageContext.request.contextPath}/notice/delete.action',{nid:row.nid},function(result){
							if (result.success){
								$('#dg_notice').datagrid('reload');	// reload the user data
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
		
		function save(){
			$('#fm_notice').form('submit',{
				url: url,
				onSubmit: function(){
					return $(this).form('validate');
				},
				success: function(result){
					var result = eval('('+result+')');
					if (result.success){
						$('#dlg_notice').dialog('close');
						$('#dg_notice').datagrid('reload');	// reload the user data
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
	</script>
</body>
</html>