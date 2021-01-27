<%@page import="java.time.LocalTime"%>
<%@page import="java.util.TreeMap"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="groupware.beans.ScheduleDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.ScheduleDao"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	div{
		border: none;
	}
	.calTdDiv{
		width: 100%;
		height: 100%;
		display: flex;
		flex-direction: column;
	}
	.calendar{
		font-size: 14px;
	}
	.monthTd{
		width: 140px;
		height: 100px;
	}
	.schedule{
		max-width: 130px;
		overflow: hidden;
	}
	.viewpop{
        font-size: 14px;
        width: 500px;
        border: 1px solid lightgray;
        position: fixed;
        top: 30px;
        left: 30px;
        z-index: 1000;
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
        z-index: 999;
    }
    .closeBtn{
    	position: absolute;
    	top: 5px;
    	right: 5px;
    }
    .timeline{
    	width: 70px;
    }
    .
</style>

<%
	//int emp_no = (int) session.getAttribute("check");
	int emp_no = 3;

	String calType = request.getParameter("calType")!=null ? request.getParameter("calType") : "monthly";
	
	int year, month, day;
	if(request.getParameter("year")!=null){
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		day = Integer.parseInt(request.getParameter("day"));		
	} else{
		year = 0;
		month = 0;
		day = 0;
	}
	
	LocalDate tempDate = year==0 ? LocalDate.now() : LocalDate.of(year, month, day);
	LocalDate startOfCal;
	LocalDate endOfCal;
	int index;
	if(calType.equals("monthly")){
		startOfCal = tempDate.withDayOfMonth(1);
		startOfCal = startOfCal.minusDays(startOfCal.getDayOfWeek().getValue());
		index = 42;
	} else if(calType.equals("weekly")){
		startOfCal = tempDate.minusDays(tempDate.getDayOfWeek().getValue()==7 ? 0 : tempDate.getDayOfWeek().getValue());
		index = 7;
	} else{
		startOfCal = tempDate;
		index = 1;
	}
	endOfCal = startOfCal.plusDays(index);
	
	ScheduleDao scheduleDao = new ScheduleDao();
	TreeMap<LocalDate, List<ScheduleDto>> schMap = scheduleDao.select(emp_no, index, Timestamp.valueOf(startOfCal.atStartOfDay()), Timestamp.valueOf(endOfCal.atStartOfDay()));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>
<div class="blurarea hide"></div>
<div class="scrollbox">
	<h1 class="center date"></h1>
	<input type="button" value="이전" class="prevNext" prev>
	<input type="button" value="다음" class="prevNext">
	<input type="button" value="오늘" class="today">
	<hr>
	<div>
		<input type="button" value="일간" id="daily" class="changeType">
		<input type="button" value="주간" id="weekly" class="changeType">
		<input type="button" value="월간" id="monthly" class="changeType">
		<input type="button" value="일정 추가" id="sch_add">
	</div>
	<hr>
	<div class="calendar">
		<div class="calendarContainer">
			<div>
				<table class="dayTable table table-border"></table>
			</div>
			<div class="calendarTable">
				<table class="table table-border" id="paintArea"></table>
			</div>
		</div>
	</div>
