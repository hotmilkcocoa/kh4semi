<%@page import="groupware.beans.CompanyDao"%>
<%@page import="groupware.beans.CompanyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int com_no = 1;

	CompanyDao companyDao = new CompanyDao(); 
	CompanyDto companyDto = companyDao.find(com_no); 

%>

<jsp:include page="/template/admin_header.jsp"></jsp:include>

<style>
	table span{
		font: 15px NanumGothic, sans-serif; 
	}
</style>

<script>
	$(function(){
		$(".edit-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/info_edit.jsp?com_no=<%=companyDto.getCom_no()%>";
		});
	});


</script>


<div class="outbox" style="width:900px;">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="회사정보" class="headerImg" src="<%=request.getContextPath()%>/image/flowchart_alt.svg" width="30" height="30"> 
		<span>회사 정보</span>	
	</div>

	<div class="row">
		<table class="table table-border">
			<tbody>
				<tr>
					<th width="20%">회사명</th>
					<td width="30%"><span><%=companyDto.getCom_name()%></span></td>
					<th width="20%">구분</th>
					<td width="30%"><span><%=companyDto.getCom_type()%></span></td> 
				</tr>
				<tr>
					<th>사업자등록번호</th>
					<%if(companyDto.getCom_registnum() != null){ %>
						<td><span><%=companyDto.getCom_registnum()%></span></td>
					<%}else{ %>
						<td></td>
					<%} %>
					<th>법인등록번호</th>
					<%if(companyDto.getCom_corpnum() != null){ %>
						<td><span><%=companyDto.getCom_corpnum()%></span></td>
					<%}else{ %>
						<td></td>
					<%} %>
				</tr>
				<tr>
					<th>대표자명</th>
					<td><span><%=companyDto.getCom_ceo()%></span></td>
					<th>전화번호</th>
					<td><span><%=companyDto.getCom_call()%></span></td>
				</tr>
				<tr>
					<th>업태</th>
					<td><span><%=companyDto.getCom_condition()%></span></td>
					<th>종목</th>
					<td><span><%=companyDto.getCom_event()%></span></td>
				</tr>
				<tr>
					<th>담당자명</th>
					<td><span><%=companyDto.getCom_emp()%></span></td>
					<th>전화번호</th>
					<td><span><%=companyDto.getCom_phone()%></span></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3" class="left"><span><%=companyDto.getCom_addr()%></span></td>
				</tr>
				<tr>
					<th>회사조직도</th>
					<td colspan="3" height="200"></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" class="right"><button class="edit-Btn">회사정보수정</button></td>
				</tr>
				
			</tfoot>
		</table>
	</div>

</div>    
    
<jsp:include page="/template/admin_footer.jsp"></jsp:include>