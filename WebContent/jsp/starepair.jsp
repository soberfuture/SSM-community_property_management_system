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
		    url:'${pageContext.request.contextPath}/statistics/starepair.action',
		    fitColumns:true,
		    striped:true,
		    rownumbers:true,
		    singleSelect:true,
		    title:'维修统计报表',
		    toolbar:'#toolbar',
		    columns:[[
				{field:'month',title:'月份',width:100,align:'center'},
				{field:'solved',title:'解决',width:100,align:'center'},
				{field:'unsolved',title:'未解决',width:100,align:'center'},
				{field:'count',title:'总数',width:100,align:'center'},
				{field:'proportion',title:'解决占比',width:100,align:'center',formatter:showpro},
				{field:'score',title:'平均评价',width:100,align:'center'},
				{field:'ctime',title:'平均解决时间（天）',width:100,align:'center'},
		    ]]
		});
	});
	
	$('#year').combobox({
		editable:false,
		panelHeight:'auto',
		onSelect:function(param){
			console.log(param);
			$('#dg').datagrid({
				url:'${pageContext.request.contextPath}/statistics/starepair.action',
				queryParams:{
					year:param.value,
				}
			});
		}
	});
	
	function showpro(value,row){
		if(value=='0'||value==''){
			return '0%';
		}else{
			var d = parseFloat(value);
			var di = d*100;
			return di+'%';
		}
	}
	
	function print(){
		CreateFormPage("datagrid",$("#dg"));
	}
</script>
</html>