</div>
<div class="viewpop hide">
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
            <div class="data schContent"></div>
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
	//부모의 자식 엘리먼트 지우기
	function removeAllChild(parent) {
		while (parent.firstChild) {
			parent.removeChild(parent.firstChild);
		}
	}
	function newdiv(){
		var newdiv = document.createElement("div");
		return newdiv;
	}

	var dayTable = document.querySelector(".dayTable");//날짜-요일 테이블
	var paintArea = document.querySelector("#paintArea");//캘린더 테이블
	var today = new Date();//오늘로 데이트 객체 생성
	var temp_date = new Date("<%=tempDate.toString()%>");//임시 데이트 객체 생성(날짜 계산용)
	var dayArr = ["일", "월", "화", "수", "목", "금", "토"];//요일 배열

	//캘린더 기본 타입 설정
	var calType = "<%=calType%>";

	//일간, 주간, 월간 버튼 클릭 시 캘린더 타입 변경
	document.querySelectorAll(".changeType").forEach(function (ele) {
		ele.addEventListener("click", function () {
			var link = "calendar.jsp?calType={calType}&year={year}&month={month}&day={day}";
			link = link.replace("{calType}", this.getAttribute("id")).replace("{year}", temp_date.getFullYear()).replace("{month}", (temp_date.getMonth()+1)).replace("{day}", temp_date.getDate());
			location.href = link;
		});
	});

	//이전, 다음 클릭 시 캘린더 타입에 맞게 날짜 변경
	document.querySelectorAll(".prevNext").forEach(function (ele) {
		ele.addEventListener("click", function () {
			var val = 1;
			if (this.hasAttribute("prev")) val = -1;
			if (calType == "monthly") {
				temp_date.setMonth(temp_date.getMonth() + val);
			} else if (calType == "weekly") {
				temp_date.setDate(temp_date.getDate() + (val * 7));
			} else {
				temp_date.setDate(temp_date.getDate() + val);
			}
			var link = "calendar.jsp?calType={calType}&year={year}&month={month}&day={day}";
			link = link.replace("{calType}", calType).replace("{year}", temp_date.getFullYear()).replace("{month}", (temp_date.getMonth()+1)).replace("{day}", temp_date.getDate());
			location.href = link;
		});
	});

	// 오늘 클릭 시 오늘 날짜로 페인트
	document.querySelector(".today").addEventListener("click", function () {
		temp_date = new Date(today);
		var link = "calendar.jsp?calType={calType}&year={year}&month={month}&day={day}";
		link = link.replace("{calType}", calType).replace("{year}", temp_date.getFullYear()).replace("{month}", (temp_date.getMonth()+1)).replace("{day}", temp_date.getDate());
		location.href = link;
	});

	//캘린더 타입에 맞게 페인트 실행
	function paint(calType){
		removeAllChild(paintArea);
		removeAllChild(dayTable);
		if(calType == "monthly"){
			paintMonthly();
		} else if(calType == "weekly") {
			paintWeekly();
		} else{
			paintDaily();
		}
	}
	//월간 달력 칠하기 
	function paintMonthly() {
		var dayTableRow = document.createElement("tr");

		var start = new Date(temp_date.getFullYear(), temp_date.getMonth(), 1);
		var dateString = start.getFullYear() + "." + (start.getMonth() + 1);
		start.setDate(1 - start.getDay());

		for (var i = 0; i < 6; i++) {
			var newTr = document.createElement("tr");
			for (var j = 0; j < 7; j++) {
				if (!dayTable.firstChild) {
					var dayTableTb = document.createElement("td");
					dayTableTb.innerHTML = dayArr[j];
					dayTableRow.append(dayTableTb);
				}
				var newTd = document.createElement("td");
				newTd.classList.add("monthTd");
				newTr.append(newTd);

				var calTdDiv = newdiv();
				newTd.append(calTdDiv);
				calTdDiv.classList.add("calTdDiv");
				
				var calTdDivDate = newdiv();
				calTdDiv.append(calTdDivDate);
				calTdDivDate.classList.add("calTdDivDate");
				calTdDivDate.classList.add("cursor-pointer");
				calTdDivDate.innerText = start.getDate();
				
				var calTdDivSchList = newdiv();
				calTdDiv.append(calTdDivSchList);
				calTdDivSchList.classList.add("calTdDivSchList");
				
				var listCount = newdiv();
				calTdDiv.append(listCount);
				listCount.classList.add("listCount");
				listCount.classList.add("right");
				
				start.setDate(start.getDate() + 1);
			}
			dayTable.append(dayTableRow);
			paintArea.append(newTr);
		}
		document.querySelector(".date").innerHTML = dateString;
	};
	//주간 달력 칠하기
	function paintWeekly() {
		var start = new Date(temp_date);
		start.setDate(start.getDate() - start.getDay());
		var dateString = start.getFullYear() + "." + (start.getMonth() + 1) + "." + start.getDate() + "-";

		for(var i=0; i<7; i++){
			var dayRow = document.createElement("tr");
			paintArea.append(dayRow);
			dayRow.classList.add("dayRow");
			
			var calTdDivDate = document.createElement("td");
			dayRow.append(calTdDivDate);
			calTdDivDate.classList.add("calTdDivDate");
			calTdDivDate.classList.add("cursor-pointer");
			calTdDivDate.innerText = start.getDate() + " (" + dayArr[i] + ")";
			
			var schRow = document.createElement("tr");
			paintArea.append(schRow);
			schRow.classList.add("schRow");
			
			var weekTd = document.createElement("td");
			schRow.append(weekTd);
			weekTd.classList.add("weekTd");
			
			var weekTdDiv = newdiv();
			weekTd.append(weekTdDiv);
			weekTdDiv.classList.add("calTdDivSchList");
			weekTdDiv.classList.add("weekTdDiv");
			
			start.setDate(start.getDate() + 1);
		}
		
		start.setDate(start.getDate() - 1);
		dateString = dateString + start.getFullYear() + "." + (start.getMonth() + 1) + "." + start.getDate();
		document.querySelector(".date").innerHTML = dateString;
	};
	//일간 달력 칠하기
	function paintDaily() {
		var dayTableRow = document.createElement("tr");

		var start = new Date(temp_date);
		var dateString = start.getFullYear() + "." + (start.getMonth() + 1) + "." + start.getDate();

		var timelineTd = document.createElement("td");
		timelineTd.classList.add("timeline");
		dayTableRow.append(timelineTd);
		
		var dayTableTb = document.createElement("td");
		dayTableTb.innerHTML = start.getDate() + " " + dayArr[start.getDay()];
		dayTableRow.append(dayTableTb);
		dayTable.append(dayTableRow);
		
		<%for(int i=0; i<24; i++){%>
			var newTr = document.createElement("tr");
						
			var timelineTd = document.createElement("td");
			timelineTd.classList.add("timeline");
			timelineTd.classList.add("cursor-pointer");
			timelineTd.innerText = "<%=LocalTime.of(i, 0).toString()%>";	
			newTr.append(timelineTd);
			
			var dayTd = document.createElement("td");
			newTr.append(dayTd);
			dayTd.classList.add("dayTd");
			
			var dayTdDiv = newdiv();
			dayTd.append(dayTdDiv);
			dayTdDiv.classList.add("calTdDivSchList");
			dayTdDiv.classList.add("dayTdDiv");
			
			paintArea.append(newTr);
		<%}%>
		document.querySelector(".date").innerHTML = dateString;
	};
	
	//페이지 로딩 시 달력 타입에 맞게 페인트 실행
	paint(calType);
	
	//일정추가 버튼 클릭 시 일정 추가 페이지로
	document.querySelector("#sch_add").addEventListener("click", function(){
		location.href = "sch_add.jsp?date="+"<%=tempDate%>";
	});
	
	//커서 위치에 일정상세 팝업 열기
	function openpop(){
		var viewpop = document.querySelector(".viewpop");
        viewpop.style.left = event.pageX+"px";
        viewpop.style.top = event.pageY+"px";
        viewpop.classList.remove("hide");
        document.querySelector(".blurarea").classList.remove("hide");
	}
	//팝업 닫기
	function closepop(){
		document.querySelector(".viewpop").classList.add("hide");
		document.querySelector(".blurarea").classList.add("hide");
	};
	document.querySelector(".blurarea").addEventListener("click", closepop);
	document.querySelector(".closeBtn").addEventListener("click", closepop);
	
