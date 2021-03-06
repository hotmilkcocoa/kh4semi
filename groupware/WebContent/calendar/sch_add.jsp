<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.ScheduleDto"%>
<%@page import="groupware.beans.ScheduleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

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

<%if(isEdit){%>
	<h1 class="title">일정 수정</h1>
<%} else{%>
	<h1 class="title">일정 등록</h1>
<%} %>
<hr>
<div class="container">
	<%if(isEdit){ %>
    <form action="sch_add.do?edit" method="post">
    <input type="hidden" value="<%=scheduleDto.getSch_no()%>" name="sch_no">
    <%} else{%>
    <form action="sch_add.do" method="post">
    <%} %>
    <input type="hidden" name="calType" value="<%=request.getParameter("calType")%>">
    <input type="hidden" name="referer" value="<%=request.getHeader("referer")%>">
        <div class="row rel">
            <span>일정명</span>
            <div class="data">
                <input class="dataInput text" type="text" name="sch_name" required <%if(isEdit){ %> value="<%=scheduleDto.getSch_name()%>" <%} %>>
            </div>
        </div>
        <div class="row rel">
            <span>일시</span>
            <div class="data">
                <input class="dataInput date" type="date" name="sch_start_date" required>
                <select class="dataInput select" name="sch_start_time" required>
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
                <input class="dataInput date" type="date" name="sch_end_date" required>
                <select class="dataInput select" name="sch_end_time" required>
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
            <div class="data">
                <textarea class="dataInput textarea" name="sch_content" rows="10" required><%if(isEdit){ %><%=scheduleDto.getSch_content()%><%} %></textarea>
            </div>
        </div>
        <div class="row rel">
            <span>장소</span>
            <div class="data">
                <input class="dataInput text" type="text" name="sch_place" required <%if(isEdit){ %> value="<%=scheduleDto.getSch_place() %>" <%} %>>
            </div>
        </div>
        <div class="row rel">
            <span>공개</span>
            <div class="data">
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
        <div class="row rel">
            <input class="dataInput" type="submit" value="저장">
            <input class="dataInput cancelBtn" type="button" value="취소">
        </div>
    </form>
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
	document.querySelector(".cancelBtn").addEventListener("click", function(){
		window.history.back();
	});
	
	document.forms[0].addEventListener("submit", function(e){
		var schDate = document.querySelectorAll(".dataInput.date");
		var schTime = document.querySelectorAll(".dataInput.select");
		
		var schStart = new Date(schDate[0].value + " " + schTime[0].value);
		var schEnd = new Date(schDate[1].value + " " + schTime[1].value);
		
		e.preventDefault();
		if(schEnd <= schStart){
			alert("일시를 확인해주세요.");
		} else{
			this.submit();
		}
	});
</script>
            
<jsp:include page="/template/footer.jsp"></jsp:include>  