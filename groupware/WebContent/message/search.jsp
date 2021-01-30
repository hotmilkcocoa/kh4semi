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
	
	int emp_no = (int)request.getSession().getAttribute("check");
	
	
	String keyword = request.getParameter("keyword");
	EmployeeDao empDao = new EmployeeDao();
	List<EmployeeDto> empList = new ArrayList<>();
	String opt = request.getParameter("opt");
	
	boolean isSearch = keyword != null;
	boolean isOpt = keyword != null && opt != null;

	
	EmpFavoriteDao favDao = new EmpFavoriteDao();
	List<EmpFavoriteDto> favList = new ArrayList<>();
	
	if(isSearch) {
		favList = favDao.fav_select(emp_no, keyword);
		empList = empDao.pagingList(startRow, endRow, keyword);
	} else {
		favList = favDao.fav_select(emp_no);
		empList = empDao.pagingList(startRow, endRow);
	}
%>

<%
	int blockSize = 10;
		
	int startBlock = (p-1) / blockSize * blockSize +1;
	int endBlock = startBlock + blockSize -1;

	int count;
	if(isSearch) { //검색할 때
		count = empDao.getCount(keyword);
	} else {
		count = empDao.getCount();
	}
	
	int pageSize = (count + viewSize -1) / viewSize;
	if(endBlock > pageSize) {
		endBlock = pageSize;
	}

%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<script>
	$(function() {
		//전체선택
		$("#allCheck-btn").on("input", function(){
			var check = $(this).prop("checked");
			$(".check-btn").prop("checked", check);
		});
		
		//즐겨찾기 / 주소록 선택(select)
		$("#search-opt").change(function(){
			location.href= "<%=request.getContextPath()%>/message/search.jsp?opt="+$(this).val();
			if($(this).val() == 0) {
				location.href= "<%=request.getContextPath()%>/message/search.jsp";
			}
			
		});
		
		//검색버튼클릭시
		$("#search-btn").click(function(){
			if(<%=opt%> != null && <%=keyword%> != null) {
				location.href="<%=request.getContextPath()%>/message/search.jsp?opt=<%=opt%>";
			} else {
				location.href="<%=request.getContextPath()%>/message/search.jsp";
			}
		});
		
		//부모창으로 값 전달
		var noArray = new Array();
		var nameArray = new Array();
		$("#submit-btn").click(function(){
			$(".check-btn:checked").each(function(i){
				noArray.push($(this).data("no"));
				nameArray.push($(this).data("name"));
			});
		//부모창에 있는 empAdd라는 함수를 실행시키면서 chkArray를 전달(전송 아님)
		window.opener.parent.empAdd2(noArray);
		window.opener.parent.empAdd1(nameArray);
		self.close();
			
		/* $("#hiddenValue").val(chkArray);
		window.opener.name = "parentPage";
		document.form.target = "parentPage";
		document.form.submit();
		self.close(); */
	});
});
</script>

<div class="outbox">
	<div class="row center">
		<h1>사원검색</h1>
	</div>
	
	<hr>
	
		<div class="row">
			<select class="input input-inline" name="opt" id="search-opt">
				<option value="opt1" <%if(opt!=null&&opt.equals("opt1")){%> selected <%} %>>즐겨찾기</option>
				<option value="opt2" <%if(opt!=null&&opt.equals("opt2")){%> selected <%} %>>전체사원</option>
			</select>
		</div>
		
		<%if(opt == null || opt.equals("opt1")) { %>
			<div class="row">
				<div class="float-box">
					<div class="row" style="float:right;">
					<form action = "search.jsp" method="get">
						<%if(opt != null) {%>
							<input type="hidden" name="opt" value=<%=opt%>>
						<%} %>
							<input type="text" name="keyword" class="input input-inline" placeholder="이름을 검색하세요">
							<input type="submit" id="search-btn"  value="검색" class="input input-inline">
							</form>
					</div>
				</div>
				<table class="table table-border table-pattern">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="allCheck-btn">
							</th>
							<th>이름</th>
							<th>부서</th>
							<th>핸드폰번호</th>
							<th>이메일</th>
						</tr>
					</thead>
					<tbody>
						<%for(EmpFavoriteDto dto : favList) {%>
							<tr>
								<td>
									<input type="checkbox" class="check-btn" data-no=<%=dto.getFav_emp_no()%> data-name="<%=dto.getEmp_name()%>">
								</td>
								<td><%=dto.getEmp_name()%> <%=dto.getEmp_title()%></td>
								<td><%=dto.getEmp_dep()%></td>
								<td><%=dto.getEmp_phone()%></td>
								<td><%=dto.getEmp_email()%></td>
							</tr>
						<%} %>
					</tbody>
				</table>
			</div>
	<%} else if(opt.equals("opt2")){ %>
	<div class="row">
		<jsp:include page="/template/contactList.jsp"></jsp:include>
	</div>
		
	<%} %>
	<div class="row center"> 
		<form action="messageWrite.jsp" method="get" name="form">
			<input type="button" value="취소" onclick="window.close()" class="input input-inline">
			<input type="button" value="확인" id="submit-btn" class="input input-inline">
			<input type="hidden" id="hiddenValue" name="emp_no">
		</form>
	</div>
</div>
