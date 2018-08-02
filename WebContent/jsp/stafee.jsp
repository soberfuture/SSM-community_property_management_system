<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
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
		    url:'${pageContext.request.contextPath}/statistics/stafee.action',
		    fitColumns:true,
		    striped:true,
		    rownumbers:true,
		    singleSelect:true,
		    title:'收费统计报表',
		    toolbar:'#toolbar',
		    columns:[[
				{field:'month',title:'月份',width:100,align:'center'},
				{field:'water',title:'总用水量（吨）',width:100,align:'center'},
				{field:'gas',title:'总用天然气量（升）',width:100,align:'center'},
				{field:'electricity',title:'总用电量（度）',width:100,align:'center'},
				{field:'wmoney',title:'总水费',width:100,align:'center'},
				{field:'gmoney',title:'总天然气费',width:100,align:'center'},
				{field:'emoney',title:'总电费',width:100,align:'center'},
				{field:'pmoney',title:'总物业费',width:100,align:'center'},
				{field:'averw',title:'平均用水量',width:100,align:'center'},
				{field:'averg',title:'平均用天然气量',width:100,align:'center'},
				{field:'avere',title:'平均用电量',width:100,align:'center'},
				{field:'averp',title:'平均物业费',width:100,align:'center'},
				]]
		});
		
		$('#year').combobox({
			editable:false,
			panelHeight:'auto',
			onSelect:function(param){
				$('#dg').datagrid({
					url:'${pageContext.request.contextPath}/statistics/stafee.action',
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