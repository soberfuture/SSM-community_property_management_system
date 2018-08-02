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
		var fm;
		function add(){
			$('#addinfo').dialog('open').dialog('setTitle','新增');
			$('#addfm').form('clear');
			$('#sex').combobox('setValue', $('#sex option')[0].value);
			url = '${pageContext.request.contextPath}/owner/addOwner.action';
			fm = '#addfm';
		}
		function edit(){
			$('#addfm').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#chs').css('display','none');
				$('#addinfo').dialog('open').dialog('setTitle','编辑');
				$('#addfm').form('load',row);
				$('#ind').datebox('setValue',myformatter(row.indate));//easyui-datebox专用赋值方法
				url = '${pageContext.request.contextPath}/owner/updateOwner.action?ownerId='+row.ownerId;
				fm = '#addfm';
			}else{
				$.messager.show({
					title:'错误信息',
					msg:'请选中编辑行',
					timeout:5000,
					showType:'slide'
				});
			}
		}
		
		function save(){
			$(fm).form('submit',{
				url: url,
				onSubmit: function(){
					return $(this).form('validate');
				},
				success: function(result){
					var result = eval('('+result+')');
					if (result.success){
						$('#addinfo').dialog('close');		// close the dialog
						$('#paydialog').dialog('close');
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
				error:function(){
					$.messager.show({
						title: '错误',
						msg: result.message
					});
				}
			});
		}
		
		function cancel(){
			$('#addinfo').dialog('close');
		}
		
		function pay(){
			$('#paydialog').form('clear');
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#paydialog').dialog('open').dialog('setTitle','充值');
				url = '${pageContext.request.contextPath}/owner/deposit.action?ownerId='+row.ownerId;
				fm = '#payfm';
			}else{
				$.messager.show({
					title:'错误信息',
					msg:'请选中编辑行',
					timeout:5000,
					showType:'slide'
				});
			}
		}
		
		
		
	</script>
</head>
<body style="margin: 0;padding: 0;">

	<table id="dg" iconCls="icon-people"></table>
	<div id="toolbar">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">新增业主</a> 
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit()">编辑</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="pay()">充值</a>&emsp;
		<label>按物业地址查询:</label>
		<input class="easyui-combobox" id="pst" name="position" style="width:170px" data-options="required:true" />&emsp;&emsp;&emsp;
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="showall()">显示所有</a>
	</div>
	
	<div id="addinfo" style="padding: 20px 30px;">
		<form id="addfm" method="post">
				<div class="fitem">
					<label>业主姓名:</label>
					<input name="ownerName" class="easyui-validatebox" required="true">
				</div>
				<div class="fitem">
					<label>性&emsp;&emsp;别:</label>
					<select class="easyui-combobox" name="sex" id="sex" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 150px;">
						<option value="男">男</option>
						<option value="女">女</option>
					</select>
				</div>
				<div class="fitem">
					<label>籍&emsp;&emsp;贯:</label>
					<input name="hometown" class="easyui-validatebox" required="true">
				</div>
				<div class="fitem">
					<label>工作单位:</label>
					<input name="job" class="easyui-validatebox" >
				</div>
				<div class="fitem">
					<label>邮&emsp;&emsp;箱:</label>
					<input name="email" class="easyui-validatebox" required="true" validType="email">
				</div>
				<div class="fitem">
					<label>身份证号:</label>
					<input name="idcard" class="easyui-validatebox" required="true" validType="IDCard">
				</div>
				<div class="fitem">
					<label>手机号码:</label>
					<input name="tel" class="easyui-validatebox" required="true"  validType="mobile">
				</div>
				<div class="fitem">
					<label>入住日期:</label>
					<input id="ind" name="ind" class="easyui-datebox" required="true">
				</div>
				<div class="fitem" id="chs">
					<label>物业地址:</label>
					<input class="easyui-combobox" id="houseId" name="houseId" style="width:150px" />
					<input id="position" name="position" type="hidden">
				</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width: 90px;" onclick="save()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 90px;" onclick="cancel()">取消</a>
	</div>
	
	<div id="paydialog" style="padding: 30px 20px;">
		<form id="payfm" method="post">
			<div class="fitem">
				<label>充值金额:</label><br><br><br>
				<input name="money" class="easyui-validatebox" required="true" validType="pnum">
			</div>
		</form>
	</div>
	<div id="dlg-buttons2">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="$('#paydialog').dialog('close');">取消</a>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		$('#dg').datagrid({
			title:'业主管理',
			url:'${pageContext.request.contextPath}/owner/findByPagination.action',
			pagination:true,
			striped:true,
			toolbar:'#toolbar',
			rownumbers:true,
			fitColumns:true,
			singleSelect:true,
		    columns:[[
				{field:'ownerName',title:'业主姓名',width:100,align:'center'},
				{field:'sex',title:'性别',width:100,align:'center'},
				{field:'hometown',title:'籍贯',width:100,align:'center'},
				{field:'job',title:'工作',width:100,align:'center'},
				{field:'email',title:'电子邮箱',width:100,align:'center'},
				{field:'idcard',title:'身份证号',width:100,align:'center'},
				{field:'tel',title:'手机号码',width:100,align:'center'},
				{field:'indate',title:'迁入日期',width:100,align:'center',formatter:myformatter},
				{field:'outdate',title:'迁出日期',width:100,align:'center',formatter:myformatter},
				{field:'account',title:'账户',width:100,align:'center',},
		    ]]
		});
		
		$('#dlg').dialog({
		    width: 400,
		    height: 380,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons:'#dlg-buttons',
		});
		
		$('#addinfo').dialog({
		    width: 400,
		    height: 380,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons:'#dlg-buttons',
		});
		
		$('#paydialog').dialog({
		    width: 200,
		    height: 230,
		    closed: true,
		    cache: false,
		    modal: true,
		    buttons:'#dlg-buttons2',
		});
		
		$(".datebox :text").attr("readonly","readonly");
	    queryXzqh();
	    
	});
	
	function queryXzqh(){
		  $("#houseId").combobox({
			  url:"${pageContext.request.contextPath}/house/findHouseByStatus.action?status=售出",//获取数据
			  // 向服务器请求的模式 
			  method : "post",
			  valueField: 'houseId',
			  textField: 'position',
			  onSelect:function(house){
				  $('#position').val(house.position);
			  }
		  });
		  
		  $("#pst").combobox({
			  url:"${pageContext.request.contextPath}/house/findHouseByStatus.action?status=已入住",//获取数据
			  // 向服务器请求的模式 
			  method : "post",
			  valueField: 'houseId',
			  textField: 'position',
			  onSelect:function(house){
				  	var u = '${pageContext.request.contextPath}/owner/findOwner.action?houseId='+house.houseId;
					$('#dg').datagrid('options').url = u;
					$('#dg').datagrid('reload');
			  }
		  });
	 }
	
	function showall(){
		$('#dg').datagrid('options').url = '${pageContext.request.contextPath}/owner/findByPagination.action';
		$('#dg').datagrid('reload');
	}
</script>
</html>