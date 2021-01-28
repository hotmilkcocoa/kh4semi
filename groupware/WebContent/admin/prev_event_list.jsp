<%@page import="groupware.beans.EmployeeDao"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.ScheduleDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.ScheduleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%
//페이지 분할 계산 코드 작성
	int boardSize = 10;
	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();
	}
	catch(Exception e){
		p = 1;
	}

	//p의 값에 따라 시작 row번호와 종료 row번호를 계산
	int endRow = p * boardSize;
	int startRow = endRow - boardSize +1;
%>

<%
	//목록, 검색을 위해 필요한 프로그래밍 코드
	//start : 시작일, end : 종료일
	
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	boolean isSearch = start !=null && end !=null;
	
	ScheduleDao scheduleDao = new ScheduleDao();
	List<ScheduleDto> scheduleDtoList; 

	if(isSearch){
		scheduleDtoList = scheduleDao.pagingList(start, end, startRow, endRow);
	}
	else{
		scheduleDtoList = scheduleDao.pagingList(startRow, endRow);
	}
%>

<%
	//페이지 네비게이터 계산 코드 작성
	//블록 크기를 설정
	int blockSize = 10;

	//페이지 번호에 따라 시작블록과 종료블럭을 계산
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + (blockSize - 1);

	//endBlock이 마지막 페이지 번호보다 크면 안된다
	//int count = 목록개수 or 검색개수
	int count;
	if(isSearch){
		count = scheduleDao.getCount(start, end);
	}
	else{
		count = scheduleDao.getCount();
	}
	
	//페이지 개수 = (게시글수 + 9) / 10 = (게시글 수 + 페이지크기 -1) / 페이지크기
	int pageSize = (count + boardSize -1) / boardSize;
			
	if(endBlock > pageSize){
		endBlock = pageSize;
	}
%>
  
<jsp:include page="/template/admin_header.jsp"></jsp:include>

<div class="outbox" style="width:900px;">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="지난일정관리" class="headerImg" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg" width="30" height="30">
		<span>지난일정 목록</span>
	</div>

	<div class="blurarea hide"></div>
	<!-- 검색 도구 -->
	<form action="prev_event_list.jsp" method="post">
		<div class="row right">
			<select name="type" class="input input-inline" required>
				<option value="sch_start">날짜</option>
			</select>
			<%if(isSearch){ %>
			<input type="text" name="start" class="input input-inline" placeholder="YYYYMMDD형태" value="<%=start%>" required>
			<input type="text" name="end" class="input input-inline" placeholder="YYYYMMDD형태" value="<%=end%>" required>
			<%} else { %>
			<input type="text" name="start" class="input input-inline" placeholder="YYYYMMDD형태" required>
			<input type="text" name="end" class="input input-inline" placeholder="YYYYMMDD형태" required>
			<%} %>
			<input type="submit" class="input input-inline" value="검색">
		</div>
	</form>

	<!-- 리스트 -->
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th width="10%">번호</th>
					<th width="40%">제목</th>
					<th width="30%">날짜</th>
					<th width="20%">장소</th>
				</tr>
			</thead>
			<tbody>
				<%for(ScheduleDto scheduleDto : scheduleDtoList){ %>
				<tr>
					<td><%=scheduleDto.getSch_no()%></td>
					<td><a href="event_detail.jsp?sch_no=<%=scheduleDto.getSch_no()%>"><%=scheduleDto.getSch_name()%></a></td>
					<td>
					<%
						SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
						String starttimeFormat = f.format(scheduleDto.getSch_start());
						String endtimeFormat = f.format(scheduleDto.getSch_end());
					%>
					<%=starttimeFormat%> ~ <%=endtimeFormat%>					
					</td>
					<td><%=scheduleDto.getSch_place()%></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>

	<!-- 페이지 네비게이션 -->
	<div class="row center">
		<ul class="pagination">
			<%if(isSearch){ %>
			<li><a href="prev_event_list.jsp?p=<%=startBlock-1%>&start=<%=start%>&end=<%=end%>">&lt;</a></li>
			<%}else{ %>
			<li><a href="prev_event_list.jsp?p=<%=startBlock-1%>">&lt;</a></li>
			<%} %>
			
			<%for(int i=startBlock; i<=endBlock; i++){ %>
			<%if(i==p){ %>
			<li class="active">
			<%}else{ %>
			<li>
			<%} %>
				<%if(isSearch){ %>
				<!-- 검색용 링크 -->
				<a href="prev_event_list.jsp?p=<%=i%>&start=<%=start%>&end=<%=end%>"><%=i%></a>
				<%}else{ %>	
				<!-- 목록용 링크 -->
				<a href="prev_event_list.jsp?p=<%=i%>"><%=i%></a>
				<%} %>
			</li>
			<%} %>
			
			<%if(isSearch){ %>
			<li><a href="prev_event_list.jsp?p=<%=endBlock+1%>&start=<%=start%>&end=<%=end%>">&gt;</a></li>
			<%}else{ %>
			<li><a href="prev_event_list.jsp?p=<%=endBlock+1%>">&gt;</a></li>
			<%} %>
		</ul>
	</div>

</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>