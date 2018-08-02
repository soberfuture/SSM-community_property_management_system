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
		var data;
		function add(){
			$('#dlg').dialog('open').dialog('setTitle','录入收费信息');
			$('#fm').form('clear');
			$('#project').combobox('setValue', $('#project option')[0].value);
			url = '${pageContext.request.contextPath }/charge/insertCharge.action';
		}
		function save(){
			$('#fm').form('submit',{
				url: url,
				onSubmit: function(){
					return $(this).form('validate');
				},
				success: function(result){
					var result = eval('('+result+')');
					if (result.success){
						$('#dlg').dialog('close');		// close the dialog
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
						$.post('${pageContext.request.contextPath }/charge/delChargeList.action',{chargeId:row.chargeId},function(result){
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
			}
		}
	</script>
</head>
<body style="margin: 0;padding: 0;">

	<table id="dg" title="水电气费用管理" iconCls="icon-charge" class="easyui-datagrid"
		style="width: 100%;" url="${pageContext.request.contextPath }/charge/findByPagination.action"
		pagination="true" toolbar="#toolbar" rownumbers="true" fitColumns="true" striped="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="position" width="50">物业地址</th>
				<th field="project" width="50">收费项目</th>
				<th field="way" width="50">收费方式</th>
				<th field="unit" width="50">收费单位</th>
				<th field="used" width="50">用量</th>
				<th field="price" width="50">单价</th>
				<th field="total" width="50">应交总额</th>
				<th field="inperson" width="50">录入人</th>
				<th field="indate" data-options="formatter:myformatter,parser:myparser" width="50">录入日期</th>
				<th field="paydate" data-options="formatter:myformatter,parser:myparser" width="50">缴费日期</th>
				<th field="transactor" width="50">办理人</th>
				<th field="remark" width="50">备注</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">录入缴费信息</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>&emsp;&emsp;&emsp;
		<input class="easyui-searchbox" data-options="prompt:'请输入要搜索的物业地址',menu:'#mm',searcher:doSearch" style="width: 250px;">
		<div id="mm">
			<div data-options="name:'all'">显示所有</div>
			<div data-options="name:'position'">物业地址</div>
			<div data-options="name:'project'">收费项目</div>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width:400px;height:380px;padding:30px 30px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<div class="fitem">
				<label>物业地址:</label>
				<input id="position" name="position" class="easyui-combobox" data-options="required:true,editable:false">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>收费项目:</label>
				<select class="easyui-combobox" name="project" id="project" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 150px;">
					<option value="电费">电费</option>
					<option value="水费">水费</option>
					<option value="天然气费">天然气费</option>
				</select>
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>收费单位:</label>
				<input id="unit" name="unit" class="easyui-validatebox" data-options="editable:false">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label>用&emsp;&emsp;量:</label>
				<input id="used" name="used" class="easyui-validatebox" required="true" validType="num">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$(".datebox :text").attr("readonly","readonly");
	    queryXzqh();
	  });
	
	 function queryXzqh(){
		  $("#position").combobox({
			  url:"${pageContext.request.contextPath}/house/findHouseByStatus.action?status=已入住",//获取数据
			  // 向服务器请求的模式 
			  method : "post",
			  valueField: 'position',
			  textField: 'position',
		  });
	 }
	 
	 
	 $('#project').combobox({
		 onSelect:function(record){
			if(record.value=='电费'){
				$('#unit').val('元/度');
			}
			if(record.value=='水费'){
				$('#unit').val('元/吨');
			}
			if(record.value=='天然气费'){
				$('#unit').val('元/升');
			}
		 }
	 });
	 
	function doSearch(value,name){
		var u;
		if(name == 'all'){
			u = "${pageContext.request.contextPath}/charge/findByPagination.action";
		}else{
			u = "${pageContext.request.contextPath}/charge/doSearch.action?name="+name+"&value="+value ;
		}
		$('#dg').datagrid('options').url = u;
		$('#dg').datagrid('reload');
	}
</script>
</html>