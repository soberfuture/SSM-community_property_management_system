<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>水表管理</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
	
</head>
<body style="margin: 0;padding: 0;">

	<table id="t_water" title="水表管理" iconCls="icon-imeter" class="easyui-datagrid"
		style="width: 100%;" url="${pageContext.request.contextPath}/water/findByPagination.action"
		pagination="true" toolbar="#toolbar_water" rownumbers="true" fitColumns="true" striped="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="position" width="50">物业地址</th> 
				<th field="startdate" data-options="formatter:myformatter" width="50">使用日期</th>
				<th field="price" width="50">单价（元/度）</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar_water">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
		<label>设置全部水费：</label>
		<input id="eprice" name="price" class="easyui-validatebox" required="true" validType="num">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editprice()">设置</a>
		<input class="easyui-searchbox" data-options="prompt:'请输入要搜索的物业地址',menu:'#mm',searcher:doSearch" style="width: 250px;">
		<div id="mm">
			<div data-options="name:'all'">显示所有</div>
			<div data-options="name:'position'">物业地址</div>
		</div>
	</div>
	
	<div id="dlg_water" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons_water">
		<form id="fm_water" method="post" novalidate>
			<div style="height: 20px;"></div>
			<div class="fitem">
				<label>物业地址:</label>
				<input id="position" name="position" required="true">
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
	<div id="dlg-buttons_water">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_water').dialog('close')">取消</a>
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

		function setHouse(){
			$("#position").combobox({
				  url:"${pageContext.request.contextPath}/house/findWaterHouse.action",//获取数据
				  // 向服务器请求的模式 
				  method : "post",
				  editable:false,
				  valueField: 'position',
				  textField: 'position',
			 });
		}
		
		var url;
		function add(){
			$.post('${pageContext.request.contextPath}/house/findWaterHouse.action',function(data){
				if(data==null||data.length==0){
					$.messager.alert('信息','没有要添加的水表','info');
				}else{
					$('#dlg_water').dialog('open').dialog('setTitle','新增');
					$('#fm_water').form('clear');
					setHouse();
					url = '${pageContext.request.contextPath}/water/insertWater.action';
				}
			});
			
		}
		function edit(){
			$('#fm_water').form('clear');
			var row = $('#t_water').datagrid('getSelected');
			if (row){
				$('#dlg_water').dialog('open').dialog('setTitle','编辑');
				$('#fm_water').form('load',row);
				$('#startd').datebox('setValue',myformatter(row.startdate));
				url = '${pageContext.request.contextPath}/water/updateWater.action?waterId='+row.waterId;
			}else{
				$.messager.show({	// show error message
					title: '错误',
					msg: '请选择操作行'
				});
			}
		}
		function save(){
			$('#fm_water').form('submit',{
				url: url,
				onSubmit: function(){
					return $(this).form('validate');
				},
				success: function(result){
					var result = eval('('+result+')');
					if (result.success){
						$('#dlg_water').dialog('close');		// close the dialog
						$('#t_water').datagrid('reload');	// reload the user data
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
				$.post('${pageContext.request.contextPath}/water/editprice.action',{price:price},function(result){
					if (result.success){
						$('#t_water').datagrid('reload');	// reload the user data
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
					msg: '请设置价格'
				});
			}
			
		}
		
		function remove(){
			var row = $('#t_water').datagrid('getSelected');
			if (row){
				$.messager.confirm('删除','您确定要删除这一条记录吗?',function(r){
					if (r){
						$.post('${pageContext.request.contextPath}/water/delWater.action',{waterId:row.waterId},function(result){
							if (result.success){
								$('#t_water').datagrid('reload');	// reload the user data
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
			}else {
				$.messager.show({
					title: '错误',
					msg: result.message
				});
			}
		}
		
		function doSearch(value,name){
			var u;
			if(name == 'all'){
				u = "${pageContext.request.contextPath}/water/findByPagination.action";
			}else{
				u = "${pageContext.request.contextPath}/water/doSearch.action?name="+name+"&value="+value ;
			}
			$('#t_water').datagrid('options').url = u;
			$('#t_water').datagrid('reload');
		}
	</script>
</body>
</html>