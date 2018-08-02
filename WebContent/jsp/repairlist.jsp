<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
	<script type="text/javascript">
	
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
		
		var url;
		var form;
		function add(){
			$('#dlg').dialog('open').dialog('setTitle','新增');
			$('#fm').form('clear');
			url = '${pageContext.request.contextPath}/repair/insertRepair.action';
			form = '#fm';
		}
		function edit(){
			$('#fm2').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#dlg2').dialog('open').dialog('setTitle','编辑');
				$('#fm2').form('load',row);
				$('#repairD').datebox('setValue',myformatter(row.repairDate));//easyui-datebox专用赋值方法
				$('#handled').datebox('setValue',myformatter(row.handledate));
				url = '${pageContext.request.contextPath}/repair/updateRepair.action?repairId='+row.repairId;
				form = '#fm2';
			}else{
				$.messager.show({	// show error message
					title: '信息',
					msg: '请现在编辑行'
				});
			}
		}
		
		function deal(){
			$('#fm3').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row){
				if(row.situation=="未处理"){
					$('#dlg3').dialog('open').dialog('setTitle','编辑');
					url = '${pageContext.request.contextPath}/repair/deal.action?repairId='+row.repairId;
					form = '#fm3';
				}else{
					$.messager.show({	// show error message
						title: '信息',
						msg: '该报修已处理'
					});
				}
			}else{
				$.messager.show({	// show error message
					title: '信息',
					msg: '请选择删除行'
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
						$('#dlg3').dialog('close');
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
						$.post('${pageContext.request.contextPath}/repair/delRepair.action',{repairId:row.repairId},function(result){
							//console.log(result);
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
			}else{
				$.messager.show({	// show error message
					title: '信息',
					msg: '请选择删除行'
				});
			}
		}
	</script>
</head>
<body style="margin: 0;padding: 0;">

	<table id="dg" title="报修管理" iconCls="icon-repair" class="easyui-datagrid"
		style="width: 100%;" url="${pageContext.request.contextPath}/repair/findByPagination.action"
		pagination="true" toolbar="#toolbar" rownumbers="true" fitColumns="true" striped="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="repairDate" data-options="formatter:myformatter,parser:myparser" width="50">报修日期</th>
				<th field="content" width="50">报修内容</th>
				<th field="position" width="50">物业地址</th>
				<th field="tel" width="50">手机号码</th>
				<th field="handledate" data-options="formatter:myformatter,parser:myparser" width="50">处理日期</th>
				<th field="handler" width="50">处理人</th>
				<th field="servicecost" width="50">服务费用</th>
				<th field="mattercost"  width="50">物料费用</th>
				<th field="situation" width="50">报修状态</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-deal" plain="true" onclick="deal()">处理</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width:400px;height:380px;padding:30px 30px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<div class="fitem">
				<label>物业地址:</label>
				<input id="position" name="position" class="easyui-combobox" editable="false" required="true">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>手机号码:</label>
				<input name="tel" class="easyui-validatebox" required="true" validType="mobile">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>报修内容:</label>
				<input name="content" class="easyui-validatebox" required="true">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	
	<div id="dlg2" class="easyui-dialog" style="width:400px;height:380px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm2" method="post" novalidate>
			<div class="fitem">
				<label>报修日期:</label>
				<input id="repairD" name="repairD" class="easyui-datebox" required="true">
			</div>
			<div class="fitem">
				<label>报修内容:</label>
				<input name="content" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>物业地址:</label>
				<input name="position" class="easyui-validatebox" required="true" editable="false">
			</div>
			<div class="fitem">
				<label>手机号码:</label>
				<input name="tel" class="easyui-validatebox" required="true" validType="mobile">
			</div>
			<div class="fitem">
				<label>处理日期:</label>
				<input id="handled" name="handled" class="easyui-datebox">
			</div>
			<div class="fitem">
				<label>处理人员:</label>
				<input name="handler" class="easyui-validatebox">
			</div>
			<div class="fitem">
				<label>服务费用:</label>
				<input name="servicecost" class="easyui-validatebox" validType="num">
			</div>
			<div class="fitem">
				<label>物料费用:</label>
				<input name="mattercost" class="easyui-validatebox" validType="num">
			</div>
			<div class="fitem">
				<label>报修状态:</label>
				<input name="situation" class="easyui-validatebox" required="true">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg2').dialog('close')">取消</a>
	</div>
	
	<div id="dlg3" class="easyui-dialog" style="width:400px;height:380px;padding:30px 30px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm3" method="post" novalidate>
			<div class="fitem">
				<label>处理人员:</label>
				<input name="handler" class="easyui-validatebox" required="true">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>服务费用:</label>
				<input name="servicecost" class="easyui-validatebox" required="true" validType="num">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>物料费用:</label>
				<input name="mattercost" class="easyui-validatebox" required="true" validType="num">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg3').dialog('close')">取消</a>
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
</script>
</html>