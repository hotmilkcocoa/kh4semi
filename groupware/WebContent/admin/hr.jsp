<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="/template/admin_header.jsp"></jsp:include>

<div class="outbox" style="width:900px">
	<div class="row center">
	
			<a href="<%=request.getContextPath()%>/admin/group.jsp">
				<label>조직관리</label>
				<img alt="조직관리로" src="<%=request.getContextPath()%>/image/people.svg">
			</a>
				
			<a href="<%=request.getContextPath()%>/admin/employee.jsp">
				<label>사원관리</label>
				<img alt="사원관리로" src="<%=request.getContextPath()%>/image/timelapse.svg">
			</a>
		
	</div>
	<div class="row center">
		<a href="<%=request.getContextPath()%>/admin/manager.jsp">
			<label>인사관리자</label>
			<img alt="인사관리자로" src="<%=request.getContextPath()%>/image/calendar.svg">
		</a>
		<a href="#"><img alt="없음" src=""></a>
	</div>
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>
		