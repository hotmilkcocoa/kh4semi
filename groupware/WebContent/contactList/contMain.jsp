<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int viewSize = 8;
	
	int p;
	
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
	
	//int emp_no = request.getSession().getAttribute("check");
	
	int emp_no = 1;
	String keyword = request.getParameter("keyword");
	
	//부서목록조회(select)
	DataSettingDao depDao = new DataSettingDao();
	List<DataSettingDto> depList = depDao.depSelect();
	
	//직원목록조회
	EmployeeDao empDao = new EmployeeDao();
	List<EmployeeDto> empList = new ArrayList<>();
	
	//부서이름조회(select 검색)
	String dep_no = request.getParameter("dep_no");
	DataSettingDto depDto = new DataSettingDto();
	if(dep_no != null) {
		int dep = Integer.parseInt(dep_no);
		depDto = depDao.find(dep);
	}
	String dep_name = depDto.getDep_name(); //dep_no로 부서이름 가져오기

	boolean isSearch = keyword != null;

	if(isSearch && dep_name == null) { //검색 후 목록 조회
		empList = empDao.pagingList(startRow, endRow, keyword);
	} else if(isSearch && dep_name != null) { //검색&부서이름선택 조회
		empList = empDao.pagingList(dep_name, startRow, endRow, keyword);
	} else if(dep_name != null) { //부서이름선택 조회
		empList = empDao.pagingList(dep_name, startRow, endRow);
	}
	else { //그냥 목록 조회
		empList = empDao.pagingList(startRow, endRow);
	}
%>

<%
	int blockSize = 10;
		
	int startBlock = (p-1) / blockSize * blockSize +1;
	int endBlock = startBlock + blockSize -1;

	int count;
	if(isSearch && dep_name == null) { //검색할 때
		count = empDao.getCount(keyword);
	} else if(isSearch && dep_name != null) { //검색&부서이름 선택조회
		count = empDao.getDepCount(dep_name, keyword);
	} else if(dep_name != null) { //부서이름만 조회 시
		count = empDao.getDepCount(dep_name);
	} else {
		count = empDao.getCount();
	}
	
	int pageSize = (count + viewSize -1) / viewSize;
	if(endBlock > pageSize) {
		endBlock = pageSize;
	}
	
	
	EmpFavoriteDao emp_favDao = new EmpFavoriteDao();
	List<EmpFavoriteDto> emp_favList = emp_favDao.select(emp_no);

 	int[] no = new int[emp_favList.size()];
 	int size = 0;
 	for(EmpFavoriteDto dto : emp_favList) {
 		no[size++] = dto.getFav_emp_no();
 	}
 	
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	.favCk+label {
		display: block;
		width:24px;
		height:24px;
		border:none;
		background: url('../image/nonfav.png') no-repeat 0 0px / contain;
		text-align: center !important;
	}
	
	.favCk:checked+label {
		background: url('../image/fav.png') no-repeat 0 0px / contain;
		text-align: center !important;
	}
	
	
	.favCk {
		display: none;
	}
</style>
<script>
	$(function () {
		
		//전체선택
		$("#allCheck-btn").on("input", function(){
			var check = $(this).prop("checked");
			$(".check-btn").prop("checked", check);
		});
	
		//쪽지보내기
		var chkArray = new Array();
		$("#message_write").click(function(){
				$(".check-btn:checked").each(function(i){
						chkArray.push($(this).val());
					});
				$("#hiddenValue").val(chkArray);
				document.form.submit();
			
		});
			
		//부서 선택 시 부서검색
		$("#dep_chooser").change(function(){
			location.href= "<%=request.getContextPath()%>/contactList/contMain.jsp?dep_no="+$(this).val();
			
			if($(this).val() == 0) {
				location.href= "<%=request.getContextPath()%>/contactList/contMain.jsp";
			}
			
			});

		//emp_fav에 해당 fav_emp_no 가 있다면! checked
		var check = $(".favCk").val();
		
		//check버튼을 누르면 insert / 해제하면 delete
		$(".favCk").click(function () {
			if($(this).prop("checked")) {
				location.href = "<%=request.getContextPath()%>/contactList/insert.do?fav_emp_no="+$(this).val();
			} else {
				
				location.href = "<%=request.getContextPath()%>/contactList/favDelete.do?fav_emp_no="+$(this).val();
			}
		})
			
	});		
			
	
</script>

