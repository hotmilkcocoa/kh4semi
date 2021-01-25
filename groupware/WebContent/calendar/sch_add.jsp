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
        <div class="row rel">
            <span>일정명</span>
            <div class="data">
                <input class="dataInput text" type="text" name="sch_name" <%if(isEdit){ %> value="<%=scheduleDto.getSch_name()%>" <%} %>>
            </div>
        </div>
        <div class="row rel">
            <span>일시</span>
            <div class="data">
                <input class="dataInput date" type="date" name="sch_start_date">
                <select class="dataInput select" name="sch_start_time">
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
                <input class="dataInput date" type="date" name="sch_end_date">
                <select class="dataInput select" name="sch_end_time">
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
                <textarea class="dataInput textarea" name="sch_content" rows="10"><%if(isEdit){ %><%=scheduleDto.getSch_content()%><%} %></textarea>
            </div>
        </div>
        <div class="row rel">
            <span>장소</span>
            <div class="data">
                <input class="dataInput text" type="text" name="sch_place" <%if(isEdit){ %> value="<%=scheduleDto.getSch_place() %>" <%} %>>
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
            <input class="dataInput" type="button" value="취소">
        </div>
    </form>
</div>
<script>
	<%if(isEdit){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String start_date = sdf.format(scheduleDto.getSch_start());
		String end_date = sdf.format(scheduleDto.getSch_end());
		
		sdf = new SimpleDateFormat("HH:mm");
		String start_time = sdf.format(scheduleDto.getSch_start());
		String end_time = sdf.format(scheduleDto.getSch_end());
	%>
		var date = document.querySelectorAll(".dataInput.date");
		date[0].value = "<%=start_date%>";
		date[1].value = "<%=end_date%>";
		
		var select = document.querySelectorAll(".dataInput.select");
		for(var i=0; i<select.length; i++){
			var time = (i==0) ? "<%=start_time%>" : "<%=end_time%>";
			for(var j=0; j<select[i].length; j++){
				if(select[i].children[j].innerText == time){
					select[i].children[j].selected = true;
				}
			}
		}
		
		var radio = document.querySelectorAll("input[name=sch_open]");
		radio[0].value == "<%=scheduleDto.getSch_open()%>" ? radio[0].checked=true : radio[1].checked=true;
	<%}%>
</script>
            
<jsp:include page="/template/footer.jsp"></jsp:include>  