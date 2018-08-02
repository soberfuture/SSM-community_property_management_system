<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>物业设备管理</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
	<style type="text/css">
		.fitem{
			margin-top: 10px;
		}
	</style>
</head>
<body style="margin: 0;padding: 0;">
	<table id="dg1" iconCls="icon-building" style="max-height: 340px;"></table>
	<div id="toolbar1">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add1()">添加</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit1()">修改</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove1()">删除</a>
	</div>
	<div id="dlg1" style="padding: 40px 40px;">
		<form id="fm1" method="post">
			<div class="fitem">
				<label>楼房名称:</label>
				<input name="bName" class="easyui-validatebox" required="true" validType="buildingIsExist">
			</div>
			<div style="height: 30px"></div>
			<div class="fitem">
				<label>楼房层数:</label>
				<input name="floorNum" class="easyui-validatebox" required="true" validType="pnum">
			</div>
			<div style="height: 30px"></div>
			<div class="fitem">
				<label>每层户数:</label>
				<input name="houseNum" class="easyui-validatebox" required="true" validType="pnum">
			</div>
		</form>
	</div>
	<div id="dlg-buttons1">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg1').dialog('close')">取消</a>
	</div>
	
	<div id="dlg2" style="padding: 40px 40px;">
		<form id="fm2" method="post">
			<div class="fitem">
				<label>楼房名称:</label>
				<input name="bName" class="easyui-validatebox" editable="false">
			</div>
			<div style="height: 30px"></div>
			<div class="fitem">
				<label>楼房层数:</label>
				<input name="floorNum" class="easyui-validatebox" required="true" validType="pnum">
			</div>
			<div style="height: 30px"></div>
			<div class="fitem">
				<label>每层户数:</label>
				<input name="houseNum" class="easyui-validatebox" required="true" validType="pnum">
			</div>
		</form>
	</div>
	<div id="dlg-buttons2">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg2').dialog('close')">取消</a>
	</div>
	
	
	<table id="dg2" iconCls="icon-carport" style="max-height: 340px;"></table>
	<div id="toolbar2">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add2()">添加</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="edit2()">修改</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="remove2()">删除</a>
	</div>
	<div id="dlg3" style="padding: 40px 40px;">
		<form id="fm3" method="post">
			<div class="fitem">
				<label>车位区域:</label>
				<input name="pregion" class="easyui-validatebox" required="true" validType="parkingIsExist">
			</div>
			<div style="height: 40px"></div>
			<div class="fitem">
				<label>车位数量:</label>
				<input name="pnum" class="easyui-validatebox" required="true" validType="pnum">
			</div>
		</form>
	</div>
	<div id="dlg-buttons3">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg3').dialog('close')">取消</a>
	</div>
	
	<div id="dlg4" style="padding: 40px 40px;">
		<form id="fm4" method="post">
			<div class="fitem">
				<label>车位区域:</label>
				<input name="pregion" class="easyui-validatebox" editable="false">
			</div>
			<div style="height: 40px"></div>
			<div class="fitem">
				<label>车位数量:</label>
				<input name="pnum" class="easyui-validatebox" required="true" validType="pnum">
			</div>
		</form>
	</div>
	<div id="dlg-buttons4">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg4').dialog('close')">取消</a>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	/*easyui datagrid初始化*/
	$('#dg1').datagrid({
	    url:'${pageContext.request.contextPath}/building/findAllBuilding.action',
	    fitColumns:true,
	    rownumbers:true,
	    striped:true,
	    width:'900px',
	    singleSelect:true,
	    title:'楼栋管理',
	    toolbar:'#toolbar1',
	    columns:[[
			{field:'bName',title:'楼栋名称',width:100,align:'center'},
			{field:'floorNum',title:'层数',width:100,align:'center'},
			{field:'houseNum',title:'每层房间数',width:100,align:'center'},
	    ]]
	});
	
	$('#dg2').datagrid({
	    url:'${pageContext.request.contextPath}/parking/findAllParking.action',
	    rownumbers:true,
	    fitColumns:true,
	    striped:true,
	    width:'900px',
	    singleSelect:true,
	    title:'车位区域管理',
	    toolbar:'#toolbar2',
	    columns:[[
			{field:'pregion',title:'车位区域',width:100,align:'center'},
			{field:'pnum',title:'车位数量',width:100,align:'center'},
	    ]]
	});
	
	/*easyui dialog属性设置*/
	$('#dlg1').dialog({
	    width: 400,
	    height: 350,
	    closed: true,
	    cache: false,
	    modal: true,
	    buttons:'#dlg-buttons1'
	});
	
	$('#dlg2').dialog({
	    width: 400,
	    height: 350,
	    closed: true,
	    cache: false,
	    modal: true,
	    buttons:'#dlg-buttons2'
	});
	
	/*easyui dialog属性设置*/
	$('#dlg3').dialog({
	    width: 400,
	    height: 350,
	    closed: true,
	    cache: false,
	    modal: true,
	    buttons:'#dlg-buttons3'
	});
	
	$('#dlg4').dialog({
	    width: 400,
	    height: 350,
	    closed: true,
	    cache: false,
	    modal: true,
	    buttons:'#dlg-buttons4'
	});
	
});