<%
	int i = 0;
	for(LocalDate key : schMap.keySet()){
		List<ScheduleDto> schList= schMap.get(key);%>
		
		if(calType!="daily"){
			document.querySelectorAll(".calTdDivDate")[<%=i%>].addEventListener("click", function(){
				location.href = "sch_add.jsp?date=<%=key.toString()%>";
			});			
		} else{
			document.querySelectorAll(".timeline").forEach(function(ele){
				ele.addEventListener("click", function(){
					location.href = "sch_add.jsp?date=<%=key.toString()%>&start_time="+this.innerText;
				});
			});
		}
		<%if(schList != null){
			for(ScheduleDto schDto : schList){%>
				var calTdDivSchList = calType=="daily" ? document.querySelectorAll(".calTdDivSchList")[<%=schDto.getSch_start().toLocalDateTime().toLocalTime().getHour()%>] : document.querySelectorAll(".calTdDivSchList")[<%=i%>];
				
				if(calTdDivSchList.children.length < 3){
					var newSch = document.createElement("div");
					calTdDivSchList.append(newSch);					
					newSch.classList.add("schedule");
					newSch.classList.add("cursor-pointer");
					newSch.innerText = "<%=schDto.getSch_name()%>";
					
					//일정 클릭 이벤트
					//팝업 내용 수정하고 열기
					newSch.addEventListener("click", function(){
						openpop();
						document.querySelector(".schName").innerText = "<%=schDto.getSch_name()%>";
						document.querySelector(".schDateTime").innerText = "<%=sdf.format(schDto.getSch_start())+" - "+sdf.format(schDto.getSch_end())%>";
						document.querySelector(".schContent").innerText = "<%=schDto.getSch_content()%>";
						document.querySelector(".schPlace").innerText = "<%=schDto.getSch_place()%>";
						document.querySelector(".schWriter").innerText = "<%=new EmployeeDao().find(schDto.getEmp_no()).getEmp_name()%>";						
						
						document.querySelector(".viewDelBtn").addEventListener("click", function(){
							location.href = "sch_del.do?only&sch_no=<%=schDto.getSch_no()%>";
						});
						document.querySelector(".viewEditBtn").addEventListener("click", function(){
							location.href = "sch_add.jsp?edit&sch_no=<%=schDto.getSch_no()%>";
						});
					});
				}
					
				if(calType == "monthly"){
					document.querySelectorAll(".listCount")[<%=i%>].innerText = "<%=schList.size() > 3 ? schList.size()-3 : ""%>";
				}
			<%
			}
		}
		i++;
	}
%>
</script>
<jsp:include page="/template/footer.jsp"></jsp:include>  