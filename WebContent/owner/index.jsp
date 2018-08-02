<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:if test="${user==null }">
	<jsp:forward page="../jspuser/login.jsp"></jsp:forward>
</c:if>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="shortcut icon" type="image/x-icon" href="../images/home.png" media="screen" />
	<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
	<link rel="stylesheet" href="../css/bootstrap.min.css">
	<script type="text/javascript" src="../js/bootstrap.min.js"></script>
	<link href="../css/style.css" rel="stylesheet" type="text/css" media="all" />
	<link href="../css/slider.css" rel="stylesheet" type="text/css" media="all" />
	<script type="text/javascript" src="../js/jquery.nivo.slider.js"></script>
	<link rel="stylesheet" href="../css/calendar.css">
	<script type="text/javascript" src="../js/calendar.js"></script>
	<link href="../css/top.css" rel="stylesheet" type="text/css" media="all" />
	<title>业主界面</title>
	<style type="text/css">
		*{
			margin: 0;
			padding: 0;
		}
		body{
			background: #fff;
		}
		
		.owner_boddy{
			width: 100%;
		}
		.services_calendar {
			background: #fff
		}
		.calendar-hd{
			height:40px;
		}
	</style>
	<script type="text/javascript">
		
		$(function () {
			$('#slider').nivoSlider();
			notice();

			/*bootstrap dropdown 兼容*/
			$('.user-dropdown-menu').on('click', 'li', function (e) {
				if ($(this).children().length === 0) {
					return false;
				}
			});
			
			$('.services_list').on('click','a',function(e){
				var ctx = $(this).data('content');
				$('.modal-title').text('公告');
				$('.modal-body').text(ctx);
			})
			
		})
		
		function calendar(){
			$('.services_calendar').calendar({
				width: $('.services_list').width(),
				height: $('.services_list').height(),
				data: [
					{
						date: '2015/12/24',
						value: 'Christmas Eve'
					},
					{
						date: '2015/12/25',
						value: 'Merry Christmas'
					},
					{
						date: '2016/01/01',
						value: 'Happy New Year'
					}
				],
				onSelected: function (view, date, data) {
				}
			});
		}
		
		function notice(){
			var index=1;
			var pagesize=10;
			$.post('${pageContext.request.contextPath}/notice/findByPagination.action',{page:index,rows:pagesize},function(data){
				var result = data.rows;
				var str = '';
				$.each( result, function(index, content){
					str += '<li><a data-toggle="modal" data-target="#myModal" data-content="'+content.content+'" data-date="'+content.date+'">'+content.title+'</a></li>';
				});
				$('.services_list ul').html(str);
				calendar();//日历
			});
		}
		
		
	</script>
</head>
<body>
	<div class="owner_top">
		<div class="logo">Community</div>
		<ul class="navigation">
			<li class="selected">首页</li>
			<li><a href="${pageContext.request.contextPath}/user/life.action?bar=userinfo">生活</a></li>
		</ul>
	</div>
	<div class="owner_boddy">
		<div class="slider">
			<div class="slider-wrapper theme-default">
				<div id="slider" class="nivoSlider">
					<img src="../images/1.jpg" data-thumb="../images/1.jpg" alt="" />
					<img src="../images/2.jpg" data-thumb="../images/2.jpg" alt="" />
					<img src="../images/3.jpg" data-thumb="../images/3.jpg" alt="" />
					<img src="../images/4.jpg" data-thumb="../images/4.jpg" alt="" />
				</div>
			</div>
		</div>
		<!------End Slider ------------>
	</div>
	<div class="main">
		<div class="wrap">
			<div class="sidebar">
				<div class="sidebar_left_top">
					<div class="services">
						<h3>日历</h3>
						<div class="services_calendar">

						</div>
					</div>
				</div>
				
			</div>
			<div class="content">
				<div class="content_bottom">
					<h2>花园小区基本情况简介</h2>

					<h3>&emsp;zz花园位于滨海大道南山第一站，西邻南山区政府,南邻南山商业文化中心，东邻深圳市高新技术产业园区，北邻深圳大学，是以z深圳（集团）公司为主开发兴建的高尚住宅小区。小区由7栋9-11层围合式住宅组成，共399户，居住人口1000余人，入伙率达100%，占地24225平方米，总建筑面积44379平方米，其中商业面积为2621平方米，绿化面积近10000平方米，绿化率60%，地下车库车位173个。</h3>
					<p>&emsp;zz花园小区外围装有红外线监控系统可对小区外围进行24小时监控；保安消防监控中心对讲系统24小时可直接与业主双向对讲通话；小区出入口装有电子门禁系统；消防系统采用温感、烟感、自动喷淋等先进科技布防监控，遇到火警自动报警；通风设备自动启动，能及时、有效控制险情。总之，小区具有完善配套设施，如临街有各类商铺林四十多间，南山区学府小学及教育幼儿园近在咫尺，海雅、岁宝等大型百货商场隔街相望，小区内地下停车场、游泳池、儿童娱乐场、喷泉、会所一应俱全。</p>
					<p>&emsp;小区于2000年12月31日开始正式入伙，由深圳市z物业管理有限公司z花园管理处负责专业化、一体化的物业管理。2001年荣获了深圳市"园林式、花园式"小区的称号，同年12月28日通过了质量/环境/安全三个体系的认证，成为目前全国第一家同时经过三个体系认证的住宅小区；小区自2000年12月31日入伙以来，从未发生过任何刑事案件；今年5月份，荣获了"南山区物业管理优秀示范小区"的称号。</p>
					<div class="feature_list">
						<h2>小区服务</h2>
						<ul>
							<li>服务宗旨：热情、周到、优质、高效。</li>
							<li>服务理念：满足业主的合理需求。</li>
							<li>服务内容：业主的需要就是我的服务。</li>
							<li>总体要求：工作制度化、管理一体化、考核数字化、请修专业化、服务个性化。</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="sidebar">
				<div class="sidebar_right_top">
					<h3>小区公告</h3>
					<div class="services_list">
						<ul>
							
						</ul>
					</div>
				</div>
				
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<jsp:include page="foot.jsp"></jsp:include>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel"></h4>
	      </div>
	      <div class="modal-body">
	        
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	      </div>
	    </div>
	  </div>
	</div>
</body>
</html>