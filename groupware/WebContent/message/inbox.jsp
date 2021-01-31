<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");

	int viewSize = 8;
	
	int p;
	
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();
	}
	catch(Exception e) {
		p = 1;
	}
	
	int endRow = p * viewSize;
	int startRow = endRow - viewSize + 1;
%>

<%
	

	int emp_no = (int)request.getSession().getAttribute("check");
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	boolean isSearch = type != null && key != null;
	
	//받은 메세지함 조회
	MessageDao msgDao = new MessageDao();
	List<MessageDto> msgList = new ArrayList<>();
	
	if(isSearch) {
		msgList = msgDao.paginationInSearch(type, key, emp_no, startRow, endRow);
	} else {
		msgList = msgDao.paginationIn(emp_no, startRow, endRow);
	}
	
	//안읽은 메세지 갯수조회
	int readCount = msgDao.getCount(emp_no);

	
	MessageFileDao msg_FileDao = new MessageFileDao();
	
	
%>
<%
	int blockSize = 10;
		
	int startBlock = (p-1) / blockSize * blockSize +1;
	int endBlock = startBlock + blockSize -1;

	int count;
	if(isSearch) {
		count = msgDao.searchCountIn(type, key, emp_no);
	} else {
		count = msgDao.getCount(emp_no);
	}
	
	int pageSize = (count + viewSize -1) / viewSize;
	if(endBlock > pageSize) {
		endBlock = pageSize;
	}
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	a {
		text-decoration: none;
		color:#333333;
	}
	/*안읽음표시*/
	.n {
		color:#6633FF;
	}
	
	.float-right {
		float:right;
	}
	
	.float-left {
		float:left;
	}
	
	.choose {
		color: black;
		font: bold 20px "";
	}
	
	
</style>
<script type="text/javascript">
	
	$(function(){
		
		//읽음표시
		for(var i = 0; i < <%=readCount%>; i++) {
			if($(".readCk").eq(i).val() == "N"){
				$(".read").eq(i).addClass("n");
			} else {
				$(".read").eq(i).removeClass("n");
			}
		}
		//전체선택
		$("#allCheck-btn").on("input", function(){
			var check = $(this).prop("checked");
			$(".check-btn").prop("checked", check);
		});
		
		//쪽지작성
		$("#message_write").click(function(){
			location.href="messageWrite.jsp";
		});
		
		//선택삭제
		var chkArray = new Array();
		$("#delete_btn").click(function(){
			if(window.confirm("삭제하시겠습니까?")) {
				$(".check-btn:checked").each(function(index, item){
					chkArray.push($(item).val());
					
				});
				$("#form").append($("<input>").attr("type", "hidden").attr("name", "msg_no").attr("value", chkArray));
					document.form.submit();	
			}
			
		});
	});
	
</script>
<div class="outbox">
	<div class="row float-box">
		<div class="row float-left">
			<form action="inbox_delete.do" method="get" id="form" name="form">
				<input id="message_write" type="button" value="쪽지작성" class="input input-inline">
				<input type="button" value="삭제" id="delete_btn" class="input input-inline">
			</form>
		</div>
		<div class="row float-right">
			<span><a href="inbox.jsp" class="choose" id="inbox">받은쪽지함</a></span>
			|
			<span><a href="sentbox.jsp" id="sentbox">보낸쪽지함</a></span>
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
					<%for(MessageDto msgDto : msgList) { %>
					<tr>
						<td>
							<input type="hidden" value=<%=msgDto.getMessage_receiver()%> id="msg_receiver">
							<input type="checkbox" class="check-btn" value=<%=msgDto.getMessage_no()%>>
						</td>
						<td><%=msgDto.getMessage_no()%></td>
						<td>
							<input type="hidden" class="readCk" value=<%=msgDto.getRead_check()%>>
							<a class="read" href="msg_detail.jsp?msg_no=<%=msgDto.getMessage_no()%>">
								<%=msgDto.getMessage_title()%>
								<%if(msg_FileDao.check(msgDto.getMessage_no())) {%>
									<img src="../image/file.png" alt="첨부파일여부" style="width:20px; height:20px;">
								<%} %>
								</a>
						</td>
						<td><%=msgDto.getEmp_name()%> <%=msgDto.getEmp_title()%></td>
						<td><%=msgDto.getMessage_time()%></td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
	</div>
		
		
		<div class="row center">
			<form action="inbox.jsp" method="get">
				<select name="type" class="input input-inline">
					<option value="emp_name" <%if(type!=null&&type.equals("emp_name")) {%>selected<%}%>>이름</option>
					<option value="message_title" <%if(type!=null&&type.equals("message_title")) {%>selected<%}%>>제목</option>
					<option value="message_content" <%if(type!=null&&type.equals("mseeage_content")) {%>selected<%}%>>내용</option>
				</select>
				<%if(isSearch) {%>
					<input type="text" name="key" class="input input-inline" value=<%=key%>>
				<%} else { %>
					<input type="text" name="key" class="input input-inline">
				<%} %>
				<input type="submit" value="검색" class="input input-inline">
			</form>
		</div>


	<!-- 페이지 네비게이션 -->
	<div class="row center search">
			<ul class="pagination">
				<%if(isSearch) {%>
					<li><a href="inbox.jsp?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
				<% } else { %>
					<li><a href="inbox.jsp?p=<%=startBlock-1%>">&lt;</a></li>
				<% } %>
				
				<%for(int i = startBlock; i <= endBlock; i++) {%>
						<%if(i == p) { %>
							<li class="active">
						<% } else { %>
							<li>
						<%} %>
						
						<%if(isSearch) {%>		
							<!-- 검색용 링크 -->
							<a href="inbox.jsp?p=<%=i%>&type=<%=type%>&key=<%=key%>"><%=i %></a>
						<%} else { %>
							<!-- 목록용 링크 -->
							<a href="inbox.jsp?p=<%=i%>"><%=i%></a>
						<%} %>
						</li>
					<%} %>
				
				<%if(isSearch) {%>
					<li><a href="inbox.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=key%>">&gt;</a><li>
				<%} else { %>
					<li><a href="inbox.jsp?p=<%=endBlock+1%>">&gt;</a><li>
				<%} %>
			</ul>
		</div>

</div>
<jsp:include page="/template/footer.jsp"></jsp:include>