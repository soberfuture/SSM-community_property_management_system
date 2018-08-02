<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>物业费用管理</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
</head>
<body style="margin: 0;padding: 0;">
	<table id="dg" iconCls="icon-fee"></table>
	<div id="toolbar">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">录入费用</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
		<input class="easyui-searchbox" data-options="prompt:'请输入要搜索的物业地址',menu:'#mm',searcher:doSearch" style="width: 250px;">
		<div id="mm">
			<div data-options="name:'all'">显示所有</div>
			<div data-options="name:'position'">物业地址</div>
			<div data-options="name:'project'">收费项目</div>
		</div>
	</div>
	<div id="dlg" style="padding: 30px 30px;">
		<form id="fm" method="post">
			<div class="fitem">
					<label>物业地址:</label>
					<input class="easyui-combobox" id="position" name="position" style="width:150px" required="true"/>
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
					<label>缴费项目:</label>
					<input name="project" class="easyui-validatebox" required="true">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
					<label>缴费金额:</label>
					<input name="total" class="easyui-validatebox" required="true" validType="num">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()">取消</a>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		$('#dg').datagrid({
			title:'物业费用管理',
			url:'${pageContext.request.contextPath}/propertyFee/findByPagination.action',
			pagination:true,
			striped:true,
			toolbar:'#toolbar',
			rownumbers:true,
			fitColumns:true,
			singleSelect:true,
		    columns:[[
				{field:'position',title:'物业地址',width:100,align:'center'},
				{field:'inputdate',title:'录入日期',width:100,align:'center',formatter:myformatter},
				{field:'project',title:'缴费项目',width:100,align:'center'},
				{field:'way',title:'缴费方式',width:100,align:'center'},
				{field:'total',title:'总额',width:100,align:'center'},
				{field:'deliverdate',title:'缴费日期',width:100,align:'center',formatter:myformatter},
				{field:'transactor',title:'办理人',width:100,align:'center'},
				{field:'remark',title:'备注',width:100,align:'center'},
		    ]]
		});
		
		$('#dlg').dialog({
		    width: 400,
		    height: 300,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons:'#dlg-buttons',
		});
		
		queryXzqh();
	});
	
	/*日期转化*/
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
	/*初始化房间*/
	function queryXzqh(){
		  $("#position").combobox({
			  url:"${pageContext.request.contextPath}/house/findHouseByStatus.action?status=已入住",//获取数据
			  // 向服务器请求的模式 
			  method : "post",
			  editable:false,
			  valueField: 'position',
			  textField: 'position',
		  });
	 }
	
	function doSearch(value,name){
		var u;
		if(name == 'all'){
			u = "${pageContext.request.contextPath}/propertyFee/findByPagination.action";
		}else{
			u = "${pageContext.request.contextPath}/propertyFee/doSearch.action?name="+name+"&value="+value ;
		}
		$('#dg').datagrid('options').url = u;
		$('#dg').datagrid('reload');
	}
	
	var url;
	
	/*录入费用按钮*/
	function add(){
		$('#dlg').dialog('open').dialog('setTitle','录入费用');
		$('#fm').form('clear');
		url = '${pageContext.request.contextPath}/propertyFee/inputFee.action';
	}
	
	
	/*保存按钮*/
	function save(){
			$('#fm').form('submit',{
				url: url,
				onSubmit: function(){
					return $(this).form('validate');
				},
				success: function(result){
					var result = eval('('+result+')');
					if (result.success){
						$('#dlg').dialog('close');		// close the dialog
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
				},
				error:function(){
					$.messager.show({
						title: '错误',
						msg: result.message
					});
				}
			});
	}
	
	function remove(){
		var row = $('#dg').datagrid('getSelected');
		if (row){
			$.messager.confirm('删除','您确定要删除这一条记录吗?',function(r){
				if (r){
					$.post('${pageContext.request.contextPath}/propertyFee/delFee.action',{feeId:row.feeId},function(result){
						//console.log(result);
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
	
	/*关闭按钮*/
	function cancel() {
		$('#dlg').dialog('close');
	}
</script>
</html>