<div class="outbox">
<% for(int m = 0; m < no.length; m++) {%>
<input type="hidden" class="hiddenCk" value="<%=no[m]%>">
<%} %>
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
		<form action="../message/MessageWrite.jsp" method="get" name="form">
			<input type="hidden" id="hiddenValue" name="emp_no">
			<input type="button" value="쪽지보내기" id="message_write" class="input input-inline">
			</form>
		</div>
		
		<form action="contMain.jsp" method="get">
		<div class="row" style="float:right;">
		<%if(dep_no != null)  {%>
			<input type="hidden" name="dep_no" value=<%=dep_no%>>
			<%} %>
			<%if(isSearch) {%>
				<input type="text" name="keyword" class="input input-inline" value="<%=keyword%>">
				<%} else { %>
				<input type="text" name="keyword" class="input input-inline" placeholder="검색어를 입력해주세요.">
				<%} %>
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
				<%for(EmployeeDto empDto : empList){%>
					<tr>
						<td>
							<input type="checkbox" class="check-btn" value="<%=empDto.getEmp_no() %>">
						</td>
						<td>
							<%=empDto.getEmp_name()%> <%=empDto.getEmp_title()%>
							
							<span style="display:inline-block"> 
								<input type="checkbox" id=<%=empDto.getEmp_no()%> class="favCk" name="fav_emp_no" value="<%=empDto.getEmp_no()%>"
								<%for(int h = 0; h < no.length; h ++) {%>
								<%if(no[h] == empDto.getEmp_no()){ %>
								checked
									<% }}%>
								>
								<label for=<%=empDto.getEmp_no() %>></label>
							</span>
						</td>
						<td><%=empDto.getEmp_dep()%></td>
						<td><%=empDto.getEmp_phone()%></td>
						<td><%=empDto.getEmp_email()%></td>
					</tr>
				<%}%>
				<%if(empList.isEmpty()) {%>
				<tr ><td colspan="5">검색결과가 존재하지 않습니다.</td></tr>
				<%} %>
			</tbody>
		</table>
	</div>
	
	<!-- 페이지 네비게이션 -->
	<div class="row center">
			<ul class="pagination">
				<% if(isSearch && dep_name == null) {%>
					<li><a href="contMain.jsp?p=<%=startBlock-1%>&keyword=<%=keyword%>">&lt;</a></li>
				<%} else if(isSearch && dep_name != null) {%>
					<li><a href="contMain.jsp?p=<%=startBlock-1%>&keyword=<%=keyword%>">&lt;</a></li>
				<%} else if(dep_name != null) {%>
					<li><a href="contMain.jsp?p=<%=startBlock-1%>">&lt;</a></li>
				<% } else { %>
					<li><a href="contMain.jsp?p=<%=startBlock-1%>">&lt;</a></li>
				<% } %>
				
				<%for(int i = startBlock; i <= endBlock; i++) { %>
						<%if(i == p) { %>
							<li class="active">
						<% } else { %>
							<li>
						<%} %>
						
						<%if(isSearch && dep_name == null) {%>		
							<!-- 검색용 링크 -->
							<a href="contMain.jsp?p=<%=i%>&keyword=<%=keyword%>"><%=i %></a>
						<%} else if(isSearch && dep_name != null){ %>
							<a href="contMain.jsp?p=<%=i%>&dep_no=<%=dep_no%>&keyword=<%=keyword%>"><%=i %></a>
						<%} else if(dep_name != null){ %>
							<a href="contMain.jsp?p=<%=i%>&dep_no=<%=dep_no%>"><%=i%></a>
						<%} else {%>
							<!-- 목록용 링크 -->
							<a href="contMain.jsp?p=<%=i%>"><%=i%></a>
						<%} %>
						</li>
					<%} %>
					
				<%if(isSearch && dep_name == null) {%>
					<li><a href="contMain.jsp?p=<%=endBlock+1%>&keyword=<%=keyword%>">&gt;</a><li>
				<%} else if(isSearch && dep_name != null){ %>
					<li><a href="contMain.jsp?p=<%=endBlock+1%>&dep_no=<%=dep_no%>&keyword=<%=keyword%>">&gt;</a><li>
				<%} else if(dep_name != null) { %>
					<li><a href="contMain.jsp?p=<%=endBlock+1%>&dep_no=<%=dep_no%>">&gt;</a><li>
				<%} else { %>
					<li><a href="contMain.jsp?p=<%=endBlock+1%>">&gt;</a><li>
				<%} %>
			</ul>
		</div>
		
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>