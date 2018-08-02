<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>个人缴费</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
</head>
<body style="margin: 0;padding: 0;">
	<table id="dg" title="水电气管理" class="easyui-datagrid"
		style="width: 100%;min-height: 100px;" url="${pageContext.request.contextPath}/charge/findByPositionAndFeeState.action?position=${user.house.position}"
		toolbar="#toolbar" rownumbers="true" fitColumns="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="position" width="50">物业地址</th>
				<th field="project" width="50">收费项目</th>
				<th field="way" width="50">收费方式</th>
				<th field="unit" width="50">收费单位</th>
				<th field="used" width="50">用量</th>
				<th field="price" width="50">单价</th>
				<th field="total" data-options="formatter:addtools" width="50">应交金额</th>
				<th field="indate" data-options="formatter:myformatter,parser:myparser" width="50">录入日期</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-fee" plain="true" onclick="recharge()">充值</a> 
	</div>
	<div id="dlg" class="easyui-dialog" style="width:300px;height:150px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<div style="height: 20px;"></div>
			<div class="fitem">
				<label>金额:</label>
				<input name="money" class="easyui-validatebox" required="true" validType="pnum">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#dlg').dialog('close');">取消</a>
	</div>
	
	<table id="dg2" title="其他费用" class="easyui-datagrid" url="${pageContext.request.contextPath}/propertyFee/findByPositionAndFeeState.action?position=${user.house.position}"
		style="width: 100%;min-height: 100px;max-height: 250px;" rownumbers="true" fitColumns="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="position" width="50">物业地址</th>
				<th field="way" width="50">缴费状态</th>
				<th field="project" width="50">收费项目</th>
				<th field="total" data-options="formatter:addtools" width="50">应收总额</th>
				<th field="inputdate" data-options="formatter:myformatter,parser:myparser" width="50">录入日期</th>
			</tr>
		</thead>
	</table>
	<div style="height: 30px;"></div>
	<div>
		<label>应交总额：</label><span id="totalAmount"></span>
	</div>
	<a href="javascript:;" style="margin-left: 40%;margin-top: 20px;" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="payCost()">缴费</a>
</body>
<script type="text/javascript">

$(function(){
	var fid = getfid();
	var cid = getcid();
	if(fid==''&&cid==''){
		$('#totalAmount').html(0);
	}
});

var total=0;
function addtools(value,row,index){
	total +=value;
	$('#totalAmount').html(total);
	return value;
}

function myformatter(date){
	if(date==null){
		return null;
	}
	var o = new Object(date);//必须先接收到object才能调用.time
	var d = new Date(o.time);
	var y = d.getFullYear();
	var m = d.getMonth()+1;
	var d = d.getDate();
	return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}
function myparser(s){
	if (!s) return new Date();
	var ss = (s.split('-'));
	var y = parseInt(ss[0],10);
	var m = parseInt(ss[1],10);
	var d = parseInt(ss[2],10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
		return new Date(y,m-1,d);
	} else {
		return new Date();
	}
}

function getfid(){
	var row = $('#dg2').datagrid('getData');
	var fid = "";
	for(var i=0;i<row.total;i++){
		if(i==0){
			fid +=row.rows[i].feeId;
		}else{
			fid += " "+ row.rows[i].feeId;
		}
	}
	return fid;
}

function getcid(){
	var row = $('#dg').datagrid('getData');
	var cid = "";
	for(var i=0;i<row.total;i++){
		if(i==0){
			cid +=row.rows[i].chargeId;
		}else{
			cid += " "+ row.rows[i].chargeId;
		}
	}
	return cid;
}

function payCost(){
	var fid=getfid();
	var cid=getcid();
	if (cid==''&&fid=='') {
		$.messager.show({	// show error message
			title: '信息',
			msg: '没有要缴纳的费用'
		});
	} else {		
		$.messager.confirm('缴费','您确定要完成缴费吗?',function(r){
			if(r){
				$.post(
					'${pageContext.request.contextPath}/charge/paymentOnline.action',
					{
						cid:cid,
						fid:fid
					},
					function(data){
						if(data.success){
							$('#balance', window.parent.document).html(data.balance);
							$('#totalAmount').html('0');
							$('#dg').datagrid('reload');
							$('#dg2').datagrid('reload');
							$.messager.show({	// show error message
								title: '信息',
								msg: data.message
							});
						}else{
							$.messager.show({	// show error message
								title: '信息',
								msg: data.message
							});
						}
					}
				);
			}
		});
	}
}

function recharge(){
	$('#dlg').dialog('open').dialog('setTitle','充值');
	$('#fm').form('clear');
}

function save(){
	$('#fm').form('submit',{
		url: '${pageContext.request.contextPath}/owner/deposit.action?ownerId='+'${user.house.ownerId}',
		onSubmit: function(){
			return $(this).form('validate');
		},
		success: function(result){
			var result = eval('('+result+')');
			if (result.success){
				$('#dlg').dialog('close');		// close the dialog
				window.parent.balance();
				$.messager.show({	// show error message
					title: '成功',
					msg: result.message
				});
			} else {
				$.messager.show({
					title: '错误',
					msg: result.message
				});
			}
		},
		error: function(){
			$.messager.show({
				title: '错误',
				msg: '出错'
			});
		}
	});
}
</script>
</html>