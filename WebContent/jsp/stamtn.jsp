<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>设备维修统计</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
</head>
<body style="margin: 0;padding: 0;">
	<table id="dg" iconCls="icon-stat"></table>
	<div id="toolbar">
		&emsp;
		<select id="year" style="width: 60px;">
			<option value="2016">2016</option>
			<option value="2017" selected="selected">2017</option>
		</select>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-print" plain="true" onclick="print()">打印</a> 
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$('#dg').datagrid({
		    url:'${pageContext.request.contextPath}/statistics/stamaintenance.action',
		    rownumbers:true,
		    striped:true,
		    singleSelect:true,
		    title:'设备维修统计报表',
		    toolbar:'#toolbar',
		    columns:[[
				{field:'month',title:'月份',width:200,align:'center'},
				{field:'count',title:'总报修次数',width:200,align:'center'},
				{field:'costtime',title:'平均维修时间（天）',width:200,align:'center'},
				{field:'costmoney',title:'维修总额',width:200,align:'center'},
				{field:'avercm',title:'平均每次维修金额',width:200,align:'center'},
		    ]]
		});
		
		$('#year').combobox({
			editable:false,
			panelHeight:'auto',
			onSelect:function(param){
				$('#dg').datagrid({
					url:'${pageContext.request.contextPath}/statistics/stamaintenance.action',
					queryParams:{
						year:param.value,
					}
				});
			}
		});
	});
	
	function print(){
		CreateFormPage("datagrid",$("#dg"));
	}
</script>
</html>