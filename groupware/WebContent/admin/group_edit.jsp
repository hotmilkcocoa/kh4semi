<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@page import="groupware.beans.DataSettingDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.DataSettingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int dep_no = Integer.parseInt(request.getParameter("dep_no"));

	DataSettingDao dataSettingDao = new DataSettingDao(); 
	DataSettingDto dataSettingDto = dataSettingDao.find(dep_no);
	
	EmployeeDao employeeDao = new EmployeeDao();
	EmployeeDto employeeDto = employeeDao.find(dataSettingDto.getDep_head());
%>
    
<jsp:include page="/template/admin_header.jsp"></jsp:include>

<script>
	$(function(){
		$(".cancle-Btn").click(function(e){
			e.preventDefault();
			
			if(confirm("작업 중이던 내용이 사라집니다. 계속하시겠습니까?")){
				location.href = "<%=request.getContextPath()%>/admin/group.jsp";
			}
		});
	});


</script>


<div class="outbox" style="width:900px;">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="부서장정보수정" class="headerImg" src="<%=request.getContextPath()%>/image/flowchart_alt.svg" width="30" height="30"> 
		<span>부서장 정보 수정</span>	
	</div>

	<span><%=employeeDto.getEmp_name()%> <%=employeeDto.getEmp_title()%>[<%=employeeDto.getEmp_id()%>]을 선택하셨습니다.</span>
	
	<form action="group_edit.do" method="post">
		
		<input type="hidden" name="dep_no" value="<%=dataSettingDto.getDep_no()%>">
	
	<div class="row">
		<table class="table">
			<tbody>
				<tr>
					<th width="20%">부서명</th>
					<td width="30%"><input type="text" class="input" name="dep_name" value="<%=dataSettingDto.getDep_name()%>"></td>
					<th width="20%">부서장</th>
					<td width="30%">
						<input type="text" class="input" name="dep_head" value="<%=dataSettingDto.getDep_head()%>">
					</td> 
				</tr>
				
			<tfoot>
				<tr>
					<td colspan="4" class="right">
					<input type="submit" class="input input-inline" value="수정">
					<button class="cancle-Btn input input-inline">취소</button></td>
				</tr>
				
			</tfoot>
		</table>
	</div>
	</form>
</div>    
    
<jsp:include page="/template/admin_footer.jsp"></jsp:include>