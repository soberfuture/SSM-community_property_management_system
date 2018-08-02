<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="../images/home.png" media="screen" />
<script type="text/javascript" src="../js/jquery-1.11.0.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/userinfo.css">
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery.raty.min.js"></script>
<link href="../css/style.css" rel="stylesheet" type="text/css" media="all" />
<title>我的报修</title>
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="owner_boddy">
	<jsp:include page="navigation.jsp"></jsp:include>
	<div class="center_right">
		<c:if test="${fn:length(pagination.list)==0}">
			<div class="kong">
				哎呦！没有报修过，小区房子还是挺坚固的。
			</div>
		</c:if>
		<c:if test="${fn:length(pagination.list)!=0}">
		<button class="btn btn-primary" type="button" onclick="eval()">评价</button>
		<!-- Single button -->
		<div class="btn-group">
		  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    状态 <span class="caret"></span>
		  </button>
		  <ul class="dropdown-menu">
		    <li><a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action">全部</a></li>
		    <li><a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?way=已处理">已处理</a></li>
		    <li><a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?way=未处理">未处理</a></li>
		    <li><a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?way=已评价">已评价</a></li>
		  </ul>
		</div>
		<table class="table table-hover">
		  	<thead>
		  		<tr>
		  			<th>序号</th>
		  			<th>报修日期</th>
		  			<th>报修内容</th>
		  			<th>物业地址</th>
		  			<th>手机号码</th>
		  			<th>报修状态</th>
		  			<th>服务费用</th>
		  			<th>物料费用</th>
		  		</tr>
		  	</thead>
		  	<tbody>
		  		<c:forEach var="item" items="${pagination.list}" varStatus="i">
		  			<tr data-id="${item.repairId }">
		  				<td>${(pagination.index-1)*pagination.rows+i.index+1}</td>
		  				<td><fmt:formatDate value="${item.repairDate}"/></td>
		  				<td>${item.content}</td>
		  				<td>${item.position}</td>
		  				<td>${item.tel}</td>
		  				<td>${item.situation}</td>
		  				<td>${item.servicecost}</td>
		  				<td>${item.mattercost}</td>
		  			</tr>
		  		</c:forEach>
		  	</tbody>
		</table>
		<jsp:include page="pagination.jsp"></jsp:include>
		</c:if>
	</div>
	<div class="clear-fixed"></div>
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="exampleModalLabel">评价</h4>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="recipient-name" class="control-label">满意度:</label>
	            <div id="default-demo"></div>
	          </div>
	          <div class="form-group">
	            <label for="message-text" class="control-label">评价:</label>
	            <textarea class="form-control" id="econtent"></textarea>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary" onclick="submitEval()">确定</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
<jsp:include page="foot.jsp"></jsp:include>
</body>
<script type="text/javascript">
$('.table-hover tbody').on('click','tr',function(e){
	$('.table-hover tbody tr').removeClass('success');
	$(this).addClass('success');
});

function eval(){
	var tr = $('.table-hover tbody .success');
	var status = tr.children('td').eq(5).text();
	if(status=='已处理'){
		$('#econtent').val('');
		starInit();
		$('#exampleModal').modal('toggle');
	}else{
		alert('无法评价');
	}
	
}

/*星星初始化*/
function starInit(){
	$.fn.raty.defaults.path = '../images';
	$('#default-demo').raty();
}

function submitEval(){
	var star = $('#default-demo input').val();
	if(star==''){
		star='0';
	}
	var econtent = $('#econtent').val();
	var tr = $('.table-hover tbody .success');
	$.post('${pageContext.request.contextPath}/evaluate/insert.action',
			{star:star,econtent:econtent,eType:'repair',targetId:tr.data('id')},
			function(result){
			alert(result.message);
			if(result.success){
				tr.children('td').eq(5).text('已评价');
			}
			$('#exampleModal').modal('toggle');
	});
}
</script>
</html>