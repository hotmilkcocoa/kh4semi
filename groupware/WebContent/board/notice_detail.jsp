<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="groupware.beans.*" %>
<%@ page import="java.util.*" %>

<%
	int board_no = Integer.parseInt(request.getParameter("board_no"));

	BoardDao dao = new BoardDao();
	BoardDto dto = dao.find(board_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	$(function(){
		$(".write-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/board/notice_write.jsp";
		});
		
		$(".edit-btn").click(function(){
			location.href = "edit.jsp?board_no=<%=board_no%>";
		});
		
		$(".delete-btn").click(function(){
			if(confirm("정말 지우시겠습니까?")){
				location.href = "delete.do?board_no=<%=board_no%>";
			}
		});
		
		$(".list-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/board/notice_list.jsp";
			});
	});
</script>

<div class="outbox">
	<div class="row center";>
		<h2>
			<%=dto.getBoard_no()%>번 게시글
			<%if(dto.getBoard_header() != null){%>
				[<%=dto.getBoard_header()%>]
			<%} %>
		</h2>
	</div>
	
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th class="right" colspan="2">
						<button class="input input-inline write-btn">새글</button>
						<!-- 수정과 삭제 버튼은 작성자 본인과 관리자에게만 표시되어야 한다 -->
						<button class="input input-inline edit-btn">수정</button>
						<button class="input input-inline delete-btn">삭제</button>
						<button class="input input-inline list-btn">목록</button>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>작성자</th>
					<td class="left"><%=dto.getBoard_writer()%></td>
				</tr>
				<tr>
					<th width="20%">제목</th>
					<td class="left"><%=dto.getBoard_title()%></td>
				</tr>
				<tr height="200">
					<th>내용</th>
					<td class="left" valign="top"><%=dto.getBoard_context()%></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td class="left"><%=dto.getBoard_writedate()%></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td class="left"><%=dto.getBoard_read()%></td>
				</tr>
			</tbody>
			
			<tfoot>
				<tr>
					<th class="right" colspan="2">
						<button class="input input-inline write-btn">새글</button>
						
						<button class="input input-inline edit-btn">수정</button>
						<button class="input input-inline delete-btn">삭제</button>
						<button class="input input-inline list-btn">목록</button>
					</th>
				</tr>
			</tfoot>
		</table>
	</div>
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>