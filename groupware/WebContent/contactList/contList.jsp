<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
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
	String key = request.getParameter("key");
	
	ContactListDao contDao = new ContactListDao();
	List<ContactListDto> contList = new ArrayList<>();
	
	boolean isSearch = key != null;
	
	if(isSearch) {
		contList = contDao.pagination(emp_no, key, startRow, endRow);
	} else {
		contList = contDao.pagination(emp_no, startRow, endRow);
	}
	
%>

<%
	int blockSize = 10;
		
	int startBlock = (p-1) / blockSize * blockSize +1;
	int endBlock = startBlock + blockSize -1;

	int count;
	if(isSearch) {
		count = contDao.searchCount(emp_no, key);
	} else {
		count = contDao.selectCount(emp_no);
	}
	
	int pageSize = (count + viewSize -1) / viewSize;
	if(endBlock > pageSize) {
		endBlock = pageSize;
	}
%>

<script>
	window.name="mainWin";

	 
	$(function () {
		$("#add_cont").click(function(){
			window.open("cont_add.jsp", "주소록추가", "width=700px, height=600px");
 		});
		
		var chkArray = new Array();
		$("#delete_btn").click(function(){
			if(window.confirm("삭제하시겠습니까?")) {
				$(".check-btn:checked").each(function(index, item){
					chkArray.push($(item).val());
				});
				$("#hiddenValue").val(chkArray);
				document.form.submit();
			}
			
		});
		
		$("#allCheck-btn").on("input", function(){
			var check = $(this).prop("checked");
			$(".check-btn").prop("checked", check);
		});

	})
</script>

<div class="outbox">
	<div class="row float-box">

	<div class="row" style="float:left;">
		<input type="button" value="주소록 추가" id="add_cont" class="input input-inline">
	</div>

	<div class="row" style="float:left;">
	<form action="delete.do" method="get" name="form">
		<input type="hidden" id="hiddenValue" name="cont_no">
		<input type="button" id="delete_btn" value="선택삭제" class="input input-inline">
	</form>
	</div>
	
	
	<form action="contList.jsp" method="get">
		<div class="row" style="float:right;">
			<input type="text" name="key" class="input input-inline" placeholder="검색어를 입력해주세요." required>
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
					<th>회사</th>
					<th>연락처</th>
					<th>이메일</th>
					<th width="30%">메모</th>
				</tr>
			</thead>
			<tbody>
			
				<%for(ContactListDto contDto : contList) { %>
					<tr>
						<td>
							<input type="checkbox" class="check-btn" value="<%=contDto.getCont_no() %>">
						</td>

						<td><a href="cont_detail.jsp?cont_no=<%=contDto.getCont_no()%>" onclick="window.open(this.href, 'detail', 'width=600, height=500'); return false;">
						<%=contDto.getCont_name()%></a></td>

						<td><%=contDto.getCont_corp()%></td>
						<td><%=contDto.getCont_phone()%></td>
						<td><%=contDto.getCont_email()%></td>
						<td><%=contDto.getCont_memo()%></td>
					</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	
	<!-- 페이지 네비게이션 -->
	<div class="row center">
			<ul class="pagination">
				<%if(isSearch) {%>
					<li><a href="contList.jsp?p=<%=startBlock-1%>&key=<%=key%>">&lt;</a></li>
				<% } else { %>
					<li><a href="contList.jsp?p=<%=startBlock-1%>">&lt;</a></li>
				<% } %>
				
				<%for(int i = startBlock; i <= endBlock; i++) {%>
						<%if(i == p) { %>
							<li class="active">
						<% } else { %>
							<li>
						<%} %>
						
						<%if(isSearch) {%>		
							<!-- 검색용 링크 -->
							<a href="contList.jsp?p=<%=i%>&key=<%=key%>"><%=i %></a>
						<%} else { %>
							<!-- 목록용 링크 -->
							<a href="contList.jsp?p=<%=i%>"><%=i%></a>
						<%} %>
						</li>
					<%} %>
				
				<%if(isSearch) {%>
					<li><a href="contList.jsp?p=<%=endBlock+1%>&key=<%=key%>">&gt;</a><li>
				<%} else { %>
					<li><a href="contList.jsp?p=<%=endBlock+1%>">&gt;</a><li>
				<%} %>
			</ul>
		</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>