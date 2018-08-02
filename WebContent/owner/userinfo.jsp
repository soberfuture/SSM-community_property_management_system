<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<title>业主界面</title>
<style type="text/css">
	.error{
		color: red;
	}
</style>
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="owner_boddy">
	<jsp:include page="navigation.jsp"></jsp:include>
	<div class="center_right">
		<div title="个人信息" class="person_info">
			<div class="person_info_title">个人信息</div>
			<form class="form-inline form_content">
				<div class="form-group person_content">
					<label>姓名：</label><span>${user.house.owner.ownerName}</span>
				</div>
				<div class="form-group person_content">
					<label>性别：</label><span>${user.house.owner.sex}</span>
				</div>
				<div class="form-group person_content">
					<label>籍贯：</label><span>${user.house.owner.hometown}</span>
				</div>
				<div class="form-group person_content">
					<label>身份证号：</label><span>${user.house.owner.idcard}</span>
				</div>
				<div class="form-group person_content">
					<label class="form-label">电子邮箱：</label>
					<input type="text" class="form-control" id="email" value="${user.house.owner.email}" style="width: 300px;" onchange="ischange()"><span class="error"></span>
				</div>
				<div class="form-group person_content">
					<label>手机号码：</label>
					<input type="text" class="form-control" id="tel" value="${user.house.owner.tel}" style="width: 300px;" onchange="ischange()">
				</div>
				<div class="form-group person_content">
					<label>工作单位：</label>
					<input type="text" class="form-control" id="job" value="${user.house.owner.job}" style="width: 300px;" onchange="ischange()">
				</div>
				<div class="person_btn">
					<a id="revise_info" href="javascript:void(0);" onclick="revise()" class="disabled">保存修改</a>
				</div>
			</form>
		</div>
		<div title="房产信息" class="person_info">
			<div class="person_info_title">房产信息</div>
			<div class="form_content">
				<div class="person_content">
					<label>物业地址：</label><span>${user.house.position }</span>
				</div>
				<div class="person_content">
					<label>房产面积：</label><span>${user.house.area }㎡</span>
				</div>
				<div class="person_content">
					<label>使用面积：</label><span>${user.house.usedarea }㎡</span>
				</div>
				<div class="person_content">
					<label>房产类型：</label><span>${user.house.houseType }</span>
				</div>
			</div>
		</div>
		<div title="车位信息" class="person_info">
			<div class="person_info_title">车位信息</div>
			<div class="form_content">
				<c:forEach var="item" items="${carportList }">
					<div class="carport_info">
						<label>车位位置：</label><span>${item.carportPosition }</span><br><br>
						<label>面积：</label><span>${item.area }㎡</span><br><br>
						<label>开始日期：</label><span><fmt:formatDate value="${item.startdate }"/></span>&emsp;&emsp;<label>截止日期：</label><span><fmt:formatDate value="${item.stopdate }"/></span><br><br>
						<label>费用：</label><span>${item.carportFee }元</span><br><br>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="clear-fixed"></div>
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function revise(){
		var email = $('#email').val();
		var tel = $('#tel').val();
		var job = $('#job').val();
		if(email!=''&&tel!=''){
			if(/^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/.test(email)){
				if(/^0{0,1}1[3,8,5][0-9]{9}$/.test(tel)){
					$.post('${pageContext.request.contextPath}/owner/revise.action',{ownerId:'${user.house.owner.ownerId}',email:email,tel:tel,job:job},function(result){
						alert(result.message);
						$('#revise_info').addClass('disabled');
					});
				}else{
					$('.error').html('手机格式不正确');
				}
			}else{
				$('.error').html('邮箱格式不正确');
			}
		}else{
			$('.error').html('输入不能为空');
		}
		setInterval(show,3000);// 注意函数名没有引号和括弧！
	}
	
	function ischange(){
		$('#revise_info').removeClass('disabled');
	}
	
	function show(){
		$('.error').html('');
	}
	
</script>
</html>