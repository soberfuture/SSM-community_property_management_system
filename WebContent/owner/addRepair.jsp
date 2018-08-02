<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../images/home.png" media="screen" />
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/userinfo.css">
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<link href="../css/style.css" rel="stylesheet" type="text/css" media="all" />
<title>报修</title>
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="owner_boddy">
	<jsp:include page="navigation.jsp"></jsp:include>
	<div class="center_right">
		<form>
		  <div class="alert alert-warning hidden">
		  	<strong>警告！</strong><span></span>
		  </div>
		  <div class="form-group">
		    <label>手机号码</label>
		    <input type="text" class="form-control" id="tel">
		  </div>
		  <div class="form-group">
		    <label>报修内容</label>
		    <textarea class="form-control" rows="10" id="content"></textarea>
		  </div>
		  <div class="person_btn">
			<a href="javascript:void(0);" onclick="submit()">提交</a>
		  </div>
		</form>
	</div>
	<div class="clear-fixed"></div>
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function submit(){
		$('.alert-warning span').text('');
		$('.alert-warning').addClass('hidden');
		var tel = $('#tel').val();
		var content = $('#content').val();
		if(tel!=null&&tel!=''&&content!=null&&content!=''){
			if(/^0{0,1}1[3,8,5][0-9]{9}$/.test(tel)){
				$.post('${pageContext.request.contextPath}/repair/addRepair.action',
						{
							position:'${user.username}',
							tel:tel,
							content:content,
						},function(result){
							if(result.success){
								alert(result.message);
								$('.form-group .form-control').val('');
							}else{
								$('.alert-warning span').text(result.message);
								$('.alert-warning').removeClass('hidden');
							}
						});
			}else{
				$('.alert-warning span').text('手机号码格式不正确！');
				$('.alert-warning').removeClass('hidden');
			}
		}else{
			$('.alert-warning span').text('手机号码与报修内容均不能为空！');
			$('.alert-warning').removeClass('hidden');
		}
	}
</script>
</html>