<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<title>缴费界面</title>
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div class="owner_boddy">
	<jsp:include page="navigation.jsp"></jsp:include>
	<div class="center_right">
		<div class="alert alert-warning hidden" id="outer_error">
		  	<strong>警告！</strong><span></span>
		</div>
		<button class="btn btn-primary" data-toggle="modal" data-target="#myModal" onclick="reset()">充值</button>
		<c:if test="${fn:length(chargelist)==0 && fn:length(propertyFeelist)==0 }">
			<div class="kong">
				没有需要缴纳的费用
			</div>
		</c:if>
		<c:if test="${fn:length(chargelist)!=0 || fn:length(propertyFeelist)!=0 }">
		<table class="table table-hover">
			<thead>
			<tr>
	            <th>序号</th>
	            <th>收费项目</th>
	            <th>用量</th>
	            <th>单价</th>
	            <th>应交金额</th>
	            <th>录入日期</th>
	        </tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${chargelist}" varStatus="i">
					<tr data-id="${item.chargeId }" class="charge" >
			            <td>${i.index+1}</td>
			            <td>${item.project}</td>
			            <td>${item.used }</td>
			            <td>${item.price }</td>
			            <td>${item.total }</td>
			            <td><fmt:formatDate value="${item.indate }" pattern="yyyy-MM-dd"/></td>
			        </tr>
				</c:forEach>
				<c:forEach var="item" items="${propertyFeelist}" varStatus="i">
					<tr data-id="${item.feeId }" class="propertyFee">
			            <td>${fn:length(chargelist)+i.index+1 }</td>
			            <td>${item.project }</td>
			            <td></td>
			            <td></td>
			            <td>${item.total }</td>
			            <td><fmt:formatDate value="${item.inputdate }" pattern="yyyy-MM-dd"/></td>
			        </tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td>总额</td>
					<td colspan="5">${totalPay}</td>
				</tr>
			</tfoot>
	    </table>
	    <div class="person_btn">
			<a href="javascript:void(0);" onclick="payment()">缴&emsp;费</a>
		</div>
		</c:if>
	</div>
	<div class="clear-fixed"></div>
</div>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">充值</h4>
      </div>
      <div class="modal-body">
      	<div class="alert alert-warning hidden" id="inner_error">
		  	<strong>警告！</strong><span></span>
		</div>
        <input class="form-control" id="money" placeholder="输入金额">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" onclick="recharge()">确定</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="foot.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function getId(clastr){
		var id='';
		$('tbody .'+clastr).each(function(i,e){
			var s = $(this).data('id');
			if(i==0){
				id+=s;
			}else{
				id+=' '+s;
			}
		});
		return id;
	}

	function payment(){
		$('#outer_error span').text('');
		$('#outer_error').addClass('hidden');
		var cid = getId('charge');
		var fid = getId('propertyFee');
		if('${totalPay}'==0){
			$('#outer_error span').text('没有要缴纳的费用');
			$('#outer_error').removeClass('hidden');
		}else{
			$.post(
					'${pageContext.request.contextPath}/charge/paymentOnline.action',
					{
						cid:cid,
						fid:fid
					},
					function(data){
						if(data.success){
							alert(data.message);
							window.location.reload();
						}else{
							$('#outer_error span').text(data.message);
							$('#outer_error').removeClass('hidden');
						}
					}
				);
		}
	}
	
	function reset(){
		$('#inner_error span').text('');
		$('#money').val('');
		$('#inner_error').addClass('hidden');
	}
	
	function recharge(){
		var money = $('#money').val();
		if(/^[0-9]*[1-9][0-9]*$/.test(money)){
			$.post('${pageContext.request.contextPath}/owner/deposit.action',
					{
						ownerId:'${user.house.ownerId}',
						money:money,
					},function(result){
						if(result.success){
							alert('充值成功');
							$('#myModal').modal('toggle')
							balance();
						}else{
							$('#inner_error span').text(result.message);
							$('#inner_error').removeClass('hidden');
						}
			});
		}else{
			$('#inner_error span').text('请输入正整数');
			$('#inner_error').removeClass('hidden');
		}
		
	}
</script>
</html>