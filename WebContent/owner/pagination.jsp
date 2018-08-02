<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav aria-label="Page navigation">
  <ul class="pagination">
  	<!-- 当总页数小于等于5时 -->
  	<c:if test="${pagination.pagesize<=5}">
  		<c:if test="${pagination.index<=1}">
  			<li class="disabled">
		      <a href="#" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
  		</c:if>
  		<c:if test="${pagination.index>1}">
  			<li>
		      <a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?page=${pagination.index-1}&way=${pagination.way}" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
  		</c:if>
	    <c:forEach begin="1" end="${pagination.pagesize}" varStatus="i">
	    	<c:if test="${i.index==pagination.index }">
	    		<li class="active"><a href="#">${i.index }</a></li>
	    	</c:if>
	    	<c:if test="${i.index!=pagination.index }">
	    		<li><a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?page=${i.index}&way=${pagination.way}">${i.index }</a></li>
	    	</c:if>
	    </c:forEach>
	    <c:if test="${pagination.index>=pagination.pagesize}">
  			<li class="disabled">
		      <a href="#" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
  		</c:if>
  		<c:if test="${pagination.index<pagination.pagesize}">
  			<li>
		      <a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?page=${pagination.index+1}&way=${pagination.way}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
  		</c:if>
  	</c:if>
  	
  	<!-- 当总页数大于5时 -->
  	<c:if test="${pagination.pagesize>5}">
  		<c:if test="${pagination.index<=1}">
  			<li class="disabled">
		      <a href="#" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
  		</c:if>
  		<c:if test="${pagination.index>1}">
  			<li>
		      <a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?page=${pagination.index-1}&way=${pagination.way}" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
  		</c:if>
  		
  		<c:if test="${pagination.index<=3}">
  			<c:forEach begin="1" end="5" varStatus="i">
		    	<c:if test="${i.index==pagination.index }">
		    		<li class="active"><a href="#">${i.index }</a></li>
		    	</c:if>
		    	<c:if test="${i.index!=pagination.index }">
		    		<li><a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?page=${i.index}&way=${pagination.way}">${i.index }</a></li>
		    	</c:if>
		    </c:forEach>
  		</c:if>
  		<c:if test="${pagination.index>3 && pagination.index<=pagination.pagesize-2}">
  			<c:forEach begin="${pagination.index-2}" end="${pagination.index+2}" varStatus="i">
		    	<c:if test="${i.index==pagination.index }">
		    		<li class="active"><a href="#">${i.index }</a></li>
		    	</c:if>
		    	<c:if test="${i.index!=pagination.index }">
		    		<li><a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?page=${i.index}&way=${pagination.way}">${i.index }</a></li>
		    	</c:if>
		    </c:forEach>
  		</c:if>
  		<c:if test="${pagination.index>pagination.pagesize-2}">
  			<c:forEach begin="${pagination.pagesize-4}" end="${pagination.pagesize}" varStatus="i">
		    	<c:if test="${i.index==pagination.index }">
		    		<li class="active"><a href="#">${i.index }</a></li>
		    	</c:if>
		    	<c:if test="${i.index!=pagination.index }">
		    		<li><a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?page=${i.index}&way=${pagination.way}">${i.index }</a></li>
		    	</c:if>
		    </c:forEach>
  		</c:if>
	   
	    <c:if test="${pagination.index>=pagination.pagesize}">
  			<li class="disabled">
		      <a href="#" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
  		</c:if>
  		<c:if test="${pagination.index<pagination.pagesize}">
  			<li>
		      <a href="${pageContext.request.contextPath}/${pagination.navigation}/sendPagination.action?page=${pagination.index+1}&way=${pagination.way}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
  		</c:if>
  	</c:if>
  </ul>
</nav>