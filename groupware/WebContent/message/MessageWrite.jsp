<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String emp_no = request.getParameter("emp_no");
	List<EmployeeDto> empList = new ArrayList<>();
	EmployeeDao empDao = new EmployeeDao();
	EmployeeDto empDto = new EmployeeDto();
	String[] m_emp_no = new String[]{};
	String[] emp_name = new String[]{};
	boolean isCheck = emp_no != null;
	if(isCheck) {
		m_emp_no = emp_no.split(",");
		int[] emp_no_m = new int[m_emp_no.length];

		for(int i = 0; i < emp_no_m.length; i++) {
			emp_no_m[i] = Integer.parseInt(m_emp_no[i]);
			empDto = empDao.find(emp_no_m[i]);
			empList.add(empDto);
		}
	
		emp_name = new String[empList.size()];
		int size = 0;
		for(EmployeeDto dto : empList) {
			emp_name[size++] = dto.getEmp_name();
		}
		
	} else {
		
	}
	
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	
	$(function() {
		<%if(isCheck) {  %>		
		var array = new Array();
		<%for(int i = 0; i < emp_name.length; i++) {%>
		array.push(
			"<%=emp_name[i]%>"
		);
		<%} %>
			 console.log(array);
		$("#msg_receiver").val(array);
		<% } else {%>
			$("#msg_receiver").val("");
		<% }%>
		$("#search-btn").click(function() {
			window.open("search.jsp", "사원검색", "width=700px, height=600px");
		});
	});
</script>
<div class="outbox" style="width:700px;">

	<div class="row">
		<form action="insert.do" method="post">
			<table class="table table-board">
				<tbody>
					<tr>
						<th width="20%">제목</th>
						<td>
							<input type="text" name="message_title" placeholder="제목을 입력하세요" class="input">
						</td>
					</tr>
					<tr>
						<th>받는사람</th>
						<td>
							<input name="msg_receiver" type="text" class="input" id="msg_receiver" style="display:inline; width:90%; float:left;" required>
							<input type="button" id="search-btn" class="input" value="검색" style="diplay:inline; width:10%; float:left;">
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
						<!--  enctype="multipart/form-data" -->
							<input type="file" class="input">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea class="input" rows="15"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="row center">
				<input type="button" class="input input-inline" value="취소" onclick="history.back();">
				<input type="text" name="emp_no" value=<%=emp_no%>>
				<input type="submit" class="input input-inline" value="전송">
			</div>
		</form>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>