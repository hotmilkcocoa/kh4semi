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
	boolean isEdit = request.getParameter("edit") != null;
	ScheduleDto scheduleDto = null;
	if(isEdit){
		ScheduleDao scheduleDao = new ScheduleDao();
		scheduleDto = scheduleDao.find(Integer.parseInt(request.getParameter("sch_no")));
	}
	String start_date = request.getParameter("date");
	String end_date = request.getParameter("date");
	
	String start_time, end_time;
	if(request.getParameter("start_time")!=null){
		start_time = LocalTime.parse(request.getParameter("start_time")).toString();
		end_time = LocalTime.parse(request.getParameter("start_time")).plusHours(1).toString();
	} else{
		start_time = LocalTime.of(LocalTime.now().getHour(), 0).toString();
		end_time = LocalTime.of(LocalTime.now().plusHours(1).getHour(), 0).toString();		
	}
%>
<script>
	$(function(){
		$(".cancelBtn").click(function(e){
			e.preventDefault();
			
			if(confirm("정말 취소하시겠습니까?")){
				location.href = "<%=request.getContextPath()%>/admin/event_list.jsp";
			}
			
		});
	});
</script>
<div class="outbox" style="width:900px">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="일정 추가" class="headerImg" src="<%=request.getContextPath()%>/image/playlist_add.svg" width="30" height="30"> 
		<%if(isEdit){%>
		<span>일정 수정</span>
		<%} else{%>
		<span>일정 등록</span>
		<%} %>	
	</div>  

	<div class="row">
		<%if(isEdit){ %>
	    <form action="event_add_edit.do?edit" method="post">
	    <input type="hidden" value="<%=scheduleDto.getSch_no()%>" name="sch_no">
	    <%} else{%>
	    <form action="event_add_edit.do" method="post">
	    <%} %>	
			<div class="row rel">
	            <span>일정명</span>
	            <div class="row">
	                <input class="input" type="text" name="sch_name" <%if(isEdit){ %> value="<%=scheduleDto.getSch_name()%>" <%} %>>
	            </div>
	        </div>
	        <div class="row rel">
	            <span>일시</span>
	            <div class="row">
	                <input class="dataInput date input input-inline" style="width:200px;" type="date" name="sch_start_date">
	                <select class="dataInput select input input-inline" style="width:150px;" name="sch_start_time">
	                    <option>00:00</option>
	                    <option>01:00</option>
	                    <option>02:00</option>
	                    <option>03:00</option>
	                    <option>04:00</option>
	                    <option>05:00</option>
	                    <option>06:00</option>
	                    <option>07:00</option>
	                    <option>08:00</option>
	                    <option>09:00</option>
	                    <option>10:00</option>
	                    <option>11:00</option>
	                    <option>12:00</option>
	                    <option>13:00</option>
	                    <option>14:00</option>
	                    <option>15:00</option>
	                    <option>16:00</option>
	                    <option>17:00</option>
	                    <option>18:00</option>
	                    <option>19:00</option>
	                    <option>20:00</option>
	                    <option>21:00</option>
	                    <option>22:00</option>
	                    <option>23:00</option>
	                </select>
	                - 
	                <input class="dataInput date input input-inline" style="width:200px;" type="date" name="sch_end_date">
	                <select class="dataInput select input input-inline" style="width:150px;" name="sch_end_time">
	                    <option>00:00</option>
	                    <option>01:00</option>
	                    <option>02:00</option>
	                    <option>03:00</option>
	                    <option>04:00</option>
	                    <option>05:00</option>
	                    <option>06:00</option>
	                    <option>07:00</option>
	                    <option>08:00</option>
	                    <option>09:00</option>
	                    <option>10:00</option>
	                    <option>11:00</option>
	                    <option>12:00</option>
	                    <option>13:00</option>
	                    <option>14:00</option>
	                    <option>15:00</option>
	                    <option>16:00</option>
	                    <option>17:00</option>
	                    <option>18:00</option>
	                    <option>19:00</option>
	                    <option>20:00</option>
	                    <option>21:00</option>
	                    <option>22:00</option>
	                    <option>23:00</option>
	                </select>
	            </div>
	        </div>
	        <div class="row rel">
	            <span>내용</span>
	            <div class="row">
	                <textarea class="input textarea" name="sch_content" rows="5"><%if(isEdit){ %><%=scheduleDto.getSch_content()%><%} %></textarea>
	            </div>
	        </div>
	        <div class="row rel">
	            <span>장소</span>
	            <div class="row">
	                <input class="input" type="text" name="sch_place" <%if(isEdit){ %> value="<%=scheduleDto.getSch_place()%>" <%} %>>
	            </div>
	        </div>
	        <div class="row rel">
	            <span>공개</span>
	            <div class="row">
	                <label>
	                    <input type="radio" name="sch_open" value="true" checked>
	                   	 공개
	                </label>
	                <label>
	                    <input type="radio" name="sch_open" value="false">
	                   	 비공개
	                </label>
	            </div>
	        </div>
	        <div class="row right">
	            <input class="input input-inline" style="width:100px;" type="submit" value="저장">
	            <input class="input input-inline cancelBtn" style="width:100px;" type="button" value="취소">
	        </div>
		</form>

	</div>
</div>
<script>
	<%if(isEdit){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		start_date = sdf.format(scheduleDto.getSch_start());
		end_date = sdf.format(scheduleDto.getSch_end());
		
		sdf = new SimpleDateFormat("HH:mm");
		start_time = sdf.format(scheduleDto.getSch_start());
		end_time = sdf.format(scheduleDto.getSch_end());
	%>
		var radio = document.querySelectorAll("input[name=sch_open]");
		radio[0].value == "<%=scheduleDto.getSch_open()%>" ? radio[0].checked=true : radio[1].checked=true;
	<%}%>
	var date = document.querySelectorAll(".dataInput.date");
	date[0].value = "<%=start_date!=null ? start_date : LocalDate.now()%>";
	date[1].value = "<%=end_date!=null ? end_date : LocalDate.now()%>";
	
	var select = document.querySelectorAll(".dataInput.select");
	for(var i=0; i<select.length; i++){
		var time = (i==0) ? "<%=start_time%>" : "<%=end_time%>";
		for(var j=0; j<select[i].length; j++){
			if(select[i].children[j].innerText == time){
				select[i].children[j].selected = true;
			}
		}
	}
	
	document.forms[0].addEventListener("submit", function(e){
		e.preventDefault();
		var str = document.querySelector(".textarea").value;
		str = str.replace(/\n/g, '<br/>');
		document.querySelector(".textarea").value = str;
		this.submit();
	});
	
	
</script>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>    