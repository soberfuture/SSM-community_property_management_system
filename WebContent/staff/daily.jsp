<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
    queryXzqh();
    
    $('#startdate').datebox();
    
    $('#stopdate').datebox();
    
    $('#ind').datebox({
    	required:true,
    });
    $('#t_feeWEG').datagrid({
	    fitColumns:true,
	    rownumbers:true,
	    striped:true,
	    singleSelect:true,
	    title:'水电气费',
	    toolbar:'#toolbar_feeWEG',
	    columns:[[
					{field:'position',title:'物业地址',width:100,align:'center'},
					{field:'project',title:'收费项目',width:100,align:'center'},
					{field:'way',title:'缴费状态',width:100,align:'center'},
					{field:'unit',title:'收费单位',width:100,align:'center'},
					{field:'used',title:'用量',width:100,align:'center'},
					{field:'price',title:'单价',width:100,align:'center'},
					{field:'total',title:'应交总额',width:100,formatter:add,align:'center'},
					{field:'indate',title:'录入日期',width:100,formatter:myformatter,align:'center'},
				]]
	});
    
    $('#t_feeP').datagrid({
	    fitColumns:true,
	    striped:true,
	    rownumbers:true,
	    singleSelect:true,
	    title:'其他费用',
	    toolbar:'#toolbar_feeP',
	    columns:[[
					{field:'position',title:'物业地址',width:100,align:'center'},
					{field:'project',title:'收费项目',width:100,align:'center'},
					{field:'way',title:'缴费状态',width:100,align:'center'},
					{field:'total',title:'应交总额',width:100,formatter:add,align:'center'},
					{field:'inputdate',title:'录入日期',width:100,formatter:myformatter,align:'center'},
				]]
	});
    
    $('#t_feeRecord').datagrid({
	    fitColumns:true,
	    rownumbers:true,
	    striped:true,
	    singleSelect:true,
	    title:'历史费用',
	    toolbar:'#toolbar_feeRecord',
	    columns:[[
					{field:'position',title:'物业地址',width:100,align:'center'},
					{field:'project',title:'收费项目',width:100,align:'center'},
					{field:'way',title:'收费方式',width:100,align:'center'},
					{field:'money',title:'金额',width:100,align:'center'},
					{field:'date',title:'缴费日期',width:100,align:'center'},
				]]
	});
    
});

function selectPosition(){
	$("#addOwner_position").combobox({
		  url:"${pageContext.request.contextPath}/house/findHouseByStatus.action?status=售出",//获取数据
		  // 向服务器请求的模式 
		  method : "post",
		  editable:false,
		  valueField: 'position',
		  textField: 'position',
	  });
}

function selectCarport(){
	$('#carportId').combobox({
		  url:'${pageContext.request.contextPath}/carport/findByStatus.action?status=未使用',//获取数据
		  // 向服务器请求的模式 
		  method : 'post',
		  editable:false,
		  valueField: 'carportId',
		  textField: 'carportPosition',
	 });
}

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
var payFee;
function add(value){
	payFee+=value;
	$('#payFee').html(payFee);
	return value;
}

function queryXzqh(){
	console.log('queryXzqh');
	$('#position').combobox({
	  url:'${pageContext.request.contextPath}/house/findHouseByStatus.action?status=已入住',//获取数据
	  // 向服务器请求的模式 
	  method : 'post',
	  editable:false,
	  valueField: 'position',
	  textField: 'position',
	});
}

function show(t,m){
	$.messager.show({
		title:t,
		msg:m,
		timeout:5000,
		showType:'slide'
	});
}

function selectFee(){
	payFee=0;
	var position = $('#position').val();
	if(position!=''){
		ur1 = "${pageContext.request.contextPath}/charge/findByPositionAndFeeState.action";
		  $('#t_feeWEG').datagrid('options').url = ur1;
		  $('#t_feeWEG').datagrid('options').queryParams = {
		        'position' : position,
		    };
		  $('#t_feeWEG').datagrid('reload');
		  
		  ur2 = "${pageContext.request.contextPath}/propertyFee/findByPositionAndFeeState.action";
		  $('#t_feeP').datagrid('options').url = ur2;
		  $('#t_feeP').datagrid('options').queryParams = {
		        'position' : position,
		    };
		  $('#t_feeP').datagrid('reload');
		  $('#payFee').html(payFee);
	}else{
		show('警告','未选择操作的房间');
	}
	
}

