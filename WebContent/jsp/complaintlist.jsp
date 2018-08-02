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
			$('#complaintStatus').combobox('setValue', $('#complaintStatus option')[0].value);
			url = '${pageContext.request.contextPath }/complaint/insertComplaint.action';
			form = '#fm';
		}
		function edit(){
			$('#fm2').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#dlg2').dialog('open').dialog('setTitle','编辑');
				$('#fm2').form('load',row);
				$('#complaintD').datebox('setValue',myformatter(row.complaintDate));//easyui-datebox专用赋值方法
				$('#handled').datebox('setValue',myformatter(row.handledate));
				url = '${pageContext.request.contextPath }/complaint/updateComplaint.action?complaintId='+row.complaintId;
				form = '#fm2';
			}else{
				$.messager.show({	// show error message
					title: '信息',
					msg: '请选择编辑行'
				});
			}
		}
		
		function deal(){
			var row = $('#dg').datagrid('getSelected');
			if (row){
				if(row.complaintStatus=='未处理'){
					$.post('${pageContext.request.contextPath}/complaint/deal.action',{complaintId:row.complaintId},function(result){
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
				}else{
					$.messager.show({	// show error message
						title: '信息',
						msg: '该投诉已处理'
					});
				}
			}else{
				$.messager.show({	// show error message
					title: '信息',
					msg: '请选择处理行'
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
						$.post('${pageContext.request.contextPath }/complaint/delComplaintList.action',{complaintId:row.complaintId},function(result){
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

	<table id="dg" title="投诉管理" iconCls="icon-complaint" class="easyui-datagrid"
		style="width: 100%;" url="${pageContext.request.contextPath }/complaint/findByPagination.action"
		pagination="true" toolbar="#toolbar" rownumbers="true" fitColumns="true" striped="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="complaintDate" data-options="formatter:myformatter,parser:myparser" width="50">投诉日期</th>
				<th field="position" width="50">物业地址</th>
				<th field="tel" width="50">联系电话</th>
				<th field="complaintStatus" width="50">投诉状态</th>
				<th field="handledate" data-options="formatter:myformatter,parser:myparser" width="50">处理日期</th>
				<th field="handler" width="50">处理人</th>
				<th field="content" width="50">投诉内容</th>
				<th field="remark" width="50">备注</th>
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
				<label>联系电话:</label>
				<input name="tel" class="easyui-validatebox" required="true" validType="mobile">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>投诉内容:</label>
				<input name="content" class="easyui-textbox" data-options="multiline:true" height="100px" required="true">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>备&emsp;&emsp;注:</label>
				<input name="remark" class="easyui-validatebox">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	
	<div id="dlg2" class="easyui-dialog" style="width:400px;height:380px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm2" method="post">
			<div class="fitem">
				<label>投诉日期:</label>
				<input id="complaintD" name="complaintD" class="easyui-datebox" required="true">
			</div>
			<div class="fitem">
				<label>物业地址:</label>
				<input name="position" class="easyui-validatebox" required="true" editable="false">
			</div>
			<div class="fitem">
				<label>联系电话:</label>
				<input name="tel" class="easyui-validatebox" required="true" validType="mobile">
			</div>
			<div class="fitem">
				<label>投诉状态:</label>
				<select class="easyui-combobox" name="complaintStatus" id="complaintStatus" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 170px;">
					<option value="已处理">已处理</option>
					<option value="未处理">未处理</option>
				</select>
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
				<label>投诉内容:</label>
				<input name="content" class="easyui-textbox" data-options="multiline:true" height="100px" required="true">
			</div>
			<div class="fitem">
				<label>备&emsp;&emsp;注:</label>
				<input name="remark" class="easyui-validatebox">
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
</script>
</html>