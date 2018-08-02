<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../images/home.png" media="screen" />
<title>登录</title>
<link href="../css/login.css" rel="stylesheet" rev="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<style type="text/css">
	.logo{
			color:#FF7000;
			font-family: 'Edwardian Script ITC';
			font-size:70px;
			-moz-user-select: none;
			-khtml-user-select: none;
			user-select: none;
			float: left;
			padding:0px;
		}
</style>
</head>

<body>

	<div class="header">
		<div class="logo">Community</div>
	</div>

	<div class="banner">

		<div class="login-aside">
			<div id="o-box-up"></div>
			<div id="o-box-down" style="table-layout: fixed;">
				<div class="error-box"></div>

				<form class="loginform" method="post">
					<div class="fm-item">
						<label for="logonId" class="form-label">账号登陆：</label> 
						<input type="text" maxlength="100" id="username" class="i-text">
						<div class="ui-form-explain"></div>
					</div>

					<div class="fm-item">
						<label for="logonId" class="form-label">登陆密码：</label> 
						<input type="password" maxlength="100" id="password" class="i-text">
						<div class="ui-form-explain"></div>
					</div>

					<div class="fm-item">
						<label for="logonId" class="form-label"></label> 
						<input type="button" onclick="login();" value="" tabindex="4" id="send-btn" class="btn-login">
						<div class="ui-form-explain"></div>
					</div>
					
					<div  class="fm-item">
						<a href="javascript:;" style="text-decoration: none;color: #ccc" onclick="forgetPsw()">忘记密码?</a>
					</div>
					
				</form>

			</div>

		</div>

		<div class="bd">
			<ul>
				<li style="background: url(../images/xiaoqu.jpg) #CCE1F3 center 0 no-repeat;"></li>
			</ul>
		</div>

	</div>

	<div class="banner-shadow"></div>

	<div class="footer">
		<p>Copyright &copy; 2014.Company name All rights reserved.</p>
	</div>
</body>
<script type="text/javascript">
	function login(){
		var username = $('#username').val();
		var password = $('#password').val();
		if(username==''){
			$('.error-box').html('账号不能为空');
		}else{
			if(password==''){
				$('.error-box').html('密码不能为空');
			}else{
				$.ajax({
				    url:"${pageContext.request.contextPath}/user/login.action",    //请求的url地址
				    dataType:"json",   //返回格式为json
				    async:true,//请求是否异步，默认为异步，这也是ajax重要特性
				    data:{"username":username,"password":password},    //参数值
				    type:"POST",   //请求方式
				    success:function(result){
				        //请求成功时处理
				        if(result.success){
				        	if(result.type=='业主'){
				        		window.location.href="../owner/index.jsp";
				        	}
				        	if(result.type=='工作人员'){
				        		window.location.href="../staff/staff.jsp";
				        	}
				        }else{
				        	$('.error-box').html('账号或密码错误');
				        }
				    },
				    error:function(){
				        //请求出错处理
				    	alert('出错');
				    }
				});
			}
		}
	}
	
	function forgetPsw(){
		$('.error-box').html('');
		var username = $('#username').val();
		console.log(username);
		if(username==''){
			$('.error-box').html('帐号不能为空');
		}else{
			$.ajax({
				  type: 'POST',
				  url: '${pageContext.request.contextPath}/user/sendEmail.action',
				  data: {'username':username},
				  dataType: 'json',
				  success: function(result){ 
					  if(result.success){
						  alert(result.message);
					  }else{
						  $('.error-box').html(result.message);
					  }
				  },
				  error:function(){
					  console.log('出错！');
				  }
			});
		}
	}
</script>
</html>