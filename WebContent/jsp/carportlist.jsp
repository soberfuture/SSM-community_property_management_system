<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>车位管理</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
	<script type="text/javascript">
	
		function myformatter(date){
			if(date==null||date==''){
				return '';
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
		
		var url;
		var form;
		function add(){
			$('#dlg').dialog('open').dialog('setTitle','新增');
			$('#fm').form('clear');
			$('#status').combobox('setValue', $('#status option')[0].value);
			$('#pregion').combobox({
			    url:'${pageContext.request.contextPath}/parking/findAll.action',
			    valueField:'pregion',
			    textField:'pregion',
			    width:'70px',
			    panelHeight:'auto',
			    panelMaxHeight:'150px',
			    editable:false,
			    onSelect:function(result){
			    	$('#pnum').combobox('setValue','');
			    	$('#carportPosition').val('');
			    	var fln = [];
			    	for(var i=1;i<=result.pnum;i++){
			    		if(i.toString().length==1){
			    			i = '00'+ i;
			    		}
			    		if(i.toString().length==2){
			    			i = '0'+ i;
			    		}
			    		fln.push({'value':i,'text':i+'号'});
			    	}
			    	$("#pnum").combobox("loadData", fln);
			    }
			});
			url = '${pageContext.request.contextPath}/carport/insertCarport.action';
			form = '#fm';
		}
		function edit(){
			$('#fm2').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#dlg2').dialog('open').dialog('setTitle','编辑');
				$('#fm2').form('load',row);
				$('#startd').datebox('setValue',myformatter(row.startdate));//easyui-datebox专用赋值方法
				$('#stopd').datebox('setValue',myformatter(row.stopdate));
				url = '${pageContext.request.contextPath}/carport/updateCarport.action?carportId='+row.carportId;
				form = '#fm2';
			}else{
				$.messager.show({	// show error message
					title: '信息',
					msg: '请选择编辑行'
				});
			}
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
						$('#dlg').dialog('close');		// close the dialog
						$('#dlg2').dialog('close');
						$('#dg').datagrid('reload');	// reload the user data
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
				}
			});
		}
		function remove(){
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$.messager.confirm('删除','您确定要删除这一条记录吗?',function(r){
					if (r){
						$.post('${pageContext.request.contextPath}/carport/delCarportList.action',{carportId:row.carportId},function(result){
							if (result.success){
								$('#dg').datagrid('reload');	// reload the user data
								$.messager.show({	// show error message
									title: '成功',
									msg: result.message
								});
							} else {
								$.messager.show({	// show error message
									title: '错误',
									msg: result.message
								});
							}
						},'json');
					}
				});
			}
		}
	</script>
</head>
<body style="margin: 0;padding: 0;">

	<table id="dg" title="车位管理" iconCls="icon-carport" class="easyui-datagrid"
		style="width: 100%;" url="${pageContext.request.contextPath}/carport/findByPagination.action"
		pagination="true" toolbar="#toolbar" rownumbers="true" fitColumns="true" striped="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="carportPosition" width="50">车位位置</th>
				<th field="area" width="50">车位面积</th>
				<th field="status" width="50">车位状态</th>
				<th field="position" width="50">物业编号</th>
				<th field="startdate" data-options="formatter:myformatter,parser:myparser" width="50">开始日期</th>
				<th field="stopdate" data-options="formatter:myformatter,parser:myparser" width="50">截止日期</th>
				<th field="carportFee" width="50">费用</th>
				<th field="cfee" width="50">缴费信息</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width:400px;height:320px;padding:30px 30px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<div class="fitem">
				<label>车位区域:</label>
				<input id="pregion">&emsp;
				<label>车位号:</label>
				<input class="easyui-combobox" name="pnum" id="pnum" data-options="editable:false,panelHeight:'auto',panelMaxHeight:'150px'" style="width: 70px;">&emsp;
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>车位位置:</label>
				<input id="carportPosition" name="carportPosition" class="easyui-validatebox" editable="false">&nbsp;<span id="pError" style="color: red;"></span>
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>面&emsp;&emsp;积:</label>
				<input name="area" class="easyui-validatebox" required="true" validType="num">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>是否使用:</label>
				<select class="easyui-combobox" name="status" id="status" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 150px;">
					<option value="未使用">未使用</option>
				</select>
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a id="save" href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	
	<div id="dlg2" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm2" method="post">
			<div class="fitem">
				<label>车位位置:</label>
				<input name="carportPosition" class="easyui-validatebox" editable="false">
			</div>
			<div class="fitem">
				<label>物业地址:</label>
				<input id="position" name="position" class="easyui-combobox" editable="false">
			</div>
			<div class="fitem">
				<label>开始时间:</label>
				<input id="startd" name="startd" class="easyui-datebox">
			</div>
			<div class="fitem">
				<label>截止时间:</label>
				<input id="stopd" name="stopd" class="easyui-datebox">
			</div>
			<div class="fitem">
				<label>面&emsp;&emsp;积:</label>
				<input name="area" class="easyui-validatebox" required="true" validType="num">
			</div>
			<div class="fitem">
				<label>费&emsp;&emsp;用:</label>
				<input name="carportFee" class="easyui-validatebox" required="true" validType="num">
			</div>
			<div class="fitem">
				<label>是否使用:</label>
				<select class="easyui-combobox" name="status" id="status" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 150px;">
					<option value="未使用">未使用</option>
					<option value="已使用">已使用</option>
				</select>
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg2').dialog('close')">取消</a>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$(".datebox :text").attr("readonly","readonly");
    queryXzqh();
 });

  function queryXzqh(){
	  $('#position').combobox({
		  url:'${pageContext.request.contextPath}/house/findHouseByStatus.action?status=已入住',//获取数据
		  // 向服务器请求的模式 
		  method : 'post',
		  editable:false,
		  valueField: 'position',
		  textField: 'position',
	 });
  }

  $('#pnum').combobox({
	  onSelect:function(result){
		  var cposition = '';
		  cposition = $('#pregion').val()+result.value;
		  $('#carportPosition').val(cposition);
		  isExist(cposition);
	  }
  });
  
  function isExist(cposition){
		$.post('${pageContext.request.contextPath}/carport/carportExist.action',{carportPosition:cposition},function(result){
			if(result){
				$('#pError').html('车位已存在');
				$('#save').linkbutton('disable');
			}else{
				$('#pError').html('');
				$('#save').linkbutton('enable');
			}
		},'json');
	}
</script>
</html>