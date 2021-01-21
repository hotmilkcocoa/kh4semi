<%@page import="groupware.beans.CompanyDto"%>
<%@page import="groupware.beans.CompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int com_no = Integer.parseInt(request.getParameter("com_no"));

	CompanyDao companyDao = new CompanyDao();
	CompanyDto companyDto = companyDao.find(com_no);
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
		<img alt="회사정보" class="headerImg" src="<%=request.getContextPath()%>/image/flowchart_alt.svg" width="30" height="30"> 
		<span>회사 정보 수정</span>	
	</div>

	<form action="group_edit.do" method="post">
		
		<input type="hidden" name="com_no" value="<%=companyDto.getCom_no()%>">
	
	<div class="row">
		<table class="table">
			<tbody>
				<tr>
					<th width="20%">회사명</th>
					<td width="30%"><input type="text" class="input" name="com_name" value="<%=companyDto.getCom_name()%>"></td>
					<th width="20%">구분</th>
					<td width="30%">
						<label><input type="radio" name="com_type" value="법인">법인</label>
						<label><input type="radio" name="com_type" value="개인">개인</label>
					</td> 
				</tr>
				<tr>
					<th>사업자등록번호</th>
						<%if(companyDto.getCom_registnum() != null){ %>
							<td><input type="text" class="input" name="com_registnum" value="<%=companyDto.getCom_registnum()%>"></td>
						<%}else{ %>
							<td><input type="text" class="input" name="com_registnum" value=""></td>
						<%} %>
					<th>법인등록번호</th>
						<%if(companyDto.getCom_corpnum() != null){ %>
							<td><input type="text" class="input" name="com_corpnum" value="<%=companyDto.getCom_corpnum()%>"></td>
						<%}else{ %>
							<td><input type="text" class="input" name="com_corpnum" value=""></td>
						<%} %>
				</tr>
				<tr>
					<th>대표자명</th>
					<td><input type="text" class="input" name="com_ceo" value="<%=companyDto.getCom_ceo()%>"></td>
					<th>전화번호</th>
					<td><input type="text" class="input" name="com_call" value="<%=companyDto.getCom_call()%>"></td>
				</tr>
				<tr>
					<th>업태</th>
					<td><input type="text" class="input" name="com_condition" value="<%=companyDto.getCom_condition()%>"></td>
					<th>종목</th>
					<td><input type="text" class="input" name="com_event" value="<%=companyDto.getCom_event()%>"></td>
				</tr>
				<tr>
					<th>담당자명</th>
					<td><input type="text" class="input" name="com_emp" value="<%=companyDto.getCom_emp()%>"></td>
					<th>전화번호</th>
					<td><input type="text" class="input" name="com_phone" value="<%=companyDto.getCom_phone()%>"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3"><input type="text" class="input" name="com_addr" value="<%=companyDto.getCom_addr()%>"></td>
				</tr>
				<tr>
					<th>회사조직도</th>
					<td colspan="3" height="150"></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" class="right">
					<input type="submit" value="수정">
					<button class="cancle-Btn">취소</button></td>
				</tr>
				
			</tfoot>
		</table>
	</div>
	</form>
</div>    
    
<jsp:include page="/template/admin_footer.jsp"></jsp:include>