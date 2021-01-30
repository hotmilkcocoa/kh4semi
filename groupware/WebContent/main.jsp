<%@page import="groupware.beans.EmployeeDao"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="groupware.beans.ScheduleDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.TreeMap"%>
<%@page import="groupware.beans.ScheduleDao"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.AttendanceDto"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	div{
		border: none;
	}
	.rowFlex{
		display: flex;
		flex-direction: row;
		height: 100%;
	}
	.colFlex{
		display: flex;
		flex-direction: column;
	}
	.contentContainer.rowFlex{
	    height: 420px;
	    padding: 0 50px;
	}
	.calendarContainer{
		width: 85%;
	}
	.boardListContainer{
		width: 15%;
		background-color: white;
	}
	.calendarArea{
		width: 60%;
		font-size: 12px;
		display: flex;
		flex-direction: column;
	}
	.calendarList{
		width: 40%;
		border: 1px solid black;
	}
	h4{
		margin: 0;
	}
	.calTdDiv{
		display: flex;
		flex-direction: column;
		width: 100%;
		height: 100%;
	}
	table.dayTable{
		height: auto !important;
	}
	td.monthTd{
	}
	td.monthDayTableTd{
	}
	div.title, .attTitle{
		font-weight: bold;
		font-size: 1rem;
		margin-top: 0.5rem;
	}
	.viewpop{
        font-size: 14px;
        width: 500px;
        border: 1px solid lightgray;
        position: fixed;
        top: 30px;
        left: 30px;
        background-color: white;
    }
    .viewheader{
        border-bottom: 1px solid lightgray;
        padding: 10px;
        font-size: 16px;
    }
    .viewcontent{
        padding: 10px;
    }
    .schName{
        font-weight: bold;
    }
    .row{
        margin-bottom: 10px;
    }
    .btns>input{
        padding: 2px 10px;
    }
    .data.schName{
        margin: 0;
    }
    .blurarea{
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
    }
    .closeBtn{
    	position: absolute;
    	top: 5px;
    	right: 5px;
    }
    .listpop{
	    position: fixed;
	    width: 150px;
	    border: 1px solid lightgray;
	    background-color: white;
	    font-size: 14px;
	    padding: 0.25rem;
	}
	.schedule{
		font-weight: bold;
		margin-left: 0.5rem;
		overflow: hidden;
	}
	.pop>div{
		word-break: break-all;
		padding-right: 30px;
	}
	.calTdDivDate{
		display: inline-block;
	}
	.calendarTitle{
		text-align: center;
	}
	span.dateSpan{
		font-size: 1rem;
		font-weight: bold;
		width: 25px;
		height: 25px;
		display: inline-block;
	    padding-left: 3px;
	    padding-top: 2px;
	}
	span.dateSpan.weekend{
		color: #989898;
	}
	span.dateSpan.today{
		color: white;
		background-color: tomato;
		border-radius: 50%;
	}
	div.calTdDiv.hasSch{
		background-color: #ff00004f;
	}
	.calendarTitle>*{
		font-size: 24px;
	}
	.calendarTitle>button{
		background-color: #ffffff00;
		border: none;
		cursor: pointer;
	}
	table.dayTable{
		font-size: 1rem;
		font-weight: bold;
		background-color: white;
	}
	table#paintArea, div.calendarList{
		background-color: white;
	}
	div.calendarList{
		background-color: white;
		padding: 5px;
		margin-left: 15px;
	}
	div.rowFlex{
		padding: 10px;
	}
</style>
<%
	AttendanceDao attendanceDao = new AttendanceDao();
	AttendanceDto attendanceDto = attendanceDao.find((int) session.getAttribute("check"));
	
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
	
	
	int emp_no = (int) session.getAttribute("check");

	String calType = "monthly";
	String date = request.getParameter("date");
	
	LocalDate tempDate = date==null ? LocalDate.now() : LocalDate.parse(date);
	LocalDate startOfCal = tempDate.withDayOfMonth(1);
	startOfCal = startOfCal.minusDays(startOfCal.getDayOfWeek().getValue());
	int index = 42;
	LocalDate endOfCal = startOfCal.plusDays(index);
	
	ScheduleDao scheduleDao = new ScheduleDao();
	TreeMap<LocalDate, List<ScheduleDto>> schMap = scheduleDao.select(emp_no, index, Timestamp.valueOf(startOfCal.atStartOfDay()), Timestamp.valueOf(endOfCal.atStartOfDay()));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
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
<div class="contentContainer rowFlex">
	<div class="calendarContainer">
		<div class="title">일정 관리</div>
		<div class="rowFlex">
			<div class="calendarArea">
				<div class="calendarTitle">
					<button class="prevNext" prev><</button>
					<span class="center date"></span>
					<button class="prevNext">></button>
				</div>
				<div>
					<table class="dayTable table table-border"></table>
				</div>
				<div class="calendarTable">
					<table class="table table-border" id="paintArea"></table>
				</div>
			</div>
			<div class="calendarList">
				<div class="title"></div>
				<div class="listArea"></div>
			</div>			
		</div>
	</div>
	<div class="boardListContainer">
	</div>
