<%@page import="groupware.beans.VacationDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.VacationDao"%>
<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//페이지 분할 계산 코드 작성
	int boardSize = 8;
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
	int emp_no = Integer.parseInt(request.getParameter("emp_no"));

	EmployeeDao employeeDao = new EmployeeDao();
	EmployeeDto employeeDto = employeeDao.find(emp_no);
	
	VacationDao vacationDao = new VacationDao();
	List<VacationDto> vacList = vacationDao.select(emp_no, startRow, endRow);
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
	int count = employeeDao.getCount();
	
	//페이지 개수 = (게시글수 + 9) / 10 = (게시글 수 + 페이지크기 -1) / 페이지크기
	int pageSize = (count + boardSize -1) / boardSize;
			
	if(endBlock > pageSize){
		endBlock = pageSize;
	}
%>
    
<jsp:include page="/template/admin_header.jsp"></jsp:include>

<style>
	.infobox label{
		font: bold 18px "";
		margin-left: 30px;
		margin-right: 20px;
	}
	.infobox input{
		margin-left: 30px;
		margin-right: 20px;
	}
	
</style>

<div class="outbox" style="width:900px;">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="휴직 사원 상세정보" class="headerImg" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg" width="30" height="30"> 
		<span>휴직 사원 상세정보</span>	
	</div>

	<div class="row infobox">
		<div class="row">
			<label>이 름 : <input type="text" class="input input-inline" readonly value="<%=employeeDto.getEmp_name()%>"></label>
			<label>전화번호 : <input type="text" class="input input-inline" readonly value="<%=employeeDto.getEmp_phone()%>"></label>
		</div>
		<div class="row">
			<label>이메일 : <input type="text" class="input input-inline" readonly value="<%=employeeDto.getEmp_email()%>"></label>
			<label>주 소 : <input type="text" class="input input-inline" readonly value="<%=employeeDto.getEmp_addr()%>"></label>
		</div>		
	</div>
	<hr>
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th>번호</th>
					<th>분류</th>
					<th>기간</th>
					<th>사유</th>
				</tr>
			</thead>
			<tbody>
				<%for(VacationDto vacationDto: vacList){ %>
				<tr>
					<td><%=vacationDto.getVac_no()%></td>
					<td><%=vacationDto.getVac_category()%></td>
					<td><%=vacationDto.getVac_start()%> ~ <%=vacationDto.getVac_end()%></td>
					<td><%=vacationDto.getVac_reason()%></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>

	<!-- 페이지 네비게이션 -->
	<div class="row center">
		<ul class="pagination">
			<li><a href="rest_detail.jsp?p=<%=startBlock-1%>">&lt;</a></li>
			
			<%for(int i=startBlock; i<=endBlock; i++){ %>
				<%if(i==p){ %>
					<li class="active">
				<%}else{ %>
					<li>
				<%} %>
					<!-- 목록용 링크 -->
					<a href="rest_detail.jsp?p=<%=i%>"><%=i%></a>
					</li>
			<%} %>
			
			<li><a href="rest_detail.jsp?p=<%=endBlock+1%>">&gt;</a></li>
		</ul>
	</div>

</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>