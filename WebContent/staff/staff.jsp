<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${adminuser==null }">
	<c:redirect url="../jspuser/login.jsp"></c:redirect>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" type="image/x-icon" href="../images/home.png" media="screen" />
    <title>工作人员页面</title>
    <jsp:include page="../jsp/default.jsp" flush="true"></jsp:include>
    <style type="text/css">
   	body {
		margin: 10px;
		padding: 0;
	}
	.easyui-accordion a{
		text-decoration: none;
		width: 100%;
	}
	ul {
		margin:0;
		padding:0;
		list-style: none;
	}
	li {
		text-align:left;
		width:196px;
		height: 27px;
	}
    </style>
</head>
<body>
    <div class="easyui-layout" style="width:100%;height:900px;">
        <div data-options="region:'north'" style="height:50px">
        	<h3 style="float: left;">工作人员界面</h3>
        	<div style="text-align: right;margin-top: 10px;">
        		<span><img src="../images/man.png">&emsp;${adminuser.username}</span>&emsp;
        		<a style="text-decoration: none;color: black;" href="${pageContext.request.contextPath}/user/exit.action">退出</a>&emsp;
        	</div>
        </div>
        <div data-options="region:'south',split:true" style="height:50px;"></div>
        <div data-options="region:'west',split:true" title="导航栏" style="width:210px;">
        	<div class="easyui-accordion" style="width:200px;" fit="true" collapsible="true">
        		<div title="资产管理" data-options="iconCls:'icon-data'">
		            <ul>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="BuildingAndParking.jsp">楼栋和车位管理</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="houselist.jsp">房产管理</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="carportlist.jsp">车位管理</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="equipmentlist.jsp">物业设备管理</a></li>
		            </ul>
		        </div>
		        <div title="业主管理" data-options="iconCls:'icon-people'">
		        	<ul>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="ownerlist.jsp">业主管理</a></li>
		            </ul>
		        </div>
		        <div title="仪表管理" data-options="iconCls:'icon-meter'">
		        	<ul>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="waterlist.jsp">水表管理</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="electricitylist.jsp">电表管理</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="gaslist.jsp">天然气表管理</a></li>
		            </ul>
		        </div>
		        <div title="收费管理" data-options="iconCls:'icon-charge'">
		            <ul>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="chargelist.jsp">水电气费管理</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="propertyfee.jsp">物业收费管理</a></li>
		            </ul>
		        </div>
		        
		        <div title="事务处理" data-options="iconCls:'icon-transaction'">
		            <ul>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="notice.jsp">通告管理</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="complaintlist.jsp">业主投诉管理</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="repairlist.jsp">业主报修管理</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="maintenance.jsp">设备维修管理</a></li>
		            </ul>
		        </div>
		        <div title="物业报表" data-options="iconCls:'icon-statistics'">
		            <ul>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="stacomplaint.jsp">业主投诉报表</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="starepair.jsp">业主报修报表</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="stafee.jsp">收费统计报表</a></li>
		            	<li><a href="javascript:void(0)" class="easyui-linkbutton" data-href="stamtn.jsp">设备维修报表</a></li>
		            </ul>
		        </div>
		    </div>
        </div>
        <div data-options="region:'center',title:'主页面',iconCls:'icon-ok'">
            <div id="tt" class="easyui-tabs" fit="true">
			    <div title="日常管理" style="padding:20px;display:none;">
					<jsp:include page="daily.jsp" flush="true"></jsp:include>
			    </div>
			</div>
        </div>
    </div>
 
</body>
<script type="text/javascript">
	$('.easyui-accordion a').click(function(){
		$('.easyui-accordion a').removeClass('easyui-linkbutton c3');
		$(this).addClass('easyui-linkbutton c3');
		var t = $(this).text();
		var href = '../jsp/'+$(this).data('href');
		if($('#tt').tabs('exists',t)){
			$('#tt').tabs('select',t);
		}else{
			$('#tt').tabs('add',{
				title: t,
				selected: true,
				closable:true,
				content:'<iframe scrolling="auto" src="'+href+'" frameborder="0" style="width:100%;height:100%;"></iframe>',
			});
		}
	});
	
	$('#tt').tabs({
		onSelect:function(title){
					if(title=='日常管理'){
						console.log('日常管理');
						queryXzqh();
					}
				}
	});
	
</script>
</html>