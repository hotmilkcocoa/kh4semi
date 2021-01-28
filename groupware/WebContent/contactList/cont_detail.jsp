<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int cont_no = Integer.parseInt(request.getParameter("cont_no"));
	ContactListDao contDao = new ContactListDao();
	ContactListDto contDto = contDao.find(cont_no);

%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	$(function(){
		$("#edit-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/contactList/cont_edit.jsp?cont_no=<%=cont_no%>";
		});
		
		$("#submit_btn").click(function(e){
			if(confirm("삭제하시겠습니까?")) {
				document.form.target = opener.name;
				document.form.submit();
				self.close();
			}
		});
	});

	
</script>
<div class="outbox">
	<div class="row">
		<table class="table">
			<tbody>
				<tr>
					<th width="20%">이름</th>
					<td>
						<input class="input" type="text" name="cont_name" value="<%=contDto.getCont_name()%>" readonly>
					</td>
				</tr>
				<tr>
					<th>회사</th>
					<td>
						<input class="input" type="text" name="cont_corp" value="<%=contDto.getCont_corp()%>" readonly>
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						<input class="input" type="text" name="cont_phone" value="<%=contDto.getCont_phone()%>" readonly>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input class="input" type="email" name="cont_email" value="<%=contDto.getCont_email()%>" readonly>
					</td>
				</tr>
				<tr>
					<th>메모</th>
					<td>
						<textarea class="input" rows="10" name="cont_memo" readonly><%=contDto.getCont_memo()%></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		</div>
		
		<form action="delete.do" method="get" name="form">
			<input type="hidden" value="<%=cont_no%>" name="cont_no">
		</form>
		
		<div class="row center" >
			<input type="button" value="취소" onclick="window.close()" class="input input-inline">
			<input type="button" value="수정" class="input input-inline" id="edit-btn">
			<input type="button" value="삭제" id ="submit_btn" class="input input-inline">
		</div>
		
</div>