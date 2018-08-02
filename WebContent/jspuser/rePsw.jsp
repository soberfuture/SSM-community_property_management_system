<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>重置密码</title>
<link rel="stylesheet" href="../css/common_form.css">
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
</head>
<body style="margin: 0;padding: 0;">
    <div class="content">
        <img class="content-logo" src="../images/mimalogo.png" alt="logo">
        <h1 class="content-title">重置密码</h1>
        <div class="content-form">
            <form id="fm" method="post">
            	<p id="remind_1"></p>
            	<div style="height: 20px;"></div>
                <div id="change_margin_1">
                    <input id="npassword" class="password" type="password" name="npassword" placeholder="请输入新密码" >
                </div>
                <!-- input的value为空时弹出提醒 -->
                <div style="height: 20px;"></div>
                <div id="change_margin_2">
                    <input id="rnpassword" class="password" type="password" name="rnpassword" placeholder="请确认新密码" >
                </div>
                <!-- input的value为空时弹出提醒 -->
                <p id="remind_2"></p>
                <div style="height: 20px;"></div>
                <div id="change_margin_3">
                    <input id="submit" class="content-form-signup" type="button" value="确定">
                </div>
            </form>
        </div>
    </div>
	<script>
		$('#submit').click(function(){
			$('#remind_1').html('');
			var npassword = $('#npassword').val();
			var rnpassword = $('#rnpassword').val();
			$.ajax({
				  type: 'POST',
				  url: '${pageContext.request.contextPath}/user/revisePsw.action',
				  data: {"npassword":npassword,"rnpassword":rnpassword},
				  dataType: 'json',
				  success: function(result){ 
					 if(result.success){
						 alert(result.message);
						 location.href='${pageContext.request.contextPath}/jspuser/login.jsp';
					 }else{
						 $('#remind_1').html(result.message);
					 }
				  },
				  error:function(){
					  console.log('出错！');
				  }
			});
		});
	</script>
</body>
</html>