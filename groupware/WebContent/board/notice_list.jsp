<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="groupware.*" %>
<%@ page import="java.util.*" %>
<%@ page import="groupware.beans.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");

	boolean isSearch = type != null && keyword != null;

	BoardDao dao = new BoardDao();
	List<BoardDto> list;
	if(isSearch){
		list = dao.select(type, keyword);
	} 
	else{
		list = dao.select();
	}
%>    
<jsp:include page="/template/header.jsp"></jsp:include>

<style>
.pagination{
position:absolute; top:550px; left:600px;
}
.write{
position:absolute; top:550px;
}
</style>
<script>
	$(function(){
		//.write-btn을 누르면 글쓰기 페이지로 이동
		$(".write").click(function(){
			location.href ="<%=request.getContextPath()%>/board/notice_write.jsp";
		});
	});
</script>
	<form action="notice_list.jsp" method="post">
	<div class="row" align ="right">
	
		<select name="type" class="input input-inline">		
			<option value="board_title" <%if(type!=null&&type.equals("board_title")){%>selected<%}%>>제목</option>
			<option value="board_writer" <%if(type!=null&&type.equals("board_writer")){%>selected<%}%>>작성자</option>
		</select>
		
			<%if(isSearch){ %>
				<input type="text" class="input input-inline" name="key" required value="<%=keyword%>">
			<%}else{ %>
				<input type="text" class="input input-inline" name="key" required>
			<%} %>
			
		<input type="submit" class="input input-inline" value="검색">
	</div>
	</form>
	
	<div class="row center">
		<h2>공지 게시판</h2>
	</div>
	
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th>글 번호</th>
					<th width="45%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>부서</th>
				</tr>
			</thead>
			
			<tbody>
				<%for(BoardDto dto : list){ %>
				<tr>
					<td><%=dto.getBoard_no() %></td>
					<td width="45%">
					<%if(dto.getBoard_header() != null){ %>
							[<%=dto.getBoard_header()%>]
						<%}%>
					<a href="notice_detail.jsp?board_no=<%=dto.getBoard_no()%>">				
							<%=dto.getBoard_title()%>
					</a>
					</td>
					<td><%=dto.getBoard_writer() %></td>
					<td><%=dto.getBoard_writedate() %></td>
					<td><%=dto.getBoard_dep()%></td>
				</tr>
				<%} %>
			</tbody>
		</table>
			<div class="write">
				<input type="button" value="글쓰기">
			</div>
			
		<!-- 페이지 네비게이션 -->
		<div class="row">
			<ul class="pagination">
				<li><a href="#">&lt;</a></li>
				<li class="active"><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#">6</a></li>
				<li><a href="#">7</a></li>
				<li><a href="#">8</a></li>
				<li><a href="#">9</a></li>
				<li><a href="#">10</a></li>
				<li><a href="#">&gt;</a></li>
			</ul>
		</div>
		</div>
<jsp:include page="/template/footer.jsp"></jsp:include>