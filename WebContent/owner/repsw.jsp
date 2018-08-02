<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>修改密码界面</title>
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="owner_boddy">
	<jsp:include page="navigation.jsp"></jsp:include>
	<div class="center_right">
		<form class="repsw_form" method="post">
		  <div class="alert alert-warning hidden">
		  	<strong>警告！</strong><span></span>
		  </div>
		  <div class="form-group">
		    <label for="exampleInputEmail1">旧密码</label>
		    <input type="password" class="form-control" id="password" name="password" placeholder="请输入原密码" >
		  </div>
		  <div class="form-group">
		    <label for="exampleInputPassword1">新密码</label>
		    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="请输入新密码" >
		  </div>
		  <div class="form-group">
		    <label for="exampleInputPassword1">确&emsp;认</label>
		    <input type="password" class="form-control" id="reNewPassword" name="reNewPassword" placeholder="请确认新密码" >
		  </div>
		  <div class="person_btn">
				<a href="javascript:void(0);" onclick="repsw()">修改密码</a>
		  </div>
		</form>
	</div>
	<div class="clear-fixed"></div>
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function repsw(){
		var password = $('#password').val();
		var newPassword = $('#newPassword').val();
		var reNewPassword = $('#reNewPassword').val();
		if(password!=''&&newPassword!=''&&reNewPassword!=''){
			if(password==newPassword){
				$('.alert-warning span').text('新密码不能与原密码相同');
				$('.alert-warning').removeClass('hidden');
			}else{
				if(newPassword!=reNewPassword){
					$('.alert-warning span').text('两次密码输入不相同');
					$('.alert-warning').removeClass('hidden');
				}else{
					$.post('${pageContext.request.contextPath}/user/modificationPsw.action',
							{
								password:password,
								newPassword:newPassword,
								reNewPassword:reNewPassword
							},
							function(result){
								if(result.success){
									alert(result.message);
									$('.alert-warning span').text('');
									$('.alert-warning').addClass('hidden');
									$('.repsw_form input').val('');
								}else{
									$('.alert-warning span').text(result.message);
									$('.alert-warning').removeClass('hidden');
								}
					});
				}
			}
		}else{
			$('.alert-warning span').text('输入框不能为空');
			$('.alert-warning').removeClass('hidden');
		}
		
	};
</script>
</html>