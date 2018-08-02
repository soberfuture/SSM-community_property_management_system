<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
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
			$('#building').combobox({
			    url:'${pageContext.request.contextPath}/building/findAll.action',
			    valueField:'bName',
			    textField:'bName',
			    width:'50px',
			    panelHeight:'auto',
			    panelMaxHeight:'150px',
			    editable:false,
			    onSelect:function(result){
			    	$('#floorNum').combobox('setValue','');
			    	$('#houseNum').combobox('setValue','');
			    	$('#position').val('');
			    	var fln = [];
			    	for(var i=1;i<=result.floorNum;i++){
			    		if(i.toString().length==1){
			    			i = '0'+ i;
			    		}
			    		fln.push({'value':i,'text':i+'层'});
			    	}
			    	$("#floorNum").combobox("loadData", fln);
			    	var hsn = [];
			    	for(var i=1;i<=result.houseNum;i++){
			    		if(i.toString().length==1){
			    			i = '0'+ i;
			    		}
			    		hsn.push({'value':i,'text':i+'号'});
			    	}
			    	$("#houseNum").combobox("loadData", hsn);
			    }
			});
			$('#workoff').combobox('setValue', $('#workoff option')[0].value);
			url = '${pageContext.request.contextPath}/house/insertHouse.action';
			form = '#fm';
		}	
		
		function edit(){
			$('#fm2').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#dlg2').dialog('open').dialog('setTitle','编辑');
				$('#fm2').form('load',row);
				url = '${pageContext.request.contextPath}/house/updateHouse.action?houseId='+row.houseId;
				form = '#fm2';
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
				},
				error: function(){
					$.messager.show({
						title: '错误',
						msg: '出错'
					});
				}
			});
		}
		function remove(){
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$.messager.confirm('删除','您确定要删除这一条记录吗?',function(r){
					if (r){
						console.log(row.carportId);
						$.post('${pageContext.request.contextPath}/house/delHouseList.action',{houseId:row.houseId},function(result){
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
		
		function cancel(){
			$('#dlg').dialog('close');
			$('#dlg2').dialog('close');
		}
	</script>
</head>
<body style="margin: 0;padding: 0;">

	<table id="dg" title="房产管理" iconCls="icon-building" class="easyui-datagrid"
		style="width: 100%;" url="${pageContext.request.contextPath}/house/findByPagination.action"
		pagination="true" toolbar="#toolbar" rownumbers="true" fitColumns="true" striped="true"
		singleSelect="true">
		<thead>
			<tr>
				<th field="position" width="50">物业地址</th>
				<th field="area" width="50">面积</th>
				<th field="usedarea" width="50">使用面积</th>
				<th field="houseType" width="50">房型</th>
				<th field="workoff" width="50">是否售出</th>
				<th field="ownerId" width="50">业主编号</th>
				<th field="remark" width="50">备注</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove()">删除</a>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width:400px;height:380px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<div class="fitem">
				<label>楼栋:</label>
				<input id="building">&emsp;
				<label>楼层:</label>
				<input class="easyui-combobox" name="floorNum" id="floorNum" data-options="editable:false,panelHeight:'auto',panelMaxHeight:'150px'" style="width: 60px;">&emsp;
				<label>房间号:</label>
				<input class="easyui-combobox" name="houseNum" id="houseNum" data-options="editable:false,panelHeight:'auto',panelMaxHeight:'150px'" style="width: 60px;">
			</div><br>
			<div class="fitem">
				<label>物业地址:</label>
				<input id="position" name="position" class="easyui-validatebox" editable="false"> &nbsp; <span id="pError" style="color: red;"></span>
			</div><br>
			<div class="fitem">
				<label>面&emsp;&emsp;积:</label>
				<input name="area" class="easyui-validatebox" required="true" validType="num">
			</div><br>
			<div class="fitem">
				<label>使用面积:</label>
				<input name="usedarea" class="easyui-validatebox" required="true" validType="num">
			</div><br>
			<div class="fitem">
				<label>房&emsp;&emsp;型:</label>
				<input name="houseType" class="easyui-validatebox" required="true">
			</div><br>
			<div class="fitem">
				<label>是否售出:</label>
				<select class="easyui-combobox" name="workoff" id="workoff" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 150px;">
					<option value="售出">售出</option>
				</select>
			</div><br>
			<div class="fitem">
				<label>备&emsp;&emsp;注:</label>
				<input name="remark" class="easyui-validatebox">
			</div><br>
		</form>
	</div>
	<div id="dlg-buttons">
		<a id="save" href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()">取消</a>
	</div>
	
	<div id="dlg2" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm2" method="post">
			<div class="fitem">
				<label>物业地址:</label>
				<input name="position" class="easyui-validatebox" required="true" editable="false">
			</div>
			<div class="fitem">
				<label>面&emsp;&emsp;积:</label>
				<input name="area" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>使用面积:</label>
				<input name="usedarea" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>房&emsp;&emsp;型:</label>
				<input name="houseType" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>是否售出:</label>
				<select class="easyui-combobox" name="workoff" id="workoff" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 150px;">
					<option value="售出">售出</option>
				</select>
			</div>
			<div class="fitem">
				<label>备&emsp;&emsp;注:</label>
				<input name="remark" class="easyui-validatebox">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()">取消</a>
	</div>
</body>
<script type="text/javascript">
	$('#floorNum').combobox({
		onSelect:function(result){
			var houseNum = $('#houseNum').val();
			if(houseNum!=''){
				var position = '';
		    	position = $('#building').val()+result.value+houseNum;
		    	$('#position').val(position);
		    	isExist(position);
			}
	    }
	});
	
	$('#houseNum').combobox({
		onSelect:function(result){
			var position = '';
	    	position = $('#building').val()+$('#floorNum').val()+result.value;
	    	$('#position').val(position);
	    	isExist(position);
	    }
	});
	
	function isExist(position){
		$.post('${pageContext.request.contextPath}/house/isExist.action',{position:position},function(result){
			if(result){
				$('#pError').html('房间已存在');
				$('#save').linkbutton('disable');
			}else{
				$('#pError').html('');
				$('#save').linkbutton('enable');
			}
		},'json');
	}
	
</script>
</html>