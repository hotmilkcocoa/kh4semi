<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.DataSettingDto"%>
<%@page import="groupware.beans.DataSettingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int att_set_no = 1;

	DataSettingDao dataSettingDao = new DataSettingDao();
	DataSettingDto dataSettingDto = dataSettingDao.att_setFind(att_set_no);
	
	SimpleDateFormat f = new SimpleDateFormat("a h:mm");
	String start_timeFormat = f.format(dataSettingDto.getAtt_set_start());
	String end_timeFormat = f.format(dataSettingDto.getAtt_set_end());
%>
    
<jsp:include page="/template/admin_header.jsp"></jsp:include>

<script>
	$(function(){
		$(".cancle-Btn").click(function(e){
			e.preventDefault();
			
			if(confirm("작업 중이던 내용이 사라집니다. 계속하시겠습니까?")){
				location.href = "<%=request.getContextPath()%>/admin/tna_setting.jsp";
			}
		});
			
	});

</script>

<div class="outbox" style="width:900px;">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="근태 설정" class="headerImg" src="<%=request.getContextPath()%>/image/cog.svg" width="30" height="30"> 
		<span>근태 기본 설정</span>	
	</div>
	
	<form action="tna_setting_edit.do" method="post">
		<input type="hidden" name="att_set_no" value="1">
		<div class="row table table-border">
			<h3><li>출근시간</li></h3>
			<input type="time" style="width:300px;" class="input input-inline" name="att_set_start" value="<%=start_timeFormat%>" required>
			<span><%=start_timeFormat%></span>
		</div>
	
		<div class="row table table-border">
			<h3><li>퇴근시간</li></h3>
			<input type="time" style="width:300px;" class="input input-inline" name="att_set_end" value="<%=end_timeFormat%>" required>
			<span><%=end_timeFormat%></span>
		</div>
	
		<div class="row table table-border">
			<h3><li>지각설정시간</li></h3>
			<input type="text" style="width:300px;" class="input input-inline" name="att_set_late" value="<%=dataSettingDto.getAtt_set_late()%>">분
		</div>
	
		<div class="row right">
			<button class="edit-Btn input input-inline" style="width:100px;">설정수정</button>
			<button class="cancle-Btn input input-inline" style="width:100px;">취소</button>
		</div>
	</form>
	
</div>
	
<jsp:include page="/template/admin_footer.jsp"></jsp:include>