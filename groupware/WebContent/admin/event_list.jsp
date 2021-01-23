<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/template/admin_header.jsp"></jsp:include>

<style>
	.calendar {
    height: 400px;
    display: flex;
    flex-direction: row;
    width: 100%;
	}
	
	.calendarContainer {
    display: flex;
    flex-direction: column;
    width: 100%;
	}
	
	.calendarTable, table.dayTable, #paintArea {
    width: 100%;
    height: 100%;
	}
	
	.cursor-pointer{
    cursor: pointer;
	}
	
	.date_box{
	display : inline-block;
	width: 150px;
	}
</style>

<div class="outbox" style="width:900px">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="일정 관리" class="headerImg" src="<%=request.getContextPath()%>/image/playlist_add.svg" width="30" height="30"> 
		<span>회사 일정 관리</span>	
	</div>    

	<div class="row center">
		<button class="prevNext" prev>&lt;</button>
		<div class="row date_box">
			<span class="center date"></span>		
		</div>
		<button class="prevNext">&gt;</button>
		<input type="hidden" value="오늘" class="today">
		<hr>
		<div class="calendar">

			<div class="calendarContainer">
				<div>
					<table class="dayTable table table-border"></table>
				</div>
				<div class="calendarTable">
					<table class="table table-border cursor-pointer left" id="paintArea"></table>
				</div>
			</div>
		</div>
	</div>
	<div class="row right">
		<button class="input input-inline" id="event-add">일정추가</button>
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

	//캘린더 타입에 맞게 페인트 실행
	function paint(calType){
		removeAllChild(paintArea);
		removeAllChild(dayTable);
		paintMonthly();
		
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
					var dayTableTb = document.createElement("th");
					dayTableTb.innerHTML = dayArr[j];
					dayTableRow.append(dayTableTb);
				}
				var newTd = document.createElement("td");
				newTd.innerHTML = start.getDate();
				start.setDate(start.getDate() + 1);
				newTr.append(newTd);
			}
			dayTable.append(dayTableRow);
			paintArea.append(newTr);
		}
		document.querySelector(".date").innerHTML = dateString;
	};
	
	paint(calType);
	
	$(function(){
		$("#event-add").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/event_add.jsp";
		});
	});
</script>            	

<jsp:include page="/template/admin_footer.jsp"></jsp:include>	