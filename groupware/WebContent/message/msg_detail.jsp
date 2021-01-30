<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	int emp_no = (int)request.getSession().getAttribute("check");
	int	msg_no = Integer.parseInt(request.getParameter("msg_no"));  
	MessageDao msgDao = new MessageDao();
	
	
	//메세지 파일첨부
	MessageFileDao msg_FileDao = new MessageFileDao();
	MessageFileDto msg_FileDto = msg_FileDao.find(msg_no);
	
	boolean inFile = msg_FileDao.check(msg_no);
	MessageDto msgDto = msgDao.find(msg_no);
	
	int no = msgDao.boxCheck(msg_no);
	boolean isSend = emp_no == no; //받은쪽지함이라면
	boolean isReceive = emp_no != no;

	//이전 다음으로 이동하기 위한 msgList 생성
	int prev = 0;
	int next = 0;
	if(isSend) {
		prev = msgDao.prevSend(msg_no, emp_no);
		next = msgDao.nextSend(msg_no, emp_no);
		
		//메세지 읽음처리
		msgDao.readCk(msg_no);
		
		msgDto = msgDao.rnFind(emp_no, msg_no);
	} else if(isReceive) {
		prev = msgDao.prev(msg_no, emp_no);
		next = msgDao.next(msg_no, emp_no);
		
		msgDto = msgDao.rnFindSend(emp_no, msg_no);
	}
	
	
	
	Date time = msgDto.getMessage_time();
	Date today = new Date();
	
	SimpleDateFormat t = new SimpleDateFormat();
	t = new SimpleDateFormat("yyyy-MM-dd");
	
	String a = t.format(today);
	String b = t.format(time);
	
	String msg_time;
	if(a != b) {
		t = new SimpleDateFormat("HH:mm:ss");
		msg_time = t.format(time);
	} else {
		t = new SimpleDateFormat("yyyy-MM-dd");
		msg_time = t.format(time);
	}
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<style>
	.nxpr-btn {
		text-decoration: none;
		color: black;
	}
	
	.float-right {
		float:right;
	}
</style>

<script>
	$(function(){
		
		//답장버튼
		$("#reply-btn").click(function() {
			$("#hiddenValue1").prop("value", <%=msgDto.getEmp_no()%>);
			$("#hiddenValue2").prop("value", "<%=msgDto.getEmp_name()%>");
			document.form.submit();
		});
	
		//전달버튼
		$("#pass-btn").click(function() {
			location.href="msg_pass.jsp?msg_no=<%=msgDto.getMessage_no()%>";
		});
		
		//삭제버튼
		$("#delete-btn").click(function() {
			if(confirm("삭제하시겠습니까?")) {
				if(<%=isSend%>) {
					location.href="inbox_delete.do?msg_no=<%=msgDto.getMessage_no()%>";	
				} else if(<%=!isSend%>) {
					location.href="outbox_delete.do?msg_no=<%=msgDto.getMessage_no()%>";
				}
			}
		});
	});
</script>
<div class="outbox" style="width:80%;">
	<div class="row float-right">
		<%if(prev != 0) {%>
				<span><a class="nxpr-btn" href="msg_detail.jsp?msg_no=<%=prev%>">이전</a></span>
				|
				<%} %>
		<%if(isReceive) { %>
				<span><a class="nxpr-btn" href="sentbox.jsp">목록</a></span>
			<%} else if(isSend){ %>
				<span><a class="nxpr-btn" href="inbox.jsp">목록</a></span>
			<%} %>
			<%if(next != 0) {%>
				|
				<span><a class="nxpr-btn" href="msg_detail.jsp?msg_no=<%=next%>">다음</a></span>
				<%} %>
	</div>
	<div class="row">
		<table class="table">
			<tbody>
				<tr>
					<th width="20%">제목</th>
					<td>
						<input class="input" type="text" name="message_title" value=<%=msgDto.getMessage_title()%> readonly>
					</td>
				</tr>
				<tr>
				<%if(!isSend) {%>
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
					<td class="left">
					<%if(inFile) {%>
					<span>
						<a href="download.do?msg_no=<%=msgDto.getMessage_no()%>"><%=msg_FileDto.getFile_upload_name()%></a>
					</span>
					<%} %>
					</td>
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
			<form action="messageWrite.jsp" method="post" name="form">
				<input type="hidden" id="hiddenValue1" name="emp_no">
				<input type="hidden" id="hiddenValue2" name="emp_name">
				<input type="button" class="input input-inline" id="reply-btn" value="답장">
				<input type="button" class="input input-inline" id="pass-btn"value="전달">
				<input type="button" class="input input-inline" id="delete-btn" value="삭제">
			</form>
			
		</div>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>