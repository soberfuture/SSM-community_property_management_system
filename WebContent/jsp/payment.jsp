<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>费用缴纳</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
	<script type="text/javascript">
	
		var total=0;
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
		
		function totalPrice(value,row,index){
			var tt = row.price*row.used;
			total += tt;
			$('#total').html(total);
			return tt;
		}
		
		function addtotal(value,row,index){
			total +=value;
			$('#total').html(total);
			return value;
		}
	</script>
	<style type="text/css">
		.bar{
			float:left;
			width:100%;
			height:30px;
		}
		.fee{
			float:left;
			width: 100%;
			background-color: yellow;
		}
	</style>
</head>
<body style="margin: 0;padding: 0;">
	
	<div class="bar">
		<label>缴费房间：</label>
		<input class="easyui-combobox" id="position" name="position" data-options="required:true" />
	</div>
	<div class="fee">
		<table id="dg1" title="水电气费" class="easyui-datagrid"
			style="width: 100%;max-height: 250px;" toolbar="#toolbar" rownumbers="true" fitColumns="true" striped="true"
			singleSelect="true">
			<thead>
				<tr>
					<th field="position" width="50">物业地址</th>
					<th field="project" width="50">收费项目</th>
					<th field="way" width="50">收费方式</th>
					<th field="unit" width="50">收费单位</th>
					<th field="used" width="50">用量</th>
					<th field="price" width="50">单价</th>
					<th field="tota" data-options="formatter:totalPrice" width="50">应交金额</th>
					<th field="indate" data-options="formatter:myformatter,parser:myparser" width="50">录入日期</th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="fee">
		<table id="dg2" title="其他费用" class="easyui-datagrid"
			style="width: 100%;max-height: 250px;" toolbar="#toolbar" rownumbers="true" fitColumns="true"
			singleSelect="true">
			<thead>
				<tr>
					<th field="position" width="50">物业地址</th>
					<th field="way" width="50">缴费状态</th>
					<th field="project" width="50">收费项目</th>
					<th field="total" data-options="formatter:addtotal" width="50">应收总额</th>
					<th field="inputdate" data-options="formatter:myformatter,parser:myparser" width="50">录入日期</th>
				</tr>
			</thead>
		</table>
	</div>
	<div style="width: 100%;height: 30px;float: left;">
		<label>总额：</label>
		<span id="total"></span>
	</div>
	<div id="jiaofei" style="width: 100%;height: 30px;float: left;margin-left: 40%;display: none;">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="pay()">缴费</a>
	</div>
</body>
<script type="text/javascript">
	var position;
	$(document).ready(function(){
	    queryXzqh();
	  });
	
	  function queryXzqh(){
		  $("#position").combobox({
			  url:"${pageContext.request.contextPath}/house/findAllHouse.action",//获取数据
			  // 向服务器请求的模式 
			  method : "post",
			  valueField: 'position',
			  textField: 'position',
			  onSelect:function(house){
				  position = house.position;
				  total = 0;
				  ur1 = "${pageContext.request.contextPath}/charge/findByPositionAndFeeState.action";
				  $('#dg1').datagrid('options').url = ur1;
				  $('#dg1').datagrid('options').queryParams = {
				        'position' : house.position,
				    };
				  $('#dg1').datagrid('reload');
				  
				  ur2 = "${pageContext.request.contextPath}/propertyFee/findByPositionAndFeeState.action";
				  $('#dg2').datagrid('options').url = ur2;
				  $('#dg2').datagrid('options').queryParams = {
				        'position' : house.position,
				    };
				  $('#dg2').datagrid('reload');
				  
				  $("#jiaofei").css('display','block');
			  }
		  });
	  }
	  
	  function pay(){
			var row1 = $('#dg1').datagrid('getData');
			var row2 = $('#dg2').datagrid('getData');
			var cid = "";
			var fid = "";
			for(var i=0;i<row1.total;i++){
				if(i==0){
					cid +=row1.rows[i].chargeId;
				}else{
					cid += " "+ row1.rows[i].chargeId;
				}
			}
			for(var i=0;i<row2.total;i++){
				if(i==0){
					fid +=row2.rows[i].feeId;
				}else{
					fid += " "+ row2.rows[i].feeId;
				}
			}
			if (cid==''&&fid=='') {
				$.messager.show({	// show error message
					title: '信息',
					msg: '没有要缴纳的费用'
				});
			} else {		
				$.messager.confirm('缴费','您确定要完成缴费吗?',function(r){
					if(r){
						$.post(
								'${pageContext.request.contextPath}/charge/paymentOffline.action',
								{
									cid:cid,
									fid:fid
								},
								function(data){
									if(data.success){
										$('#total').html('0');
										$('#dg1').datagrid('reload');
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
</script>
</html>