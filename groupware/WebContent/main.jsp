<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.AttendanceDto"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<%
	AttendanceDao attendanceDao = new AttendanceDao();
//	AttendanceDto attendanceDto = attendanceDao.find((int) session.getAttribute("check"));
	AttendanceDto attendanceDto = attendanceDao.find(3);
	
	String start = "미등록";
	String end = "미등록";

	boolean isTrue = attendanceDto != null;
	if(isTrue){
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		start = sdf.format(attendanceDto.getAtt_start());
		if(attendanceDto.getAtt_end() != null){
			end = sdf.format(attendanceDto.getAtt_end());			
		}
	}
%>

<div class="attContainer">
    <span class="attTitle">근태관리</span>
    <input type="button" value="출근 하기" class="attBtn start" <%if(isTrue){ %>disabled<%} %>>
    <input type="button" value="퇴근 하기" class="attBtn end" <%if(!isTrue || attendanceDto.getAtt_end() != null){ %>disabled<%} %>>
    <div class="attTable">
        <span class="thead">출근 시간</span>
        <span class="tdata"><%=start%></span>
        <span class="thead">퇴근 시간</span>
        <span class="tdata"><%=end%></span>
    </div>
</div>

<h5 class="center">Session ID : <%=session.getId()%></h5>
			<h5 class="center">check : <%=session.getAttribute("check")%></h5>
			<h5 class="center">auth : <%=session.getAttribute("auth")%></h5>

<script>
	document.querySelector(".attBtn.start").addEventListener("click", function(){
		location.href = "attendance/att_add.do?arrive";
	});
	document.querySelector(".attBtn.end").addEventListener("click", function(){
		location.href = "attendance/att_add.do<%if(isTrue){ %>?att_no=<%=attendanceDto.getAtt_no()%><%}%>";
	});
</script>
<jsp:include page="/template/footer.jsp"></jsp:include> 