<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<%
	//int emp_no = (int)request.getSession().getAttribute("check");
	int emp_no = 1;
	int rn = Integer.parseInt(request.getParameter("rn"));
	String box = request.getParameter("box");
	MessageDao msgDao = new MessageDao();
	MessageDto msgDto = new MessageDto();
	int count;
	if(box == null) {
		msgDto = msgDao.rnFind(emp_no, rn);
		count = msgDao.getCount(emp_no);
		
	} else {
		msgDto = msgDao.rnFindSend(emp_no, rn);
		count = msgDao.getCountSend(emp_no);
	}
	
	Date time = msgDto.getMessage_time();
	Date today = new Date();
	String msg_time;
	SimpleDateFormat t = new SimpleDateFormat();
	if(today == time) {
		t = new SimpleDateFormat("HH:mm:ss");
		msg_time = t.format(time);
	} else {
		t = new SimpleDateFormat("yyyy-MM-dd");
		msg_time = t.format(time);
	}
	
	
%>
<script>
	$(function(){
		
		//답장버튼
		$("#reply-btn").click(function() {
			location.href="messageWrite.jsp?emp_no=<%=msgDto.getEmp_no()%>";
		});
		
		//전달버튼
		$("#pass-btn").click(function() {
			location.href="msg_pass.jsp?msg_no=<%=msgDto.getMessage_no()%>";
		})
	});
</script>
<div class="outbox">
	<div class="row" style="float:right;">
		<%if(rn != 1) {%>
			<%if(box == null) {%>
				<span><a href="msg_detail.jsp?rn=<%=rn-1%>">이전</a></span>
			<%} else {%>
				<span><a href="msg_detail.jsp?rn=<%=rn-1%>&box=<%=box%>">이전</a></span>
			<%} %>
		<% } %>
		
		<%if(box == null) {%>
			<span><a href="inbox.jsp">목록</a></span>
		<%} else { %>
			<span><a href="sentbox.jsp?box=<%=box%>">목록</a></span>
		<%} %>
		<%if(count != rn) {%>
			<%if(box == null) {%>
				<span><a href="msg_detail.jsp?rn=<%=rn+1%>">다음</a></span>
			<%} else { %>
				<span><a href="msg_detail.jsp?rn=<%=rn+1%>&box=<%=box%>">다음</a></span>
			<%} } %>
		
		
	</div>
	<div class="row">
		<table class="table">
			<tbody>
				<tr>
					<th width="20%">제목</th>
					<td>
						<input class="input" type="text" name="message_title" value=<%=msgDto.getMessage_title() %> readonly>
					</td>
				</tr>
				<tr>
				<%if(box != null) {%>
					<th>보낸사람</th>
				<%} else {%>
					<th>받는사람</th>
					<%} %>
					<td>
						<input class="input" type="text" name="emp_name" value="<%=msgDto.getEmp_name() %> <%=msgDto.getEmp_title()%>" readonly>
					</td>
				</tr>
				<tr>
					<th>보낸날짜</th>
					<td>
						<input class="input" type="text" name="message_time" value=<%=msg_time%> readonly>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea class="input" readonly rows="10"><%=msgDto.getMessage_content() %></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="row center">
			<input type="button" class="input input-inline" id="reply-btn" value="답장">
			<input type="button" class="input input-inline" id="pass-btn"value="전달">
		</div>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>