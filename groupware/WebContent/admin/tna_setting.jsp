<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.DataSettingDto"%>
<%@page import="groupware.beans.DataSettingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int att_set_no = 1;

	DataSettingDao dataSettingDao = new DataSettingDao();
	DataSettingDto dataSettingDto = dataSettingDao.att_setFind(att_set_no);
	
%>
        
<jsp:include page="/template/admin_header.jsp"></jsp:include>

<script>
	$(function(){
		$(".edit-Btn").click(function(e){
			location.href = "<%=request.getContextPath()%>/admin/tna_setting_edit.jsp";
		});
	});

</script>

<div class="outbox" style="width:900px;">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="근태 설정" class="headerImg" src="<%=request.getContextPath()%>/image/cog.svg" width="30" height="30"> 
		<span>근태 기본 설정</span>	
	</div>

	<div class="row table table-border">
		<h3><li>출근시간</li></h3>
		<span>
		<%
			SimpleDateFormat f = new SimpleDateFormat("a h:mm");
			String start_timeFormat = f.format(dataSettingDto.getAtt_set_start());
		%>
		<%=start_timeFormat%>
		</span>
	</div>

	<div class="row table table-border">
		<h3><li>퇴근시간</li></h3>
		<span>
		<%
			SimpleDateFormat g = new SimpleDateFormat("a h:mm");
			String end_timeFormat = g.format(dataSettingDto.getAtt_set_end());
		%>
		<%=end_timeFormat%>
		</span>
	</div>

	<div class="row table table-border">
		<h3><li>지각설정시간</li></h3>
		<span><%=dataSettingDto.getAtt_set_late()%>분</span>
	</div>

	<div class="row right">
		<button class="edit-Btn input input-inline">설정수정</button>
	</div>

</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>