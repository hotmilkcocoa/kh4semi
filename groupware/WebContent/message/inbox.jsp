<%@page import="java.util.List"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//int emp_no = (int)request.getSession().getAttribute("check");
	int emp_no = 1;
	
	//받은 메세지함 조회
	MessageDao msgDao = new MessageDao();
	List<MessageDto> msgList = msgDao.select(emp_no);
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript">
	
	$(function(){
		
		//전체선택
		$("#allCheck-btn").on("input", function(){
			var check = $(this).prop("checked");
			$(".check-btn").prop("checked", check);
		});
		
		
		$("#message_write").click(function(){
			location.href="messageWrite.jsp";
		});
		
		//보낸쪽지함 이동
		$("#box").change(function() {
			if($(this).val() == "inbox") {
				location.herf="inbox.jsp";
				$(this).val("inbox").prop("selected", true);
			} else {
				location.href="sentbox.jsp?box="+$(this).val();
				$(this).val("sentbox").prop("selected", true);
			}
		});
	});
	
</script>
<div class="outbox float-box">
	<div class="row" style="float:right;">
		<select class="input" id="box">
			<option value="inbox" selected>받은쪽지함</option>
			<option value="sentbox">보낸쪽지함</option>
		</select>
	
	</div>
	<div class="row">
		<table class="table table-border table-pattern">
			<thead>
				<tr>
					<th style="width:10px;">
						<input type="checkbox" id="allCheck-btn">
					</th>
					<th style="width:10px;">no</th>
					<th style="width:50%;">제목</th>
					<th>발신인</th>
					<th>발신일자</th>
				</tr>
			</thead>
			<tbody>
				<%for(MessageDto msgDto : msgList) {%>
				<tr>
					<td>
						<input type="checkbox" class="check-btn">
					</td>
					<td><%=msgDto.getMessage_no()%></td>
					<td>
						<a href="msg_detail.jsp?rn=<%=msgDto.getRownum()%>">
							<%=msgDto.getMessage_title()%>
						</a>
					</td>
					<td><%=msgDto.getEmp_name()%> <%=msgDto.getEmp_title()%></td>
					<td><%=msgDto.getMessage_time()%></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	<div class="row" style="float:left; border-radius: 50px;">
		<input type="button" value="삭제" class="input input-inline" style=" background-color:gray; color:white; border-radius: 10px;">
	</div>
	<div class="row" style="float:right;">
		<input id="message_write" type="button" value="쪽지작성" class="input input-inline" style="background-color:gray; color:white; border-radius: 10px;">
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>