</div>
<div class="viewpop pop hide">
	<input type="button" class="closeBtn" value="X">
    <div class="viewheader">
        <div class="data schName"></div>
    </div>
    <div class="viewcontent">
        <div class="row rel ">
            <span>일시</span>
            <div class="data schDateTime"></div>
        </div>
        <div class="row rel ">
            <span>내용</span>
            <div class="data schContent" style="white-space:pre-wrap;"></div>
        </div>
        <div class="row rel ">
            <span>장소</span>
            <div class="data schPlace"></div>
        </div>
        <div class="row rel ">
            <span>작성자</span>
            <div class="data schWriter"></div>
        </div>
        <div class="row rel center btns">
            <input type="button" value="삭제" class="viewDelBtn">
            <input type="button" value="수정" class="viewEditBtn">
        </div>
    </div>
</div>
<script>
	document.querySelector(".attBtn.start").addEventListener("click", function(){
		location.href = "attendance/att_add.do?arrive";
	});
	document.querySelector(".attBtn.end").addEventListener("click", function(){
		location.href = "attendance/att_add.do<%if(isTrue){ %>?att_no=<%=attendanceDto.getAtt_no()%><%}%>";
	});
	//부모의 자식 엘리먼트 지우기
	function removeAllChild(parent) {
		while (parent.firstChild) {
			parent.removeChild(parent.firstChild);
		}
	}
	function getDateString(date, conn){
		var year = date.getFullYear();
		var month = (date.getMonth() + 1);
		month = month < 10 ? "0" + month : month;
		var day = date.getDate();
		day = day < 10 ? "0" + day : day;
		
		return year + conn + month + conn + day;
	}
	function newdiv(){
		var newdiv = document.createElement("div");
		return newdiv;
	}
	
	//커서 위치에 일정상세 팝업 열기
	function openpop(ele, zindex){
		ele.style.left = event.pageX+"px";
		ele.style.top = event.pageY+"px";
		ele.style.zIndex = zindex;
		ele.classList.remove("hide");
		
		var blurarea = newdiv();
		blurarea.style.zIndex = zindex - 1;
		blurarea.classList.add("blurarea");
        document.querySelector("main").append(blurarea);
        
        blurarea.addEventListener("click", function(){
			ele.classList.add("hide");
			this.remove();
        });
        
        ele.children[0].addEventListener("click", function(){
        	ele.classList.add("hide");
        	blurarea.remove();
        });
	}
	
	var calType = "<%=calType%>";
	var dayTable = document.querySelector(".dayTable");//날짜-요일 테이블
	var paintArea = document.querySelector("#paintArea");//캘린더 테이블
	var today = new Date();//오늘로 데이트 객체 생성
	var temp_date = new Date("<%=tempDate.toString()%>");//임시 데이트 객체 생성(날짜 계산용)
	var dayArr = ["일", "월", "화", "수", "목", "금", "토"];//요일 배열
	
	//이전, 다음 클릭 시 캘린더 타입에 맞게 날짜 변경
	document.querySelectorAll(".prevNext").forEach(function (ele) {
		ele.addEventListener("click", function () {
			var val = 1;
			if (this.hasAttribute("prev")) val = -1;
			temp_date.setDate(1);
			temp_date.setMonth(temp_date.getMonth() + val);
			var link = "main.jsp?date={date}";
			link = link.replace("{date}", getDateString(temp_date, "-"));
			location.href = link;
		});
	});
	
	function paintMonthly() {
		var dayTableRow = document.createElement("tr");

		var start = new Date(temp_date.getFullYear(), temp_date.getMonth(), 1);
		var dateString = getDateString(start, ".").substr(0, 7);
		start.setDate(1 - start.getDay());

		for (var i = 0; i < 6; i++) {
			var newTr = document.createElement("tr");
			for (var j = 0; j < 7; j++) {
				if (!dayTable.firstChild) {
					var dayTableTb = document.createElement("td");
					dayTableTb.classList.add("monthDayTableTd");
					dayTableRow.append(dayTableTb);
					
					var dayTableTdDiv = document.createElement("div");
					dayTableTb.append(dayTableTdDiv);
					dayTableTdDiv.innerHTML = dayArr[j];
				}
				var newTd = document.createElement("td");
				newTd.classList.add("monthTd");
				newTr.append(newTd);

				var calTdDiv = newdiv();
				newTd.append(calTdDiv);
				calTdDiv.classList.add("calTdDiv");
				calTdDiv.classList.add("cursor-pointer");
				
				var calTdDivDate = newdiv();
				calTdDiv.append(calTdDivDate);
				calTdDivDate.classList.add("calTdDivDate");
				
				var dateSpan = document.createElement("span");
				calTdDivDate.append(dateSpan);
				dateSpan.classList.add("dateSpan");
				dateSpan.classList.add("cursor-pointer");
				if(getDateString(start, "-") == getDateString(today, "-")) dateSpan.classList.add("today");
				if(start.getDay()==0 || start.getDay()==6) dateSpan.classList.add("weekend");
				dateSpan.innerText = start.getDate();
				
				start.setDate(start.getDate() + 1);
			}
			dayTable.append(dayTableRow);
			paintArea.append(newTr);
		}
		document.querySelector(".date").innerHTML = dateString;
	};
	
	paintMonthly();
	
