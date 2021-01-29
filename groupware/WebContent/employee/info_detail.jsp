<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int emp_no = (int)session.getAttribute("check");

	EmployeeDao employeeDao = new EmployeeDao();
	EmployeeDto employeeDto = employeeDao.find(emp_no); 
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<div class="outbox" style="width:900px">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="사원상세정보" class="headerImg" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg" width="30" height="30"> 
		<span>사원 상세 정보</span>	
	</div>

		<div class="row center">
			<table class="table table-border">
				<tbody>
					<tr>
						<th width="15%">이름</th>
						<td width="35%"><input type="text" class="input" readonly value="<%=employeeDto.getEmp_name()%>"></td>
						<th width="15%">아이디</th>
						<td><input type="text" class="input" readonly value="<%=employeeDto.getEmp_id()%>"></td>					
					</tr>
					<tr>	
						<th>사원번호</th>
						<td><input type="text" class="input" name="emp_no" readonly value="<%=employeeDto.getEmp_no()%>"></td>
						<th>이메일</th>
						<td><input type="text" class="input" name="emp_email" readonly value="<%=employeeDto.getEmp_email()%>"></td>					
					</tr>
					<tr>	
						<th>전화번호</th>
						<td><input type="text" class="input" name="emp_phone" readonly value="<%=employeeDto.getEmp_phone()%>"></td>
						<th>생년월일</th>
						<td><input type="text" class="input" readonly value="<%=employeeDto.getEmp_birth()%>"></td>						
					</tr>
					<tr> 
						<th>주소</th>
						<td colspan="3"><input type="text" class="input" name="emp_addr" readonly value="<%=employeeDto.getEmp_addr()%>"></td>					
					</tr>
					<tr>
						<th>부서</th>
						<td><input type="text" class="input" name="emp_dep" readonly value="<%=employeeDto.getEmp_dep()%>"></td>	
						<th>직급</th>
						<td><input type="text" class="input" name="emp_title" readonly value="<%=employeeDto.getEmp_title()%>"></td>		
					</tr>
					<tr>
						<th>급여</th>
						<td><input type="text" class="input" name="emp_salary" readonly value="<%=employeeDto.getEmp_salary()%>"></td>	
						<th>입사일</th>
						<td><input type="date" class="input" name="emp_hiredate" readonly value="<%=employeeDto.getEmp_hiredate()%>"></td>					
					</tr>					
					<tr>
						<th>기타사항</th>
						<!-- 목록부분이 Null이면 표시 않기 -->
						<%if(employeeDto.getEmp_etc()!= null){ %>
						<td colspan="3"><textarea rows="3" name="emp_etc" readonly class="input"><%=employeeDto.getEmp_etc()%></textarea></td>
						<%}else{ %>
						<td colspan="3"><textarea rows="3" name="emp_etc" readonly class="input"></textarea></td>
						<%} %>					
					</tr>
				</tbody>
			</table>
		</div>
	
</div>



<jsp:include page="/template/footer.jsp"></jsp:include> 