<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@page import="groupware.beans.DataSettingDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.DataSettingDao"%>
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
	DataSettingDao dataSettingDao = new DataSettingDao(); 
	List<DataSettingDto> depList = dataSettingDao.depSelect(startRow, endRow);
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
	int count = dataSettingDao.getCount();
	
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
		<img alt="조직정보" class="headerImg" src="<%=request.getContextPath()%>/image/flowchart_alt.svg" width="30" height="30"> 
		<span>조직 관리</span>	
	</div>

	<div class="row">
		<table class="table table-border">
			<tbody>
				<tr>
					<th width="15%">부서번호</th>
					<th>부서이름</th>
					<th width="30%">부서장</th>
					<th width="20%">수정</th>
				</tr>
				<%for(DataSettingDto dataSettingDto : depList){ %>
				<tr>
					<td><%=dataSettingDto.getDep_no()%></td>
					<td><%=dataSettingDto.getDep_name()%></td>
					<%if(dataSettingDto.getDep_head() != null){ %>
					<td><%=dataSettingDto.getDep_head()%></td>
					<td><button class="input edit-Btn" onclick="location.href='<%=request.getContextPath()%>/admin/group_edit.jsp?dep_no=<%=dataSettingDto.getDep_no()%>'">수정</button></td>
					<%}else{ %>
					<td></td>
					<td><button class="input add-Btn" onclick="location.href='<%=request.getContextPath()%>/admin/group_add.jsp?dep_no=<%=dataSettingDto.getDep_no()%>'">추가</button></td>
					<%} %>
				</tr>
				<%} %>
			</tbody>	
		</table>
	</div>
	
	<!-- 페이지 네비게이션 -->
	<div class="row center">
		<ul class="pagination">
			<li><a href="group.jsp?p=<%=startBlock-1%>">&lt;</a></li>
			
				<%for(int i=startBlock; i<=endBlock; i++){ %>
					<%if(i==p){ %>
						<li class="active">
					<%}else{ %>
						<li>
					<%} %>
						<!-- 목록용 링크 -->
						<a href="group.jsp?p=<%=i%>"><%=i%></a>
						</li>
				<%} %>
			
			<li><a href="group.jsp?p=<%=endBlock+1%>">&gt;</a></li>
		</ul>
	</div>

</div>    
    
<jsp:include page="/template/admin_footer.jsp"></jsp:include>