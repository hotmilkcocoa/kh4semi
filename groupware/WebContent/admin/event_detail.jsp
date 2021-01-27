<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.ScheduleDto"%>
<%@page import="groupware.beans.ScheduleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/admin_header.jsp"></jsp:include>

<%
	ScheduleDto scheduleDto = new ScheduleDto();
	ScheduleDao scheduleDao = new ScheduleDao();
	scheduleDto = scheduleDao.find(Integer.parseInt(request.getParameter("sch_no")));
	
%>


<script>
$(function(){
	$(".cancelBtn").click(function(){
		window.history.back();		
	});
	
	$(".deleteBtn").click(function(){
		
		if(confirm("정말 삭제하시겠습니까?")){
			location.href = "<%=request.getContextPath()%>/admin/event_delete.do?prev='true'&sch_no=<%=scheduleDto.getSch_no()%>";			
		}
	});
	
});
	
</script>

<div class="outbox" style="width:900px">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="일정 확인" class="headerImg" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg" width="30" height="30"> 
		<span>일정 확인</span>
	</div>  

	<div class="row">
		<table class="table table-border">
			<tbody>
				<tr>
					<th>일정</th>
					<td class="left">[<%=scheduleDto.getSch_no()%>] <%=scheduleDto.getSch_name()%></td>
				</tr>
				<tr>
					<th>일시</th>
					<td class="left">
					<%
						SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd a hh:mm");
						String starttimeFormat = f.format(scheduleDto.getSch_start());
						String endtimeFormat = f.format(scheduleDto.getSch_end());
					%>
					<%=starttimeFormat%> ~ <%=endtimeFormat%>			
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td class="left" height="200px;"><%=scheduleDto.getSch_content()%></td>
				</tr>
				<tr>
					<th>장소</th>
					<td class="left"><%=scheduleDto.getSch_place()%></td>
				</tr>
			</tbody>	
			<tfoot>
				<tr>
					<td class="right" colspan="2">
						<input type="button" class="input input-inline deleteBtn" style="width:100px;" value="삭제">
	            		<input type="button" class="input input-inline cancelBtn" style="width:100px;"  value="목록으로">
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	
	
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>    