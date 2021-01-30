<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="groupware.beans.AttendanceDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@page import="groupware.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.workingHourTable{
		font-size: 14px;
	}
</style>

<jsp:include page="/template/header.jsp"></jsp:include>
<div class="scrollbox">
	<h1 class="title center"></h1>
	<input type="button" value="이전" class="prevNext" prev>
	<input type="button" value="다음" class="prevNext">
	<button class="close">모두 접기</button>
    <div class="contentContainer">
    </div>
</div>

<%
	int emp_no = (int) session.getAttribute("check");

	String date = request.getParameter("date");
	
	LocalDate tempDate = date == null ? LocalDate.now() : LocalDate.parse(date);
	LocalDate startOfMonth = tempDate.withDayOfMonth(1);
	LocalDate startOfCal = startOfMonth.minusDays(startOfMonth.getDayOfWeek().getValue());
	LocalDate endOfCal = startOfCal.plusDays(42);
	AttendanceDao attendanceDao = new AttendanceDao();
	List<AttendanceDto> attList = attendanceDao.select(emp_no, Timestamp.valueOf(startOfCal.atStartOfDay()), Timestamp.valueOf(endOfCal.atStartOfDay()));
	
	HashMap<LocalDate, AttendanceDto> attMap = new HashMap<LocalDate, AttendanceDto>();
	for(int i=0; i<42; i++){
		attMap.put(startOfCal.plusDays(i), null);
	}
	for(AttendanceDto dto : attList){
		attMap.replace(dto.getAtt_start().toLocalDateTime().toLocalDate(), dto);
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
%>
<script type="text/template" id="template">
<div class="weekContainer">
	<div class="center listHeader cursor-pointer">
		<span>{week}</span>
		<span>( 주간 누적 시간 : <span class="cumulative">{cumulative}</span> )</span>
	</div>
	<div class="tableContainer hide">
		<table class="workingHourTable table table-border">
			<thead>
				<tr>
					<td width="100px">일자</td>
					<td>출근 시간</td>
					<td>퇴근 시간</td>
					<td>총 근무 시간</td>
				</tr>
			</thead>
			<tbody class="workingHourTable workingHourTableBody"></tbody>
		</table>
	</div>
	<hr>
</div>
</script>
<script>
    function removeAllChild(parent) {
		while (parent.firstChild) {
			parent.removeChild(parent.firstChild);
		}
    }
    function getDateString(date){
		var year = date.getFullYear();
		var month = (date.getMonth() + 1);
		month = month < 10 ? "0" + month : month;
		var day = date.getDate();
		day = day < 10 ? "0" + day : day;
		
		return year + "-" + month + "-" + day;
	}
        
    var today = new Date();
    var temp_date = new Date("<%=startOfMonth.toString()%>");
    var dayArr = ["일", "월", "화", "수", "목", "금", "토", "일"];

    function paintTemplate(){
		var contentContainer = document.querySelector(".contentContainer");
        removeAllChild(contentContainer);

        for(var i=0; i<6; i++){
            var template = document.querySelector("#template").innerHTML;
            template = template.replace("{week}", (i+1) + "주차");
            contentContainer.innerHTML = contentContainer.innerHTML + template;
        }
        };
 
    function paintTable(){
        paintTemplate();

        document.querySelector(".title").innerHTML = temp_date.getFullYear() + "." + (temp_date.getMonth() + 1);
           
        var start = new Date(temp_date);
        start.setDate(1-start.getDay());
        for(var i=0; i<6; i++){
            for(var j=0; j<7; j++){
                var newTr = document.createElement("tr");
                newTr.classList.add("dayTr");
                for(var k=0; k<4; k++){
                    var newTd = document.createElement("td");
                    if(k==0){
                        newTd.innerHTML = start.getDate() + " " + dayArr[j];
                        start.setDate(start.getDate() + 1);
                    }
                    newTr.append(newTd);
                }
                document.querySelectorAll(".workingHourTable>tbody")[i].append(newTr);
            }
            document.querySelectorAll(".listHeader")[i].addEventListener("click", function(){
                this.nextElementSibling.classList.toggle("hide");
            });
        }
    };
    paintTable();

    //이전, 다음 클릭 시 달 변경
	document.querySelectorAll(".prevNext").forEach(function (ele) {
		ele.addEventListener("click", function () {
            var val = 1;
            if (this.hasAttribute("prev")) val = -1;
            temp_date.setMonth(temp_date.getMonth() + val);
            var link = "att_status.jsp?date={date}";
            link = link.replace("{date}", getDateString(temp_date));
            location.href = link;
		});
	});
    document.querySelector(".close").addEventListener("click", function(){
        document.querySelectorAll(".tableContainer").forEach(function(ele){
            ele.classList.add("hide");
        });
    });
    <%
    for(int i=0; i<6; i++){
    	long workingHour = 0;
    	for(int j=0; j<7; j++){
    		AttendanceDto attendanceDto = attMap.get(startOfCal.plusDays(j+(i*7)));
    		if(attendanceDto == null){%>
	    		var dayTr = document.querySelectorAll(".dayTr")[<%=j+(i*7)%>];
	    		dayTr.children[3].remove();
	    		dayTr.children[2].remove();
	    		dayTr.children[1].setAttribute("colspan", 3);
	    		dayTr.children[1].innerText = "정보가 없습니다.";
	    	<%} else{%>
	    		var dayTr = document.querySelectorAll(".dayTr")[<%=j+(i*7)%>];
	    		dayTr.children[1].innerText = "<%=sdf.format(attendanceDto.getAtt_start())%>";
	    		dayTr.children[2].innerText = "<%if(attendanceDto.getAtt_end() != null){%><%=sdf.format(attendanceDto.getAtt_end())%><%} else {%>정보가 없습니다.<%}%>";
	    		dayTr.children[3].innerText = "<%if(attendanceDto.getAtt_end() != null){%><%=Util.longToTime(attendanceDto.getAtt_end().getTime() - attendanceDto.getAtt_start().getTime())%><%} else {%> - <%}%>";
    		<%}
    		if(attendanceDto != null && attendanceDto.getAtt_end() != null) {
    			workingHour += attendanceDto.getAtt_end().getTime() - attendanceDto.getAtt_start().getTime();
    		}
    	}%>
		document.querySelectorAll(".cumulative")[<%=i%>].innerText = "<%=Util.longToTime(workingHour)%>";
		<%
    }
    %>
</script>
<jsp:include page="/template/footer.jsp"></jsp:include>