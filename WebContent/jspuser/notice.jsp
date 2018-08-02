<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告</title>
<jsp:include page="default.jsp" flush="true"></jsp:include>
<style type="text/css">
	ul{
		list-style: none;
		font-family: "\5FAE\8F6F\96C5\9ED1";
	}
	.news-item {
	    height: 35px;
	    line-height: 35px;
	    padding: 4px 0;
	    border-bottom:1px dashed #DDDDDD;
	    position:relative;
	}
	.news-item .lnk-tit {
	    display: block;
	    position: relative;
	    height: 35px;
	    line-height: 35px;
	    padding: 0 55px 0 90px;
	    overflow: hidden;
	    font-size: 16px;
	    color: #555555;
	}
	.news-item .new-type {
	    position: absolute;
	    left: 0;
	    top: 0;
	    width: 68px;
	    height: 35px;
	    line-height: 35px;
	    background: #ebebeb;
	    text-align: center;
	    color: #7a7a7a;
	}
	
	.news-item .date {
	    position: absolute;
	    right: 0;
	    top: 0;
	    width: 100px;
	    height: 35px;
	    line-height: 35px;
	    text-align: right;
	    color: #bababa;
	}
	.lnk-tit:hover {
	    text-decoration: none;
	    color: #D1AB57;
	}
	.lnk-tit:hover .new-type {
	    text-decoration: none;
	   	background: #D1AB57;
	   	color: white;
	}
	a {
	    text-decoration: none;
	}
</style>
</head>
<body>

<ul id="t_notice">

</ul>
<div style="margin-left: 43%;">
	<a id="prev" class="easyui-linkbutton" href="javascript:;" onclick="prev()">上一页</a>&emsp;第<span id="pagination"></span>页&emsp;<a id="next" class="easyui-linkbutton" href="javascript:;" onclick="next()">下一页</a>
</div>
</body>
<script type="text/javascript">
	var index=1;
	var pagesize=12;
	var total=0;
	var maxPage=0;
	
	$(function(){
		init(1,12);
	});
	
	function init(index,pagesize){
		$.post('${pageContext.request.contextPath}/notice/findByPagination.action',{page:index,rows:pagesize},function(data){
			total=data.total;
			maxPage = Math.ceil(total/pagesize);
			$('#pagination').text(index+'/'+maxPage);
			if(index<=1){
				$('#prev').css('cursor','not-allowed');
				$('#prev').linkbutton('disable');
			}else{
				$('#prev').css('cursor','pointer');
				$('#prev').linkbutton('enable');
			}
			if(index>=maxPage){
				$('#next').css('cursor','not-allowed');
				$('#next').linkbutton('disable');
			}else{
				$('#next').css('cursor','pointer');
				$('#next').linkbutton('enable');
			}
			var tb = '';
			for(var i=0;i<data.rows.length;i++){
				tb += '<li class="news-item"><a class="lnk-tit" href="javascript:;" onclick="show('+data.rows[i].nid+');"><span class="new-type">公告</span>'+data.rows[i].title+'<span class="date">'+data.rows[i].date+'</span></a></li>'
				$('#t_notice').html(tb);
			}
		});
	}
	
	function show(nid){
		$.post('${pageContext.request.contextPath}/notice/selectByPrimaryKey.action',{nid:nid},function(data){
			if(data==null){
				$.messager.show({	// show error message
					title: '信息',
					msg: '没有找到该通告'
				});
			}else{
				$.messager.alert(data.title,'<p>'+data.content+'</p>','info');
			}
		});
	}
	
	function prev(){
		index--;
		init(index,pagesize);
	}
	
	function next(){
		index++;
		init(index,pagesize);
	}
</script>
</html>