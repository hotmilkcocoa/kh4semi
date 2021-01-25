<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//페이지 분할, 네비게이터
	int viewSize = 8; // 한 페이지에 나올 목록 개수
	
	int p; // 페이지 번호
	
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();
	}
	catch(Exception e) {
		p = 1;
	}
	
	int endRow = p * viewSize;
	int startRow = endRow - viewSize + 1;
%>
<%
	request.setCharacterEncoding("UTF-8");

	//부서이름 조회(select)
	DataSettingDao depDao = new DataSettingDao();
	List<DataSettingDto> depList = depDao.depSelect();
	
	int dep_no = Integer.parseInt(request.getParameter("dep_no"));
	//부서이름 조회
	DataSettingDto depDto = depDao.find(dep_no);
	String dep_name = depDto.getDep_name();
	
	//사원목록 조회
	EmployeeDao empDao = new EmployeeDao();
	List<EmployeeDto> empList = new ArrayList<>();
	
	//검색어 받기
	String keyword = request.getParameter("keyword");
	
	boolean isDepSearch = dep_name != null && keyword != null;
	
	if(isDepSearch) {//부서이름과 검색어가 있다면
		empList = empDao.pagingList(dep_name, startRow, endRow, keyword);
	} else {
		empList = empDao.pagingList(dep_name, startRow, endRow);
	}
%>

<%
	int blockSize = 10;
		
	int startBlock = (p-1) / blockSize * blockSize +1;
	int endBlock = startBlock + blockSize -1;

	int count;
	if(isDepSearch) {
		count = empDao.getCount(keyword);
	} else {
		count = empDao.getDepCount(dep_name);
	}
	
	int pageSize = (count + viewSize -1) / viewSize;
	if(endBlock > pageSize) {
		endBlock = pageSize;
	}
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	$(function () {
		
		//전체선택
		$("#allCheck-btn").on("input", function(){
			var check = $(this).prop("checked");
			$(".check-btn").prop("checked", check);
		});
	
		//쪽지보내기
		$("#message_write").click(function(){
			location.href = "<%=request.getContextPath()%>/message/MessageWrite.jsp";
		});
		
		

		$("#dep_chooser").change(function(){
			location.href= "<%=request.getContextPath()%>/contactList/contMain_dep.jsp?dep_no="+$(this).val();
			if($(this).val() == 0) {
				location.href= "<%=request.getContextPath()%>/contactList/contMain.jsp";
			}
	});
})
</script>
<div class="outbox">
		<div class="row">
			<select class="input input-inline" name="dep_name" id="dep_chooser">
				<option value="0">부서검색</option>
				<%
					for(DataSettingDto dto : depList) {
				%>
					<option value="<%=dto.getDep_no()%>" <%if(dep_name!=null&&dep_name.equals(dto.getDep_name())){%>selected<%}%>><%=dto.getDep_name()%></option>
				<%
					}
				%>
			</select>
		</div>
		
	<div class="row float-box">
		<div class="row" style="float:left;">
			<input type="button" value="쪽지보내기" id="message_write" class="input input-inline">
		</div>


		<form action="contMain_dep.jsp" method="get">
		<div class="row" style="float:right;">
			<input type="hidden" name="dep_no" value=<%=dep_no%>>
			<input type="text" name="keyword" class="input input-inline" placeholder="검색어를 입력해주세요." required>
			<input type="submit" class="input input-inline" value="검색">
		</div>
	</form>
		
	</div>
	<div class="row">
		<table class="table table-border table-pattern">
			<thead>
				<tr>
					<th width="5%">
						<input type="checkbox" id="allCheck-btn">
					</th>
					<th>이름</th>
					<th>부서</th>
					<th>연락처</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(EmployeeDto empDto : empList) {
				%>
					<tr>
						<td>
							<input type="checkbox" class="check-btn">
						</td>
						<td><%=empDto.getEmp_name()%> <%=empDto.getEmp_title()%></td>
						<td><%=empDto.getEmp_dep()%></td>
						<td><%=empDto.getEmp_phone()%></td>
						<td><%=empDto.getEmp_email()%></td>
					</tr>
				<% } %>
			</tbody>
		</table>
	</div>
	
	<!-- 페이지 네비게이션 -->
	<div class="row center">
			<ul class="pagination">
				<%if(isDepSearch) {%>
					<li><a href="contMain_dep.jsp?p=<%=startBlock-1%>&keyword=<%=keyword%>">&it;</a></li>
				<% } else { %>
					<li><a href="contMain_dep.jsp?p=<%=startBlock-1%>">&it;</a></li>
				<% } %>
				
				<%for(int i = startBlock; i <= endBlock; i++) {%>
						<%if(i == p) { %>
							<li class="active">
						<% } else { %>
							<li>
						<%} %>
						
						<%if(isDepSearch) {%>		
							<!-- 검색용 링크 -->
							<a href="contMain_dep.jsp?p=<%=i%>&dep_no=<%=dep_no%>&keyword=<%=keyword%>"><%=i %></a>
						<%} else { %>
							<!-- 목록용 링크 -->
							<a href="contMain_dep.jsp?p=<%=i%>&dep_no=<%=dep_no%>"><%=i%></a>
						<%} %>
						</li>
					<%} %>
				
				<%if(isDepSearch) {%>
					<li><a href="contMain_dep.jsp?p=<%=endBlock+1%>&dep_no=<%=dep_no%>&keyword=<%=keyword%>">&gt;</a><li>
				<%} else { %>
					<li><a href="contMain_dep.jsp?p=<%=endBlock+1%>&dep_no=<%=dep_no%>">&gt;</a><li>
				<%} %>
			</ul>
		</div>
		
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>