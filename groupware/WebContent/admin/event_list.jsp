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


<jsp:include page="/template/admin_header.jsp"></jsp:include>

<style>
	.hide {
    display: none;
	}
	
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
	
	.row.rel{
    position: relative;
	}
	
	.row.rel>span{
    position: absolute;
    top: 0;
    left: 0;
    font-size: 14px;
	}
	
	div{
		border: none;
	}
	
	.data{
    display: inline-block;
    margin-left: 60px;
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
		height: 50px;
		border: 1px dotted gray;
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
</style>

<%
	int emp_no = (int) session.getAttribute("check");

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
	startOfCal = tempDate.withDayOfMonth(1);
	startOfCal = startOfCal.minusDays(startOfCal.getDayOfWeek().getValue());
	int index = 42;
	endOfCal = startOfCal.plusDays(index);
	
	ScheduleDao scheduleDao = new ScheduleDao();
	TreeMap<LocalDate, List<ScheduleDto>> schMap = scheduleDao.selectForCom(index, Timestamp.valueOf(startOfCal.atStartOfDay()), Timestamp.valueOf(endOfCal.atStartOfDay()));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>

<div class="outbox" style="width:900px">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="일정 관리" class="headerImg" src="<%=request.getContextPath()%>/image/playlist_add.svg" width="30" height="30"> 
		<span>회사 일정 관리</span>	
	</div>    

	<div class="blurarea hide"></div>
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
					<table class="table table-border left" id="paintArea"></table>
				</div>
			</div>
		</div>
	</div>
	<div class="row right">
		<input type="button" class="input input-inline" value="일정 추가" id="event_add">
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

	//이전, 다음 클릭 시 캘린더 타입에 맞게 날짜 변경
	document.querySelectorAll(".prevNext").forEach(function (ele) {
		ele.addEventListener("click", function () {
			var val = 1;
			if (this.hasAttribute("prev")) val = -1;
			temp_date.setMonth(temp_date.getMonth() + val);		
			var link = "event_list.jsp?calType={calType}&year={year}&month={month}&day={day}";
			link = link.replace("{calType}", calType).replace("{year}", temp_date.getFullYear()).replace("{month}", (temp_date.getMonth()+1)).replace("{day}", temp_date.getDate());
			location.href = link;
		});
	});

	//캘린더 타입에 맞게 페인트 실행
	function paint(calType){
		removeAllChild(paintArea);
		removeAllChild(dayTable);
		paintMonthly();
		
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
	
	//페이지 로딩 시 달력 타입에 맞게 페인트 실행
	paint(calType);
	
	//일정추가 버튼 클릭 시 일정 추가 페이지로
	document.querySelector("#event_add").addEventListener("click", function(){
		location.href = "event_add_edit.jsp?date="+"<%=tempDate%>";
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
				location.href = "event_add_edit.jsp?date=<%=key.toString()%>";
			});			
		} else{
			document.querySelectorAll(".timeline").forEach(function(ele){
				ele.addEventListener("click", function(){
					location.href = "event_add_edit.jsp?date=<%=key.toString()%>&start_time="+this.innerText;
				});
			});
		}
		<%if(schList != null){
			for(ScheduleDto schDto : schList){%>
				var calTdDivSchList = calType=="daily" ? document.querySelectorAll(".calTdDivSchList")[<%=schDto.getSch_start().toLocalDateTime().toLocalTime().getHour()%>] : document.querySelectorAll(".calTdDivSchList")[<%=i%>];
				
				if(calTdDivSchList.children.length < 2){
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
						document.querySelector(".schContent").innerHTML = "<%=schDto.getSch_content()%>";
						document.querySelector(".schPlace").innerText = "<%=schDto.getSch_place()%>";
						document.querySelector(".schWriter").innerText = "<%=new EmployeeDao().find(schDto.getEmp_no()).getEmp_name()%>";						
						
						document.querySelector(".viewDelBtn").addEventListener("click", function(){
							location.href = "event_delete.do?sch_no=<%=schDto.getSch_no()%>";
						});
						document.querySelector(".viewEditBtn").addEventListener("click", function(){
							location.href = "event_add_edit.jsp?edit&sch_no=<%=schDto.getSch_no()%>";
						});
					});
				}
					
				if(calType == "monthly"){
					document.querySelectorAll(".listCount")[<%=i%>].innerText = "<%=schList.size() > 2 ? schList.size()-2 : ""%>";
				}
			<%
			}
		}
		i++;
	}
%>
</script>     	

<jsp:include page="/template/admin_footer.jsp"></jsp:include>	