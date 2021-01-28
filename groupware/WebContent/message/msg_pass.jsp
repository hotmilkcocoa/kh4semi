<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//int emp_no = (int)request.getSession().getAttribute("check");
	int emp_no = 1;
	int msg_no = Integer.parseInt(request.getParameter("msg_no"));
	
	MessageDao msgDao = new MessageDao();
	MessageDto msgDto = msgDao.find(msg_no);
	
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	
	$(function() {
		//검색버튼
		$("#search-btn").click(function() {
			window.open("search.jsp", "사원검색", "width=700px, height=600px");
		});
		
		//취소버튼
		$("#cancel-btn").click(function() {
			if(confirm("작성 중인 내용이 사라집니다. 취소하시겠습니까?")) {
				location.href="inbox.jsp"
			}
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
							<input type="text" name="message_title" placeholder="제목을 입력하세요" class="input" value=<%=msgDto.getMessage_title()%>>
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
							<textarea class="input" rows="15"><%=msgDto.getMessage_content()%></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="row center">
				<input type="button" class="input input-inline" value="취소" id="cancel-btn">
				<input type="hidden" name="emp_no" value=<%=emp_no%>>
				<input type="submit" class="input input-inline" value="전송">
			</div>
		</form>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>