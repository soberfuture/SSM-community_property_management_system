<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
	
</head>
<body style="margin: 0;padding: 0;">

	<table id="dg" title="电表管理" iconCls="icon-imeter" class="easyui-datagrid"
		style="width: 100%;" url="${pageContext.request.contextPath}/electricity/findByPagination.action"
		pagination="true" toolbar="#toolbar" rownumbers="true" fitColumns="true" striped="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="position" width="50">物业地址</th>
				<th field="startdate" data-options="formatter:myformatter,parser:myparser" width="50">使用日期</th>
				<th field="price" width="50">单价（元/度）</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>&emsp;&emsp;
		<label>设置全部电费：</label>
		<input id="eprice" name="price" class="easyui-validatebox" required="true" validType="num">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editprice()">设置</a>
		<input class="easyui-searchbox" data-options="prompt:'请输入要搜索的物业地址',menu:'#mm',searcher:doSearch" style="width: 250px;">
		<div id="mm">
			<div data-options="name:'all'">显示所有</div>
			<div data-options="name:'position'">物业地址</div>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<div style="height: 20px;"></div>
			<div class="fitem">
				<label>物业地址:</label>
				<input id="position" name="position" class="easyui-validatebox" required="true">
			</div>
			<div style="height: 20px;"></div>
			<div class="fitem">
				<label>启用日期:</label>
				<input id="startd" name="startd" class="easyui-datebox" required="true">
			</div>
			<div style="height: 20px;"></div>
			<div class="fitem">
				<label>单&emsp;&emsp;价:</label>
				<input name="price" class="easyui-validatebox" required="true" validType="num">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	<script type="text/javascript">
	
		function myformatter(date){
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
		
		function setHouse(){
			$("#position").combobox({
				  url:"${pageContext.request.contextPath}/house/findEleHouse.action",//获取数据
				  // 向服务器请求的模式 
				  method : "post",
				  editable:false,
				  valueField: 'position',
				  textField: 'position',
			 });
		}
		
		var url;
		function add(){
			$.post('${pageContext.request.contextPath}/house/findEleHouse.action',function(data){
				if(data==null||data.length==0){
					$.messager.alert('信息','没有要添加的电表','info');
				}else{
					$('#dlg').dialog('open').dialog('setTitle','新增');
					$('#fm').form('clear');
					setHouse();
					url = '${pageContext.request.contextPath}/electricity/insertElectricity.action';
				}
			});
		}
		function edit(){
			$('#fm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#dlg').dialog('open').dialog('setTitle','编辑');
				$('#fm').form('load',row);
				$('#startd').datebox('setValue',myformatter(row.startdate));
				url = '${pageContext.request.contextPath}/electricity/updateElectricity.action?electricityId='+row.electricityId;
			}else{
				$.messager.show({	// show error message
					title: '错误',
					msg: '请选择操作行'
				});
			}
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
		
		function editprice(){
			var price = $('#eprice').val();
			if(price!=''){
				$.post('${pageContext.request.contextPath}/electricity/editprice.action',{price:price},function(result){
					if (result.success){
						$('#dg').datagrid('reload');	// reload the user data
						$.messager.show({	// show error message
							title: '设置成功',
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
					title: '错误',
					msg: '请填写价格'
				});
			}
		}
		
		function remove(){
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$.messager.confirm('删除','您确定要删除这一条记录吗?',function(r){
					if (r){
						$.post('${pageContext.request.contextPath}/electricity/delElectricity.action',{electricityId:row.electricityId},function(result){
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
					title: '错误',
					msg: '请选择操作行'
				});
			}
		}
		
		function doSearch(value,name){
			var u;
			if(name == 'all'){
				u = "${pageContext.request.contextPath}/electricity/findByPagination.action";
			}else{
				u = "${pageContext.request.contextPath}/electricity/doSearch.action?name="+name+"&value="+value ;
			}
			$('#dg').datagrid('options').url = u;
			$('#dg').datagrid('reload');
		}
	</script>
</body>
</html>