function selectFeeRecord(){
	var position = $('#position').val();
	var startdate = $('#startdate').val();
	var stopdate = $('#stopdate').val();
	if(position!=''){
		if(startdate!=''&&stopdate!=''){
			$.post('${pageContext.request.contextPath}/feeRecord/findFeeRecord.action',
					{
						position:position,
						startdate:startdate,
						stopdate:stopdate,
					},
					function(data){
						$('#t_feeRecord').datagrid('loadData',data);
					});
		}else{
			show('警告','请选择开始和截止时间');
		}
	}else{
		show('警告','未选择操作的房间');
	}
}

function print(){
	CreateFormPage("datagrid",$("#t_feeRecord"));
}

function cidString(){
	var row = $('#t_feeWEG').datagrid('getData');
	var cid = "";
	for(var i=0;i<row.total;i++){
		if(i==0){
			cid +=row.rows[i].chargeId;
		}else{
			cid += " "+ row.rows[i].chargeId;
		}
	}
	return cid;
}

function fidString(){
	var row = $('#t_feeP').datagrid('getData');
	var fid = "";
	for(var i=0;i<row.total;i++){
		if(i==0){
			fid +=row.rows[i].feeId;
		}else{
			fid += " "+ row.rows[i].feeId;
		}
	}
	return fid;
}

