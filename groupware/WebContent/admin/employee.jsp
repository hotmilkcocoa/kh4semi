<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

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
	//목록, 검색을 위해 필요한 프로그래밍 코드
	//type : 분류, keyword : 검색어
	
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	boolean isSearch = type!=null && keyword !=null;

	EmployeeDao employeeDao = new EmployeeDao();
	List<EmployeeDto> list;
	
	if(isSearch){
		//list = employeeDao.select(type, keyword);
		list = employeeDao.pagingList(type, keyword, startRow, endRow); 
	}
	else{
		//list = employeeDao.select();
		list = employeeDao.pagingList(startRow, endRow); 
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
		count = employeeDao.getCount(type, keyword);
	}
	else{
		count = employeeDao.getCount();
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
		<img alt="사원관리" class="headerImg" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg" width="30" height="30">
		<span>사원 관리</span>
	</div>
	
	<!-- 검색 도구 -->
	<form action="employee.jsp" method="post">
		<div class="row right">
			<select name="type" class="input input-inline" required>
				<option value="emp_no" <%if(type!=null&&type.equals("emp_no")){%>selected<%}%>>사번</option>
				<option value="emp_name" <%if(type!=null&&type.equals("emp_name")){%>selected<%}%>>이름</option>
				<option value="emp_dep" <%if(type!=null&&type.equals("emp_dep")){%>selected<%}%>>부서</option>
				<option value="emp_title" <%if(type!=null&&type.equals("emp_title")){%>selected<%}%>>직급</option>
				<option value="emp_auth" <%if(type!=null&&type.equals("emp_auth")){%>selected<%}%>>계정구분</option>
				<option value="emp_state" <%if(type!=null&&type.equals("emp_state")){%>selected<%}%>>계정상태</option>
			</select>
			<%if(isSearch){ %>
			<input type="text" name="keyword" class="input input-inline" placeholder="사원검색" value="<%=keyword%>" required>
			<%} else { %>
			<input type="text" name="keyword" class="input input-inline" placeholder="사원검색" required>
			<%} %>
			<input type="submit" class="input input-inline" value="검색">
		</div>
	</form>
	
	<!-- 리스트 -->
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th>사번</th>
					<th>이름</th>
					<th>부서</th>
					<th>직급</th>
					<th>계정구분</th>
					<th>계정상태</th>
				</tr>
			</thead>
			<tbody>
				<%for(EmployeeDto employeeDto : list){%>
				<tr>
					<td><%=employeeDto.getEmp_no()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/emp_detail.jsp?emp_no=<%=employeeDto.getEmp_no()%>"><%=employeeDto.getEmp_name()%></a></td>
					<td><%=employeeDto.getEmp_dep()%></td>
					<td><%=employeeDto.getEmp_title()%></td>
					<td><%=employeeDto.getEmp_auth()%></td>
					<td><%=employeeDto.getEmp_state()%></td>
				</tr>
				<%} %>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="6" class="right">
						<a href="<%=request.getContextPath()%>/admin/emp_add.jsp"><input type=button class="input input-inline" style="width:100px;" value="추가"></a>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
	
	<!-- 페이지 네비게이션 -->
	<div class="row center">
		<ul class="pagination">
			<%if(isSearch){ %>
			<li><a href="employee.jsp?p=<%=startBlock-1%>&type=<%=type%>&key=<%=keyword%>">&lt;</a></li>
			<%}else{ %>
			<li><a href="employee.jsp?p=<%=startBlock-1%>">&lt;</a></li>
			<%} %>
			
			<%for(int i=startBlock; i<=endBlock; i++){ %>
			<%if(i==p){ %>
			<li class="active">
			<%}else{ %>
			<li>
			<%} %>
				<%if(isSearch){ %>
				<!-- 검색용 링크 -->
				<a href="employee.jsp?p=<%=i%>&type=<%=type%>&key=<%=keyword%>"><%=i%></a>
				<%}else{ %>	
				<!-- 목록용 링크 -->
				<a href="employee.jsp?p=<%=i%>"><%=i%></a>
				<%} %>
			</li>
			<%} %>
			
			<%if(isSearch){ %>
			<li><a href="employee.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=keyword%>">&gt;</a></li>
			<%}else{ %>
			<li><a href="employee.jsp?p=<%=endBlock+1%>">&gt;</a></li>
			<%} %>
		</ul>
	</div>
	
	
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>
		