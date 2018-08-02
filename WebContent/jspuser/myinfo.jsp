<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="default.jsp" flush="true"></jsp:include>
<style type="text/css">
.tb td{
	width:600px;
	height:30px;
	padding-left: 50px;
}
.carport{
	margin-left:20px;
	width:950px;
	max-height: 150px;
}

.carport thead{
	background-color: #F5DEB3;
}

#carportinfo tr td{
	text-align: center;
}
#carportinfo tr:nth-child(2n) {
	background-color:#FAF0E6;
}
#carportinfo tr:nth-child(2n+1) {
	background-color:#F7F7F7;
}
.right-top{
	background-color:#EAEAEA;
	width: 200px;
	height: 50px;
	border-bottom-left-radius: 30px;
	position: absolute;
	right: 0;
	top: 0;
	box-shadow: -2px 2px 9px 1px rgba(0,0,0,0.3);
	line-height: 28px;
	text-align: center;
}
</style>
</head>
<body style="margin: 0;padding: 0;">
	<div style="width:100%;height: 300px;position:relative;border-bottom: 2px dashed #DDDDDD;">
		<div class="right-top" id="right-top-one">
			<h1>个人信息</h1>
		</div>
		<div style="width: 300px;height: 300px;float: left;">
			<c:if test="${user.house.owner.sex=='男'}">
				<img style="margin:50px 50px;border-radius: 50%;overflow: hidden;" src="../images/liubei.png">
			</c:if>
			<c:if test="${user.house.owner.sex=='女'}">
				<img style="margin:50px 50px;border-radius: 50%;overflow: hidden;" src="../images/touxiang.jpg">
			</c:if>
		</div>
		<div style="float: left;;height: 300px;width: 698px;">
			<table class="tb" style="margin-top: 30px;">
				<tr><td style="font-size: 30px;">${user.house.owner.ownerName}</td></tr>
				<tr><td><img src="../images/sex.png">&nbsp;${user.house.owner.sex}&emsp;&emsp;<img src="../images/position.png">&nbsp;${user.house.owner.hometown}&emsp;&emsp;<img src="../images/job.png">&nbsp;${user.house.owner.job}</td></tr>
				<tr><td><img src="../images/email.png">&nbsp;${user.house.owner.email}</td></tr>
				<tr><td><img src="../images/idcard.png">&nbsp;${user.house.owner.idcard}</td></tr>
				<tr><td><img src="../images/tel.png">&nbsp;${user.house.owner.tel}</td></tr>
				<tr><td><img src="../images/date.png">&nbsp;<label id="indate"></label></td></tr>
				<tr><td><a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" onclick="revise1()">修改信息</a> &emsp; <a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" onclick="revise2()">修改密码</a></td></tr>
			</table>
		</div>
	</div>
	<div style="width:100%;height: 200px;position:relative;border-bottom: 2px dashed #DDDDDD;">
		<div class="right-top" id="right-top-two">
			<h1>房产信息</h1>
		</div>
		<div style="width: 300px;height: 200px;float: left;">
			<img style="margin:20px 70px;border-radius: 50%;overflow: hidden;width: 150px;height: 150px;" src="../images/house.jpg">
		</div>
		<div style="float: left;height: 200px;width: 698px;">
			<table class="tb">
				<tr><td>物业地址：&emsp;${user.house.position }</td></tr>
				<tr><td>房产面积：&emsp;${user.house.area }</td></tr>
				<tr><td>使用面积：&emsp;${user.house.usedarea }</td></tr>
				<tr><td>房产类型：&emsp;${user.house.houseType }</td></tr>
				<tr><td>备&emsp;&emsp;注：&emsp;${user.house.remark }</td></tr>
			</table>
		</div>
	</div>
	<div style="width:100%;height: 200px;position:relative;">
		<div class="right-top" id="right-top-three">
			<h1>车位信息</h1>
		</div>
		<table class="carport" cellspacing="0">
			<thead>
				<tr>
					<th>编号</th>
					<th>车位位置</th>
					<th>面积</th>
					<th>开始日期</th>
					<th>截止日期</th>
					<th>费用</th>
				</tr>
			</thead>
			<tbody id="carportinfo"></tbody>
		</table>
	</div>
	<div id="dlg" class="easyui-dialog" style="width:400px;height:350px;padding:30px 30px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<div class="fitem">
				<label>籍&emsp;&emsp;贯:</label>
				<input id="hometown" name="hometown" class="easyui-validatebox" required="true">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>工&emsp;&emsp;作:</label>
				<input id="job" name="job" class="easyui-validatebox" required="true">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>电子邮箱:</label>
				<input id="email" name="email" class="easyui-validatebox" required="true" validType="email">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>手机号码:</label>
				<input id="tel" name="tel" class="easyui-validatebox" required="true" validType="mobile">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	
	<div id="dlg2" class="easyui-dialog" style="width:400px;height:300px;padding:30px 30px"
			closed="true" buttons="#dlg-buttons2">
		<form id="fm2" method="post">
			<div class="fitem">
				<label>确认原密码:</label>
				<input id="password" name="password" class="easyui-validatebox" required="true">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>输入新密码:</label>
				<input id="newPassword" name="newPassword" class="easyui-validatebox" required="true" validType="checkNew">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>确认新密码:</label>
				<input id="reNewPassword" name="reNewPassword" class="easyui-validatebox" required="true" validType="checkNewAgain">
			</div>
		</form>
	</div>
	<div id="dlg-buttons2">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save2()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg2').dialog('close')">取消</a>
	</div>
	
	