function pay(){
	var cid = cidString();
	var fid = fidString();
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
								$('#payFee').html('0');
								$('#t_feeWEG').datagrid('reload');
								$('#t_feeP').datagrid('reload');
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
var url= '';
var fm = '';
var dlg = '';
function addOwner(){
	$('#addOwner').dialog('open');
	$('#fmOwner').form('clear');
	selectPosition();
	url = '${pageContext.request.contextPath}/owner/addOwner.action';
	fm = '#fmOwner';
	dlg = '#addOwner';
}
function addComplaint(){
	var position = $('#position').val();
	if(position!=''){
		$('#addComplaint').dialog('open');
		$('#fmComplaint').form('clear');
		url = '${pageContext.request.contextPath}/complaint/addComplaint.action?position='+position;
		fm = '#fmComplaint';
		dlg = '#addComplaint';
	}else{
		show('警告','请选择房间！');
	}
}
function addRepair(){
	var position = $('#position').val();
	if(position!=''){
		$('#addRepair').dialog('open');
		$('#fmRepair').form('clear');
		url = '${pageContext.request.contextPath}/repair/addRepair.action?position='+position;
		fm = '#fmRepair';
		dlg = '#addRepair';
	}else{
		show('警告','请选择房间！');
	}
}
function addCarport(){
	var position = $('#position').val();
	if(position!=''){
		$('#addCarport').dialog('open');
		$('#fmCarport').form('clear');
		selectCarport();
		url = '${pageContext.request.contextPath}/propertyFee/addCarport.action?position='+position;
		fm = '#fmCarport';
		dlg = '#addCarport';
	}else{
		show('警告','请选择房间！');
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
				$(dlg).dialog('close');		// close the dialog
				if(fm=='#fmOwner'){
					queryXzqh();
				}
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

function cancel(){
	$(dlg).dialog('close');
}
</script>
<div class="easyui-layout" style="width: 1500px;height: 700px;">
    <div data-options="region:'north',split:true" style="height:100px;">
    	<div style="height: 10px;"></div>
    	<div class="fitem">
    		&emsp;
			<label>物业地址:</label>
			<input id="position" name="position">
		</div>
		<div style="height: 10px;"></div>
		&emsp;
		<a href="javascript:void(0)" iconCls="icon-addPeople" class="easyui-linkbutton" onclick="addOwner()">新增业主</a>&emsp;
		<a href="javascript:void(0)" iconCls="icon-complaint" class="easyui-linkbutton" onclick="addComplaint()">业主投诉</a>&emsp;
		<a href="javascript:void(0)" iconCls="icon-repair" class="easyui-linkbutton" onclick="addRepair()">业主报修</a>&emsp;
		<a href="javascript:void(0)" iconCls="icon-carport" class="easyui-linkbutton" onclick="addCarport()">购买车位</a>&emsp;
		<a href="javascript:void(0)" iconCls="icon-charge" class="easyui-linkbutton" onclick="selectFee()">费用缴纳</a>
    </div>
    <div data-options="region:'center'" style="min-height: 200px;">
    	<table id="t_feeWEG" iconCls="icon-fee"></table>
		<table id="t_feeP" iconCls="icon-fee"></table>
		<div>
			<label>总额：</label>
			<span id="payFee"></span>
		</div>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="pay()">缴费</a>
    </div>
    <div data-options="region:'south',split:true" style="height: 300px;">
    	<table id="t_feeRecord" iconCls="icon-feeHistory"></table>
		<div id="toolbar_feeRecord">
			<label>开始时间：</label>
			<input id="startdate" name="startdate" />
			<label>截止时间：</label>
			<input id="stopdate" name="stopdate" />
			<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-search" onclick="selectFeeRecord()">查询</a>
			<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-print" onclick="print()">打印</a>
		</div>
    </div>
    <div id="addOwner" class="easyui-dialog" style="padding-left:40px;width:400px;"
			title="新增业主" iconCls="icon-ok" buttons="#dlg-buttons" closed="true">
		<form id="fmOwner" method="post">
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>物业地址:</label>
					<input id="addOwner_position" name="position" style="width:150px" data-options="required:true">
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>业主姓名:</label>
					<input name="ownerName" class="easyui-validatebox" required="true">
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>性&emsp;&emsp;别:</label>
					<select class="easyui-combobox" name="sex" id="sex" data-options="required:true,editable:false,panelHeight:'auto'" style="width: 150px;">
						<option value="男">男</option>
						<option value="女">女</option>
					</select>
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>籍&emsp;&emsp;贯:</label>
					<input name="hometown" class="easyui-validatebox" required="true">
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>工作单位:</label>
					<input name="job" class="easyui-validatebox" >
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>邮&emsp;&emsp;箱:</label>
					<input name="email" class="easyui-validatebox" required="true" validType="email">
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>身份证号:</label>
					<input name="idcard" class="easyui-validatebox" required="true" validType="IDCard">
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>手机号码:</label>
					<input name="tel" class="easyui-validatebox" required="true"  validType="mobile">
				</div>
				<div style="height: 15px;"></div>
			</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()">取消</a>
	</div>
	<div id="addComplaint" class="easyui-dialog" style="padding-left:40px;width:400px;"
			title="业主投诉" iconCls="icon-ok" buttons="#dlg-buttons" closed="true">
		<form id="fmComplaint" method="post">
			<div style="height: 15px;"></div>
			<div class="fitem">
				<label>联系电话:</label>
				<input name="tel" class="easyui-validatebox" required="true" validType="mobile">
			</div>
			<div style="height: 15px;"></div>
			<div class="fitem">
				<label style="float:left;">投诉内容:&nbsp;</label>
				<textarea name="content" rows="5" cols="19" class="easyui-validatebox" required="true"></textarea>
			</div>
			<div style="height: 15px;"></div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()">取消</a>
	</div>
	<div id="addRepair" class="easyui-dialog" style="padding-left:40px;width:400px;"
			title="业主报修" iconCls="icon-ok" buttons="#dlg-buttons" closed="true">
			<form id="fmRepair" method="post">
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>联系电话:</label>
					<input name="tel" class="easyui-validatebox" required="true" validType="mobile">
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label style="float:left;">报修内容:</label>
					<textarea name="content" rows="5" cols="19" class="easyui-validatebox" required="true"></textarea>
				</div>
				<div style="height: 15px;"></div>
			</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()">取消</a>
	</div>
	<div id="addCarport" class="easyui-dialog" style="padding-left:40px;width:400px;"
			title="购买车位" iconCls="icon-ok" buttons="#dlg-buttons" closed="true">
			<form id="fmCarport" method="post">
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>车位地址:</label>
					<input id="carportId" name="carportId" class="easyui-combobox" required="true" style="width: 150px;">
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>开始日期:</label>
					<input name="start" class="easyui-datebox" required="true" style="width: 150px;">
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>截止日期:</label>
					<input name="stop" class="easyui-datebox" required="true" style="width: 150px;">
				</div>
				<div style="height: 15px;"></div>
				<div class="fitem">
					<label>缴纳费用:</label>
					<input name="total" class="easyui-validatebox" required="true" validType="pnum">
				</div>
				<div style="height: 15px;"></div>
			</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancel()">取消</a>
	</div>
</div>
