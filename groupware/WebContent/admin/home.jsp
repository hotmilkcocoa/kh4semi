<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/admin_header.jsp"></jsp:include>

<div class="outbox">
	<div class="row center">
		<a href="<%=request.getContextPath()%>/admin/hr.jsp"><img alt="인사관리로" src="<%=request.getContextPath()%>/image/people.svg"></a>
		<a href="<%=request.getContextPath()%>/admin/tna.jsp"><img alt="근태관리로" src="<%=request.getContextPath()%>/image/timelapse.svg"></a>
	</div>
	<div class="row center">
		<a href="<%=request.getContextPath()%>/admin/event.jsp"><img alt="일정관리로" src="<%=request.getContextPath()%>/image/calendar.svg"></a>
		<a href="<%=request.getContextPath()%>/admin/setting.jsp"><img alt="설정관리로" src="<%=request.getContextPath()%>/image/settings.svg"></a>
	</div>
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>
		