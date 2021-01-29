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

<script>
	$(function(){
		$("#cancle-Btn").click(function(e){
			e.preventDefault();
			
			if(confirm("정말 취소하시겠습니까?")){
				location.href = $(this).attr("href");
			}
		}); 

</script>

<div class="outbox" style="width:900px">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="사원정보수정" class="headerImg" src="<%=request.getContextPath()%>/image/edit.svg" width="30" height="30"> 
		<span>사원 정보 수정</span>	
	</div>

	<form action="<%=request.getContextPath()%>/employee/emp_edit.do" method="post" style="width:800px">
		<div class="row center">
			<input type="hidden" class="input" name="emp_auth" readonly value="<%=employeeDto.getEmp_auth()%>">	
			<input type="hidden" class="input" name="emp_state" readonly value="<%=employeeDto.getEmp_state()%>">	
			
			<table class="table">
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
						<th>이메일*</th>
						<td><input type="text" class="input" name="emp_email" value="<%=employeeDto.getEmp_email()%>"></td>					
					</tr>
					<tr>	
						<th>전화번호*</th>
						<td><input type="text" class="input" name="emp_phone" value="<%=employeeDto.getEmp_phone()%>"></td>
						<th>생년월일</th>
						<td><input type="text" class="input" readonly value="<%=employeeDto.getEmp_birth()%>"></td>						
					</tr>
					<tr> 
						<th>주소*</th>
						<td colspan="3"><input type="text" class="input" name="emp_addr" value="<%=employeeDto.getEmp_addr()%>"></td>					
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
						<th>기타사항*</th>
						<!-- 목록부분이 Null이면 표시 않기 -->
						<%if(employeeDto.getEmp_etc()!= null){ %>
						<td colspan="3"><textarea rows="3" name="emp_etc" class="input"><%=employeeDto.getEmp_etc()%></textarea></td>
						<%}else{ %>
						<td colspan="3"><textarea rows="3" name="emp_etc" class="input"></textarea></td>
						<%} %>					
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" class="right">
							<input type="submit" class="input input-inline" style="width:100px;" value="수정">
							<a href="<%=request.getContextPath()%>/employee/setting.jsp" id="cancle-Btn"><input type=button class="input input-inline" style="width:100px;" value="취소"></a>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</form>
	
</div>



<jsp:include page="/template/footer.jsp"></jsp:include>    
