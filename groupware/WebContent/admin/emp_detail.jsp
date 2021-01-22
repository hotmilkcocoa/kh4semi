<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int emp_no = Integer.parseInt(request.getParameter("emp_no"));

	EmployeeDao employeeDao = new EmployeeDao();
	EmployeeDto employeeDto = employeeDao.find(emp_no); 
%>


<jsp:include page="/template/admin_header.jsp"></jsp:include>

<script>
	$(function(){
		$("#delete-Btn").click(function(e){
			e.preventDefault();
			
			if(confirm("정말 지우시겠습니까?")){
				location.href = $(this).attr("href");
			}
		});
	});


</script>

<div class="outbox" style="width:900px">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="사원정보" class="headerImg" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg" width="30" height="30"> 
		<span>사원 정보</span>	
	</div>

	<div class="row center" style="width:800px">
		<table class="table table-border">
			<tbody>
				<tr>
					<th>이름</th>
					<td><%=employeeDto.getEmp_name()%></td>
					<th>아이디</th>
					<td><%=employeeDto.getEmp_id()%></td>					
				</tr>
				<tr>	
					<th>사원번호[입사일]</th>
					<td><%=employeeDto.getEmp_no()%> [<%=employeeDto.getEmp_hiredate()%>]</td>
					<th>이메일</th>
					<td><%=employeeDto.getEmp_email()%></td>					
				</tr>
				<tr>	
					<th>전화번호</th>
					<td><%=employeeDto.getEmp_phone()%></td>
					<th>생년월일</th>
					<td><%=employeeDto.getEmp_birth()%></td>						
				</tr>
				<tr> 
					<th>주소</th>
					<td colspan="3"><%=employeeDto.getEmp_addr()%></td>					
				</tr>
				<tr>
					<th width="20%">부서</th>
					<td width="30%"><%=employeeDto.getEmp_dep()%></td>	
					<th width="20%">직급</th>
					<td><%=employeeDto.getEmp_title()%></td>					
				</tr>
				<tr>
					<th>급여</th>
					<td><%=employeeDto.getEmp_salary()%></td>	
					<th>사수(사원번호)</th>
					<td><%=employeeDto.getEmp_manager_no()%></td>					
				</tr>
				<tr>
					<th>권한</th>
					<td><%=employeeDto.getEmp_auth()%></td>	
					<th>상태</th>
					<td><%=employeeDto.getEmp_state()%></td>					
				</tr>
				<tr>
					<th>기타사항</th>
					<!-- 목록부분이 Null이면 표시 않기 -->
					<%if(employeeDto.getEmp_etc()!= null){ %>
					<td colspan="3">
						<textarea rows="5" name="emp_etc" class="input" 
						readonly><%=employeeDto.getEmp_etc()%></textarea>
					</td>					
					<%}else{ %>
					<td colspan="3">
						<textarea rows="5" name="emp_etc" class="input" 
						readonly></textarea>
					</td>	
					<%} %>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" class="right">
						<a href="<%=request.getContextPath()%>/admin/emp_edit.jsp?emp_no=<%=employeeDto.getEmp_no()%>" id="edit-Btn"><input type=button  class="input input-inline" style="width:100px;" value="수정"></a>
						<a href="<%=request.getContextPath()%>/admin/employee.jsp"><input type=button id="list-Btn" class="input input-inline" style="width:100px;" value="목록"></a>
						<a href="<%=request.getContextPath()%>/admin/emp_delete.do?emp_no=<%=employeeDto.getEmp_no()%>" id="delete-Btn"><input type=button class="input input-inline" style="width:100px;" value="삭제"></a>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>

</div>







<jsp:include page="/template/admin_footer.jsp"></jsp:include>

