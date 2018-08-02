<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="images/home.png" media="screen" />
<link href="css/top.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="css/userinfo.css">
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="css/error.css">
<title>404页面</title>
</head>
<body>
	
	<div class="owner_top">
		<div class="logo">Community</div>
		<ul class="navigation">
			<li><a href="../owner/index.jsp">首页</a></li>
			<li><a href="${pageContext.request.contextPath}/user/life.action?bar=userinfo">生活</a></li>
		</ul>
	</div>
	<div class="container main-container">
        <div class="root-view-bg"></div>
        <div class="view not-found-view">
            <div class="where-is-panfish">
                <img src="images/error_bg.png" class="elem bg">
                <img src="images/error_panfish.png" class="elem panfish">
                <img src="images/error_sea.png" class="elem sea">
                <img src="images/error_spray.png" class="elem spray">
            </div>
        </div>
    </div>
    <div class="footer">
		<div class="copy-right">
			<div class="wrap">
				<p>&copy; Copyright &copy; 2017.Community name All rights reserved.
				</p>
			</div>
		</div>
	</div>
</body>
</html>