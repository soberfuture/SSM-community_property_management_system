<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${user==null }">
	<c:redirect url="../jspuser/login.jsp"></c:redirect>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="shortcut icon" type="image/x-icon" href="../images/home.png" media="screen" />
	<title>业主界面</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
	<style type="text/css">
		.navigation{
			width: 100%;
			height: 50px;
			background-color: #FFE7BA;
		}
		.navigation ul{
			margin: 0;
		}
		.navigation ul li{
			float:left;
			list-style:none;
			height:50px;
			width: 150px;
			text-align: center;
			padding: 0;
			font-size:18px;
			line-height: 50px;
			transition: 0.4s;
		}
		.navigation ul li:hover{
			background-color: #FF7F24;
			cursor: pointer;
		}
		.display{
			width: 100%;
			height: 700px;
		}
		a{
			text-decoration: none;
			color: black;
		}
		a:hover {
			color: red;
		}
		.liclicked{
			background-color: #FF7F24;;
		}
	</style>
</head>
<body style="margin: 0;">
	<div id="cc" class="easyui-layout" style="width:100%;height:860px;margin: 0 auto;">
	    <div data-options="region:'north'" style="height:100px;">
			<h1>小区业主界面 </h1>
			<label style="float: right;margin-right: 10px;">
				<img src="../images/money.png">&emsp;
				<span id="balance"></span>&emsp;&emsp;
				<img src="../images/man.png">&emsp; ${user.house.owner.ownerName} &emsp;&emsp; 
				<a href="${pageContext.request.contextPath}/user/exit.action"><img alt="退出登录" src="../images/exit.png"></a>
			</label>
		</div>
	    <div data-options="region:'center'">
	    	<div class="navigation">
				<ul class="ulc">
					<li data-href="notice.jsp" class="liclicked">小区公告</li>
					<li data-href="myinfo.jsp">个人信息</li>
					<li data-href="mypay.jsp">生活缴费</li>
					<li data-href="feeRecord.jsp">个人账单</li>
					<li data-href="addComplaint.jsp">业主投诉</li>
					<li data-href="addRepair.jsp">业主报修</li>
				</ul>
			</div>
			<div class="display">
				<iframe name="ownerMain" src="notice.jsp" style="width: 100%;height: 100%;" scrolling="no" frameborder="0"></iframe>
			</div>
	    </div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		balance();
	});
	
	function balance(){
		$.post('${pageContext.request.contextPath}/user/refreshUser.action',{position:'${user.username}'},function(data){
			$('#balance').text(data.house.owner.account);
		});
	}
	
	$('.ulc').on('click','li',function(){
		$('.ulc li').removeClass();
		$(this).addClass('liclicked');
		var href = $(this).data('href');
		if(href==''){
			console.log('空');
		}else{
			window.parent.ownerMain.location.href = href;
		}
	});
	
</script>
</html>