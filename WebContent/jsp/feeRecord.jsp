<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
</head>
<body style="margin: 0;padding: 0;">
	<div class="bar">
		<form id="searchform" method="post">
			<label>查询历史费用房间：</label>
			<input class="easyui-combobox" id="position" name="position" data-options="required:true" />
			<label>开始时间：</label>
			<input class="easyui-datebox" id="startdate" name="startdate" data-options="required:true" />
			<label>截止时间：</label>
			<input class="easyui-datebox" id="stopdate" name="stopdate" data-options="required:true" />
			<a id='bt_search' href="javascript:;" class="easyui-linkbutton" iconCls="icon-search">查询</a>
		</form>
	</div>
	<div class="fee">
		<table id="dg1" title="历史费用" class="easyui-datagrid"
			 style="width: 100%;max-height: 590px" toolbar="#toolbar" rownumbers="true" fitColumns="true" striped="true"
			singleSelect="true">
			<thead>
				<tr>
					<th field="position" width="50">物业地址</th>
					<th field="project" width="50">收费项目</th>
					<th field="way" width="50">收费方式</th>
					<th field="money" width="50">金额</th>
					<th field="date" width="50">缴费日期</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-print" plain="true" onclick="print()">打印</a>
		</div>
	</div>
</body>
<script type="text/javascript">
		$(document).ready(function(){
		    queryXzqh();
		  });
	
		  function queryXzqh(){
			  $("#position").combobox({
				  url:"${pageContext.request.contextPath}/house/findAllHouse.action",//获取数据
				  // 向服务器请求的模式 
				  method : "post",
				  valueField: 'position',
				  textField: 'position',
			  });
		  }
		
		function print(){
			CreateFormPage("datagrid",$("#dg1"));
		}
		
		$('#bt_search').click(function(){
			var url = "${pageContext.request.contextPath}/feeRecord/findFeeRecord.action";
			$('#searchform').form('submit',{
				url: url,
				onSubmit: function(){
					return $(this).form('validate');
				},
				success: function(result){
					var data = JSON.parse(result);
					console.log(result)
					$('#dg1').datagrid('loadData',data);
				}
			});
		});
</script>
</html>