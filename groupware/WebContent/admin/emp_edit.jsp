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
		$("#cancle-Btn").click(function(e){
			e.preventDefault();
			
			if(confirm("정말 취소하시겠습니까?")){
				location.href = $(this).attr("href");
			}
		});
	});

</script>

<div class="outbox" style="width:900px">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="사원정보수정" class="headerImg" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg" width="30" height="30"> 
		<span>사원 정보 수정</span>	
	</div>

	<form action="<%=request.getContextPath()%>/admin/emp_edit.do" method="post" style="width:800px">
		<div class="row center">
			<table class="table">
				<tbody>
					<tr>
						<th>이름</th>
						<td><input type="text" class="input" readonly value="<%=employeeDto.getEmp_name()%>"></td>
						<th>아이디</th>
						<td><input type="text" class="input" readonly value="<%=employeeDto.getEmp_id()%>"></td>					
					</tr>
					<tr>	
						<th>사원번호[입사일]</th>
						<td><input type="text" class="input input-inline" name="emp_no" style="width:40px;" readonly value="<%=employeeDto.getEmp_no()%>"> [<%=employeeDto.getEmp_hiredate()%>]</td>
						<th>이메일</th>
						<td><input type="text" class="input" name="emp_email" value="<%=employeeDto.getEmp_email()%>"></td>					
					</tr>
					<tr>	
						<th>전화번호</th>
						<td><input type="text" class="input" name="emp_phone" value="<%=employeeDto.getEmp_phone()%>"></td>
						<th>생년월일</th>
						<td><input type="text" class="input" readonly value="<%=employeeDto.getEmp_birth()%>"></td>						
					</tr>
					<tr> 
						<th>주소</th>
						<td colspan="3"><input type="text" class="input" name="emp_addr" value="<%=employeeDto.getEmp_addr()%>"></td>					
					</tr>
					<tr>
						<th width="20%">부서</th>
						<td width="30%"><input type="text" class="input" name="emp_dep" value="<%=employeeDto.getEmp_dep()%>"></td>	
						<th width="20%">직급</th>
						<td><input type="text" class="input" name="emp_title" value="<%=employeeDto.getEmp_title()%>"></td>					
					</tr>
					<tr>
						<th>급여</th>
						<td><input type="text" class="input" name="emp_salary" value="<%=employeeDto.getEmp_salary()%>"></td>	
						<th>사수(사원번호)</th>
						<td><input type="text" class="input" name="emp_manager_no" value="<%=employeeDto.getEmp_manager_no()%>"></td>					
					</tr>
					<tr>
						<th>권한</th>
						<td>
							<label><input type="radio" class="input input-inline" name="emp_auth" value="일반" checked>일반</label>
							<label><input type="radio" class="input input-inline" name="emp_auth" value="관리">관리</label>
						</td>	
						<th>상태</th>
						<td>
							<label><input type="radio" class="input input-inline" name="emp_state" value="정상" checked>정상</label>
							<label><input type="radio" class="input input-inline" name="emp_state" value="휴가">휴가</label>
							<label><input type="radio" class="input input-inline" name="emp_state" value="미사용">미사용</label>
						</td>					
					</tr>
					<tr>
						<th>기타사항</th>
						<td colspan="3"><textarea rows="3" name="emp_etc" class="input"><%=employeeDto.getEmp_etc()%></textarea></td>					
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" class="right">
							<input type="submit" class="input input-inline" style="width:100px;" value="수정">
							<a href="<%=request.getContextPath()%>/admin/emp_detail.jsp?emp_no=<%=employeeDto.getEmp_no()%>" id="cancle-Btn"><input type=button class="input input-inline" style="width:100px;" value="취소"></a>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</form>
	
</div>







<jsp:include page="/template/admin_footer.jsp"></jsp:include>    