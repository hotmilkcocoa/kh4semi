<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="groupware.beans.ScheduleDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.ScheduleDao"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	.calendarTdDiv{
		width: 100%;
		height: 100%;
		display: flex;
		flex-direction: column;
	}
</style>

<%
	//int emp_no = (int) session.getAttribute("check");
	int emp_no = 3;
	
	LocalDate startOfMonth = LocalDate.now().withDayOfMonth(1);
	LocalDate startOfCal = startOfMonth.minusDays(startOfMonth.getDayOfWeek().getValue());
	LocalDate endOfCal = startOfCal.plusDays(42);
	
	ScheduleDao scheduleDao = new ScheduleDao();
	HashMap<LocalDate, List<ScheduleDto>> schMap = scheduleDao.select(emp_no, Timestamp.valueOf(startOfCal.atStartOfDay()), Timestamp.valueOf(endOfCal.atStartOfDay()));
	
	
%>
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
		<input type="button" value="일정 추가" id="sch_add" href="sch_add.jsp">
	</div>
	<hr>
	<div class="calendar">
		<div class="timeLine">
			<ul>
				<li></li>
				<li>00시</li>
				<li>01시</li>
				<li>02시</li>
				<li>03시</li>
				<li>04시</li>
				<li>05시</li>
				<li>06시</li>
				<li>07시</li>
				<li>08시</li>
				<li>09시</li>
				<li>10시</li>
				<li>11시</li>
				<li>12시</li>
				<li>13시</li>
				<li>14시</li>
				<li>15시</li>
				<li>16시</li>
				<li>17시</li>
				<li>18시</li>
				<li>19시</li>
				<li>20시</li>
				<li>21시</li>
				<li>22시</li>
				<li>23시</li>
			</ul>
		</div>
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
            
            
<script>
	function removeAllChild(parent) {
		while (parent.firstChild) {
			parent.removeChild(parent.firstChild);
		}
	}

	var dayTable = document.querySelector(".dayTable");//날짜-요일 테이블
	var paintArea = document.querySelector("#paintArea");//캘린더 테이블
	var today = new Date();//오늘로 데이트 객체 생성
	var temp_date = new Date(today);//임시 데이트 객체 생성(날짜 계산용)
	var dayArr = ["일", "월", "화", "수", "목", "금", "토"];//요일 배열

	//캘린더 기본 타입 설정
	var calType = "monthly";

	//일간, 주간, 월간 버튼 클릭 시 캘린더 타입 변경
	document.querySelectorAll(".changeType").forEach(function (ele) {
		ele.addEventListener("click", function () {
			calType = this.getAttribute("id");
			paint(calType);
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
			paint(calType);
		});
	});

	// 오늘 클릭 시 오늘 날짜로 페인트
	document.querySelector(".today").addEventListener("click", function () {
		temp_date = new Date(today);
		paint(calType);
	});

	//캘린더 타입에 맞게 페인트 실행
	function paint(calType){
		removeAllChild(paintArea);
		removeAllChild(dayTable);
		if(calType == "monthly"){
			paintMonthly();
			document.querySelector(".timeLine").classList.add("hide");
		} else {
			if(calType == "weekly"){
				paintWeekly();
			} else{
				paintDaily();
			}
			document.querySelector(".timeLine").classList.remove("hide");
		}
	}

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
				var calendarTdDiv = document.createElement("div");
				calendarTdDiv.classList.add("calendarTdDiv");
				newTd.append(calendarTdDiv);
				var calendarDate = document.createElement("div");
				calendarDate.innerText = start.getDate();
				
				calendarTdDiv.append(calendarDate);
				start.setDate(start.getDate() + 1);
				newTr.append(newTd);
			}
			dayTable.append(dayTableRow);
			paintArea.append(newTr);
		}
		document.querySelector(".date").innerHTML = dateString;
	};
	function paintWeekly() {
		var dayTableRow = document.createElement("tr");

		var start = new Date(temp_date);
		start.setDate(start.getDate() - start.getDay());
		var dateString = start.getFullYear() + "." + (start.getMonth() + 1) + "." + start.getDate() + "-";


		var newTr = document.createElement("tr");
		for (var i = 0; i < 7; i++) {
			var dayTableTb = document.createElement("td");
			dayTableTb.innerHTML = start.getDate() + " " + dayArr[i];
			dayTableRow.append(dayTableTb);
			dayTable.append(dayTableRow);

			var newTd = document.createElement("td");
			newTd.innerHTML = start.getDate();
			start.setDate(start.getDate() + 1);
			newTr.append(newTd);
		}
		paintArea.append(newTr);
		start.setDate(start.getDate() - 1);
		dateString = dateString + start.getFullYear() + "." + (start.getMonth() + 1) + "." + start.getDate();
		document.querySelector(".date").innerHTML = dateString;
	};
	function paintDaily() {
		var dayTableRow = document.createElement("tr");

		var start = new Date(temp_date);
		var dateString = start.getFullYear() + "." + (start.getMonth() + 1) + "." + start.getDate();

		var dayTableTb = document.createElement("td");
		dayTableTb.innerHTML = start.getDate() + " " + dayArr[start.getDay()];
		dayTableRow.append(dayTableTb);
		dayTable.append(dayTableRow);

		var newTr = document.createElement("tr");
		var newTd = document.createElement("td");
		newTd.innerHTML = temp_date.getDate();
		newTr.append(newTd);
		paintArea.append(newTr);
		document.querySelector(".date").innerHTML = dateString;
	};
	
	paint(calType);
	
	document.querySelector("#sch_add").addEventListener("click", function(){
		location.href = this.getAttribute("href");
		console.log(this);
	});
	
</script>
<jsp:include page="/template/footer.jsp"></jsp:include>  