</body>
<script type="text/javascript">

$(document).ready(function(){
	getCarport();
	var indate = myformatter('${user.house.owner.indate}');
	$('#indate').html(indate);
});

var url='';
var form='';
function revise1(){
	$('#hometown').val('${user.house.owner.hometown}');
	$('#job').val('${user.house.owner.job}');
	$('#email').val('${user.house.owner.email}');
	$('#tel').val('${user.house.owner.tel}');
	$('#dlg').dialog('open').dialog('setTitle','修改信息');
	url='${pageContext.request.contextPath}/owner/revise.action?ownerId='+'${user.house.owner.ownerId}';
	form='#fm';
}

function revise2() {
	$('#dlg2').dialog('open').dialog('setTitle','修改密码');
	$('#fm2').form('clear');
	url = '${pageContext.request.contextPath}/user/modificationPsw.action';
	form = '#fm2';
}

function save(){
	$(form).form('submit',{
		url: url,
		onSubmit: function(){
			return $(this).form('validate');
		},
		success: function(result){
			var result = eval('('+result+')');
			if (result.success){
				parent.ownerMain.location.reload();
				$.messager.alert('信息',result.message,'info');
			} else {
				$.messager.show({
					title: '错误',
					msg: result.message
				});
			}
		}
	});
}

function save2(){
	$(form).form('submit',{
		url: url,
		onSubmit: function(){
			return $(this).form('validate');
		},
		success: function(result){
			var result = eval('('+result+')');
			if (result.success){
				$('#dlg2').dialog('close');
				$.messager.alert('信息',result.message,'info');
			} else {
				$.messager.show({
					title: '错误',
					msg: result.message
				});
			}
		}
	});
}

function getCarport(){
	$.ajax({
	    url:"${pageContext.request.contextPath}/carport/findByPosition.action",    //请求的url地址
	    dataType:"json",   //返回格式为json
	    async:true,//请求是否异步，默认为异步，这也是ajax重要特性
	    data:{"position":'${user.house.position}'},    //参数值
	    type:"POST",   //请求方式
	    success:function(result){
	        //请求成功时处理
	        if(result.total==0){
	        	$('#carportinfo').html("没有车位");
	        }else{
	        	var info='';
	        	for(var i=0;i<result.total;i++){
	        			info += "<tr><td>"+(i+1)+"</td>"
			         	+"<td>"+result.rows[i].carportPosition+"</td>"
			         	+"<td>"+result.rows[i].area+"</td>"
						+"<td>"+myformatter(result.rows[i].startdate.time)+"</td>"
						+"<td>"+myformatter(result.rows[i].stopdate.time)+"</td>"
						+"<td>"+result.rows[i].carportFee+"</td></tr>";
	        	}
	        	$('#carportinfo').html(info);
	        }
	    },
	    error:function(){
	        //请求出错处理
	        alet('出错')
	    }
	});
}

function myformatter(date){
	if(date==null){
		return null;
	}
	var d = new Date(date);
	var y = d.getFullYear();
	var m = d.getMonth()+1;
	var d = d.getDate();
	return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}

$.extend($.fn.validatebox.defaults.rules, {
	checkNew:{
		validator: function(value, param){
	            if(value=='${user.password}'){
	            	return false;
	            }else{
	            	return true;
	            }
	        },
		message:'新密码不能与原密码相同',
	},
	checkNewAgain:{
		validator: function(value, param){
				var npsw = $('#newPassword').val();
	            if(value!=npsw){
	            	return false;
	            }else{
	            	return true;
	            }
	        },
		message:'两次密码输入不相同',
	}
});
</script>
</html>