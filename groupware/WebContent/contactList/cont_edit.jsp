<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

<%
	int cont_no = Integer.parseInt(request.getParameter("cont_no"));
	ContactListDao contDao = new ContactListDao();
	ContactListDto contDto = contDao.find(cont_no);

%>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
$(function() {

	$("#submit_btn").click(function(){
			document.form.target = opener.name;
			document.form.submit();
			self.close();
		
	});
});
</script>
<div class="outbox">
	<div class="row center">
		<h2>주소록 수정</h2>
	</div>
	<hr style="clear:both;">
	
	<div class="row">
			<form action="edit.do" method="post" name="form">
			<table class="table">
				<tbody>
					<tr>
						<th width="20%">이름</th>
						<td>
							<input type="hidden" name="cont_no" value="<%=contDto.getCont_no()%>">
							<input class="input" type="text" name="cont_name" value="<%=contDto.getCont_name()%>">
						</td>
					</tr>
					<tr>
						<th>회사</th>
						<td>
							<input class="input" type="text" name="cont_corp" value="<%=contDto.getCont_corp()%>">
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input class="input" type="text" name="cont_phone" value="<%=contDto.getCont_phone()%>">
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input class="input" type="email" name="cont_email" value="<%=contDto.getCont_email()%>">
						</td>
					</tr>
					<tr>
						<th>메모</th>
						<td>
							<textarea class="input" rows="10" name="cont_memo"><%=contDto.getCont_memo()%></textarea>
						</td>
					</tr>
				</tbody>
			</table>
	
			
		</form>
	</div>
	
	<div class="row center" >
				<input type="button" value="취소" onclick="window.close()" class="input input-inline">
				<input type="submit" value="수정하기" id ="submit_btn" class="input input-inline">
			</div>
</div>