<%
	int i = 0;
	for(LocalDate key : schMap.keySet()){
		List<ScheduleDto> schList= schMap.get(key);%>
		
		var calTdDivDate = document.querySelectorAll(".calTdDivDate")[<%=i%>];
		calTdDivDate.addEventListener("click", function(){
			location.href = "calendar/sch_add.jsp?date=<%=key.toString()%>";
		});
		
		var calTdDiv = calTdDivDate.parentElement;
		<%if(schList.size()>0){%>
			calTdDiv.classList.add("hasSch");
		<%}%>
		calTdDiv.addEventListener("click", function(){
			var calendarList = document.querySelector(".calendarList");
			calendarList.children[0].innerText = "<%=LocalDate.now().toString().equals(key.toString()) ? "TODAY" : key.toString()%>";
			
			var listArea = calendarList.children[1];
			removeAllChild(listArea);
			var newUl = document.createElement("ul");
			listArea.append(newUl);
			var newLi = document.createElement("li");
			newLi.innerText = "일정이 없어요";
			newUl.append(newLi);
			var i=0;
			<%
			for(ScheduleDto schDto : schList){%>
				if(i==0) removeAllChild(newUl);
				var newLi = document.createElement("li");
				newUl.append(newLi);
				newLi.classList.add("cursor-pointer");
				newLi.innerText = "<%=schDto.getSch_name()%>";
				
				newLi.addEventListener("click", function(){
					var viewpop = document.querySelector(".viewpop");
					openpop(viewpop, 200);
					document.querySelector(".schName").innerText = "<%=schDto.getSch_name()%>";
					document.querySelector(".schDateTime").innerText = "<%=sdf.format(schDto.getSch_start())+" - "+sdf.format(schDto.getSch_end())%>";
					document.querySelector(".schContent").innerHTML = "<%=schDto.getSch_content()%>";
					document.querySelector(".schPlace").innerText = "<%=schDto.getSch_place()%>";
					document.querySelector(".schWriter").innerText = "<%=new EmployeeDao().find(schDto.getEmp_no()).getEmp_name()%>";						
					
					document.querySelector(".viewDelBtn").addEventListener("click", function(){
						location.href = "sch_del.do?only&calType=<%=calType%>&date=<%=key.toString()%>&sch_no=<%=schDto.getSch_no()%>";
					});
					document.querySelector(".viewEditBtn").addEventListener("click", function(){
						location.href = "sch_add.jsp?calType=<%=calType%>&edit&sch_no=<%=schDto.getSch_no()%>";
					});
				});
				
				i++;
			<%}%>
		});
		if(<%=tempDate.toString().equals(key.toString())%>)calTdDiv.click();
		<%i++;
	}
%>
</script>
<jsp:include page="/template/footer.jsp"></jsp:include> 