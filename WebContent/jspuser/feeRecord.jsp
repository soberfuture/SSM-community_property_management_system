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
	<div class="fee">
		<table id="dg" title="历史费用" class="easyui-datagrid" url="${pageContext.request.contextPath}/feeRecord/findFeeRecord.action?position=${user.house.position}"
			 style="width: 100%;max-height: 590px" toolbar="#toolbar" rownumbers="true" fitColumns="true"
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
			<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="findAll()">查看所有</a>&emsp;
			<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-print" plain="true" onclick="print()">打印</a>&emsp;
			<label>开始时间：</label>
			<input class="easyui-datebox" id="startdate" name="startdate" data-options="required:true" />&emsp;
			<label>截止时间：</label>
			<input class="easyui-datebox" id="stopdate" name="stopdate" data-options="required:true" />&emsp;
			<a id="bt_search" href="javascript:;" class="easyui-linkbutton" iconCls="icon-search">查询</a>
		</div>
	</div>
</body>
<script type="text/javascript">
function findAll(){
	var position = '${user.house.position}';
	var url = "${pageContext.request.contextPath}/feeRecord/findFeeRecord.action";
	$('#dg').datagrid({
		url:url,
		queryParams: {
			position: position,
		}
	});
}

function print(){
	CreateFormPage("datagrid",$("#dg"));
}

/*按时间查询*/
$('#bt_search').click(function(){
	var url = '${pageContext.request.contextPath}/feeRecord/findFeeRecord.action';
	var position = '${user.house.position}';
	var startdate = $('#startdate').val();
	var stopdate = $('#stopdate').val();
	if(compareDate(startdate,stopdate)){
		$('#dg').datagrid({
			url:url,
			queryParams: {
				position: position,
				startdate:startdate,
				stopdate:stopdate
			}
		});
	}else{
		alert('时间选择有误');
	} 
});
/*比较时间大小*/
function compareDate(startdate,stopdate){
	if(startdate==''||stopdate==''){
		return false;
	}
	var start = new Date(startdate.replace("-", "/").replace("-", "/"));
	var stop = new Date(stopdate.replace("-", "/").replace("-", "/"));
	if(start<=stop){
		return true;
	}else{
		return false;
	}
}
</script>
</html>