var url;
var form;
function add1(){
	$('#dlg1').dialog('open').dialog('setTitle','新增');
	$('#fm1').form('clear');
	url = '${pageContext.request.contextPath}/building/insert.action';
	form = '#fm1';
}

function edit1(){
	$('#fm2').form('clear');
	var row = $('#dg1').datagrid('getSelected');
	if (row){
		$('#dlg2').dialog('open').dialog('setTitle','编辑');
		$('#fm2').form('load',row);
		url = '${pageContext.request.contextPath}/building/update.action?bid='+row.bid;
		form = '#fm2';
	}else{
		$.messager.show({
			title: '信息',
			msg: '请选择编辑行'
		});
	}
}

function add2(){
	$('#dlg3').dialog('open').dialog('setTitle','新增');
	$('#fm3').form('clear');
	url = '${pageContext.request.contextPath}/parking/insert.action';
	form = '#fm3';
}

function edit2(){
	$('#fm4').form('clear');
	var row = $('#dg2').datagrid('getSelected');
	if (row){
		$('#dlg4').dialog('open').dialog('setTitle','编辑');
		$('#fm4').form('load',row);
		url = '${pageContext.request.contextPath}/parking/update.action?pid='+row.pid;
		form = '#fm4';
	}else{
		$.messager.show({
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
				$('#dlg1').dialog('close');		// close the dialog
				$('#dlg2').dialog('close');
				$('#dlg3').dialog('close');
				$('#dlg4').dialog('close');
				$('#dg1').datagrid('reload');	// reload the user data
				$('#dg2').datagrid('reload');	// reload the user data
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

function remove1(){
	var row = $('#dg1').datagrid('getSelected');
	if (row){
		$.messager.confirm('删除','您确定要删除这一条记录吗?',function(r){
			if (r){
				$.post('${pageContext.request.contextPath}/building/delete.action',{bid:row.bid},function(result){
					if (result.success){
						$('#dg1').datagrid('reload');	// reload the user data
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

function remove2(){
	var row = $('#dg2').datagrid('getSelected');
	if (row){
		$.messager.confirm('删除','您确定要删除这一条记录吗?',function(r){
			if (r){
				$.post('${pageContext.request.contextPath}/parking/delete.action',{pid:row.pid},function(result){
					if (result.success){
						$('#dg2').datagrid('reload');	// reload the user data
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

$.extend($.fn.validatebox.defaults.rules, {
    //楼栋是否存在
    buildingIsExist: {
        validator: function(value, param){
        	var judge = true;
        	$.ajax({
        	    url:"${pageContext.request.contextPath}/building/isExist.action",    //请求的url地址
        	    dataType:"json",   //返回格式为json
        	    async:false,//请求是否异步，默认为异步，这也是ajax重要特性
        	    data:{"bName": value},    //参数值
        	    type:"post",   //请求方式
        	    success:function(result){
        	        //请求成功时处理
        	    	if (result){
    					judge = false;
    				} else {
    					judge = true;
    				}
        	    },
        	    error:function(){
        	        //请求出错处理
        	        console.log('判断是否存在出错！');
        	    }
        	});
            return judge;
        },
        message: "楼栋已存在"
    },
  //车位区域是否存在
    parkingIsExist: {
        validator: function(value, param){
        	var judge = true;
        	$.ajax({
        	    url:"${pageContext.request.contextPath}/parking/isExist.action",    //请求的url地址
        	    dataType:"json",   //返回格式为json
        	    async:false,//请求是否异步，默认为异步，这也是ajax重要特性
        	    data:{"pregion": value},    //参数值
        	    type:"post",   //请求方式
        	    success:function(result){
        	        //请求成功时处理
        	    	if (result){
    					judge = false;
    				} else {
    					judge = true;
    				}
        	    },
        	    error:function(){
        	        //请求出错处理
        	        console.log('判断是否存在出错！');
        	    }
        	});
            return judge;
        },
        message: "该车位区已存在"
    },
});
</script>
</html>