<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div style="height: 20px;"></div>
<div class="center_left">
	<div style="height: 20px;"></div>
	<div class="touxiang">
		<c:if test="${user.house.owner.sex=='男' }">
			<img alt="头像" src="../images/liubei.png" >
		</c:if>
		<c:if test="${user.house.owner.sex=='女' }">
			<img alt="头像" src="../images/touxiang.jpg" >
		</c:if>
	</div>
	<div class="name">${user.house.owner.ownerName}</div>
	<div class="name"><img alt="账户" src="../images/money.png">&nbsp;<span id="balance"></span></div>
	<ul class="userinfo_bar">
		<li data-name="userinfo"><a href="${pageContext.request.contextPath}/user/life.action?bar=userinfo">基本资料</a></li>
		<li data-name="charge"><a href="${pageContext.request.contextPath}/charge/findListByUser.action">生活缴费</a></li>
		<li data-name="addRepair"><a href="${pageContext.request.contextPath}/user/life.action?bar=addRepair">申报修理</a></li>
		<li data-name="addComplaint"><a href="${pageContext.request.contextPath}/user/life.action?bar=addComplaint">服务投诉</a></li>
		<li data-name="repair"><a href="${pageContext.request.contextPath}/repair/sendPagination.action">我的报修</a></li>
		<li data-name="complaint"><a href="${pageContext.request.contextPath}/complaint/sendPagination.action">我的投诉</a></li>
		<li data-name="feeRecord"><a href="${pageContext.request.contextPath}/feeRecord/sendPagination.action">缴费记录</a></li>
		<li data-name="repsw"><a href="${pageContext.request.contextPath}/user/life.action?bar=repsw">修改密码</a></li>
		<li><a href="${pageContext.request.contextPath}/user/exit.action">退出登录</a></li>
	</ul>
</div>
<script>
	$(function(){
		
		balance();
		
		var nav = '${pagination.navigation}';
		$('.userinfo_bar li').each(function(index,element){
			var data_name = $(this).data('name');
			if(nav==data_name){
				$(this).addClass('selected');
			}
		});
	});
	
	function balance(){
		$.post('${pageContext.request.contextPath}/user/refreshUser.action',{position:'${user.username}'},function(data){
			$('#balance').text(data.house.owner.account);
		});
	}
</script>