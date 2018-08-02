<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../images/home.png" media="screen" />
<script type="text/javascript" src="../js/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/userinfo.css">
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<link href="../css/style.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="../js/BeatPicker.min.js"></script>
<link href="../css/BeatPicker.min.css" rel="stylesheet" type="text/css" media="all" />
<title>缴费记录</title>
<script type="text/javascript">
	function checkdate(){
		var startdate = $('#startdate').val();
		var stopdate = $('#stopdate').val();
		if(startdate>stopdate){
			alert('时间选择错误');
		}
	}

	function search(){
		var startdate = $('#startdate').val();
		var stopdate = $('#stopdate').val();
		var regex = /^[0-9]{4}-[0-1]?[0-9]{1}-[0-3]?[0-9]{1}$/;
		if(startdate!=''&&stopdate!=''&&regex.test(startdate)&&regex.test(stopdate)){
			if(startdate>stopdate){
				alert('时间选择错误');
			}else{
				window.location.href="${pageContext.request.contextPath}/feeRecord/sendPagination.action?startdate="+startdate+"&stopdate="+stopdate;
			}
		}else{
			alert('时间错误');
		}
	}
</script>
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="owner_boddy">
	<jsp:include page="navigation.jsp"></jsp:include>
	<div class="center_right">
		<c:if test="${fn:length(pagination.list)==0}">
			<div class="kong">
				哎呦！没有投诉过，谢谢对小区肯定。
			</div>
		</c:if>
		<c:if test="${fn:length(pagination.list)!=0}">
		<div>
			<label>按时间段查询：</label>
			<input id="startdate" type="date" value="${startdate }">——<input id="stopdate" type="date" value="${stopdate }" onchange="checkdate()">&emsp;<button type="button" class="btn btn-primary" onclick="search()">查询</button>
		</div>
		<table class="table table-hover">
		  	<thead>
		  		<tr>
		  			<th>序号</th>
		  			<th>物业地址</th>
		  			<th>收费项目</th>
		  			<th>收费方式</th>
		  			<th>金额</th>
		  			<th>缴费日期</th>
		  		</tr>
		  	</thead>
		  	<tbody>
		  		<c:forEach var="item" items="${pagination.list}" varStatus="i">
		  			<tr>
		  				<td>${i.index+1}</td>
		  				<td>${item.position }</td>
		  				<td>${item.project }</td>
		  				<td>${item.way}</td>
		  				<td>${item.money}</td>
		  				<td>${item.date}</td>
		  			</tr>
		  		</c:forEach>
		  	</tbody>
		</table>
		</c:if>
	</div>
</div>
<div class="clear"></div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>