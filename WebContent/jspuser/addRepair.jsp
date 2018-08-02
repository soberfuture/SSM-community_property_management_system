<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<jsp:include page="default.jsp" flush="true"></jsp:include>
	<script type="text/javascript" src="../js/jquery.raty.min.js"></script>
</head>
<body style="margin: 0;padding: 0;">
		<table id="dg" title="我的报修" class="easyui-datagrid" style="width: 100%;"
		toolbar="#toolbar" rownumbers="true" fitColumns="true" singleSelect="true">
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
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="add()">添加</a>&emsp;
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="comment()">评价</a>&emsp;
		<span>按处理状态查询报修记录：</span>
		<select id="situation" name="situation" class="easyui-combobox" panelHeight="auto">
			<option value="all">显示所有</option>
			<option value="未处理">未处理</option>
			<option value="已处理">已处理</option>
			<option value="已评价">已评价</option>
		</select>
		<label>开始时间：</label>
		<input class="easyui-datebox" id="startdate" name="startdate" data-options="required:true" />
		<label>截止时间：</label>
		<input class="easyui-datebox" id="stopdate" name="stopdate" data-options="required:true" />
		<a id='bt_search' href="javascript:;" class="easyui-linkbutton" iconCls="icon-search">查询</a>
	</div>
	<div id="dlg" class="easyui-dialog" style="width:350px;height:300px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<div style="height: 30px;"></div>
			<input id="ownerId" name="ownerId" type="hidden" />
			<input id="position" name="position" type="hidden" />
			<div class="fitem">
				<label>联系电话:</label>
				<input name="tel" class="easyui-validatebox" required="true" validType="mobile">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label style="float:left;">报修内容:</label>
				<textarea name="content" rows="5" cols="20" class="easyui-validatebox" required="true"></textarea>
			</div>
		</form>
	</div>
	<div id="comment" class="easyui-dialog" style="width:350px;height:330px;padding:10px 20px"
			closed="true" buttons="#dlg2-buttons">
		<form id="cfm" method="post">
			<div style="height: 30px;"></div>
			<input id="eType" name="eType" type="hidden" />
			<input id="targetId" name="targetId" type="hidden"/>
			<div class="fitem">
				<label style="float:left;display: block;">满意度:</label>
				<div id="default-demo" style="float:left;"></div>
				<input id="star" name="star" type="hidden">
			</div>
			<div style="height: 30px;"></div>
			<div class="fitem">
				<label style="float:left;">评&emsp;价:</label>&nbsp;
				<textarea name="econtent" rows="5" cols="20" class="easyui-validatebox"></textarea>
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="save()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
	<div id="dlg2-buttons">
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-ok" onclick="savec()">保存</a>
		<a href="javascript:;" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#comment').dialog('close')">取消</a>
	</div>
</body>
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
		function add(){
			$('#dlg').dialog('open').dialog('setTitle','新增');
			$('#fm').form('clear');
			$('#ownerId').val('${user.house.ownerId}');
			$('#position').val('${user.house.position}');
			url = '${pageContext.request.contextPath}/repair/addRepair.action';
		}
		
		function comment(){
			var row = $('#dg').datagrid('getSelected');
			if(row){
				if(row.situation=='已处理'){
					starInit();
					$('#comment').dialog('open').dialog('setTitle','评价');
					$('#cfm').form('clear');
					$('#eType').val('repair');
					$('#targetId').val(row.repairId);
					url='${pageContext.request.contextPath}/evaluate/insert.action';
				}else{
					$.messager.alert('信息','该行未处理或已评价！');
				}
			}else{
				$.messager.alert('信息','请选择！');
			}
		}
		/*星星初始化*/
		function starInit(){
			$.fn.raty.defaults.path = '../images';
			$('#default-demo').raty();
		}
		function reset(){
			  $('#fm').form('clear');
			  $('#cfm').form('clear');
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
		
		function savec(){
			$('#cfm').form('submit',{
				url: url,
				onSubmit: function(){
					var star = $('#default-demo input').val();
					if(star==''){
						$('#star').val('0');
					}else{
						$('#star').val(star);
					}
					console.log($('#star').val());
					return $(this).form('validate');
				},
				success: function(result){
					var result = eval('('+result+')');
					if (result.success){
						$('#comment').dialog('close');		// close the dialog
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
		
		$('#situation').combobox({
			onSelect:function(obj){
				if(obj.value!='all'){
					$('#dg').datagrid({
						url:'${pageContext.request.contextPath}/repair/findByPositionAndSituation.action',
						queryParams: {
							position: '${user.house.position}',
							way: obj.value
						}
					});
				}else{
					$('#dg').datagrid({
						url:'${pageContext.request.contextPath}/repair/findByPositionAndSituation.action',
						queryParams: {
							position: '${user.house.position}',
						}
					});
				}
			}
		});
		
		/*按时间查询*/
		$('#bt_search').click(function(){
			var url = '${pageContext.request.contextPath}/repair/findByPositionAndSituation.action';
			var position = '${user.house.position}';
			var startdate = $('#startdate').val();
			var stopdate = $('#stopdate').val();
			var state = $('#situation').val();
			if(compareDate(startdate,stopdate)){
				if(state=='all'){
					$('#dg').datagrid({
						url:url,
						queryParams: {
							position: position,
							startdate:startdate,
							stopdate:stopdate
						}
					});
				}else{
					$('#dg').datagrid({
						url:url,
						queryParams: {
							position: position,
							way: state,
							startdate:startdate,
							stopdate:stopdate
						}
					});
				}
			}else{
				alert('时间选择有误');
			} 
		});
		/*比较时间大小*/
		function compareDate(startdate,stopdate){
			if(startdate==''||stopdate==''){
				return false;
			}
			var start = new Date(startdate.replace("-", "/").replace("-", "/"));
			var stop = new Date(stopdate.replace("-", "/").replace("-", "/"));
			if(start<=stop){
				return true;
			}else{
				return false;
			}
		}
	</script>
</html>