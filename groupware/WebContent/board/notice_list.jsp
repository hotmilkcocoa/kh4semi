<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="groupware.*" %>
<%@ page import="java.util.*" %>
<%@ page import="groupware.beans.*"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
 	//게시물목록
	int boardSize = 5;

	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();//강제예외
	}
	catch(Exception e){
		p = 1;
	}
	
 	//p의 값에 따라 시작 row번호와 종료 row번호를 계산
	int endRow = p * boardSize;
	int startRow = endRow - boardSize + 1;
%> 

<%
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	boolean isSearch = type != null && key != null;
	
	BoardDao boardDao = new BoardDao();
	List<BoardDto> noticelist; 
	
	if(isSearch){
		noticelist = boardDao.pagingList(type,key, startRow, endRow);
		//noticelist = boardDao.select(type,key);
	}
	else{
		noticelist =  boardDao.pagingList(startRow, endRow);
		//noticelist = boardDao.noticelist();
	}
%>    

<%
 	//페이지 네비게이터 계산 코드를 작성
 	//블록 크기를 설정
	int blockSize = 5;
 	
	//페이지 번호에 따라 시작블록과 종료블럭을 계산
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
 	//endBlock이 마지막 페이지 번호보다 크면 안된다 = 데이터베이스에서 게시글 수를 구해와야 한다.

	int count;
	if(isSearch){
		 count = boardDao.getCount(type,key);
	}
	else{
		count = boardDao.getCount();
	}
	
 	//페이지 개수 = (게시글수 + 9) / 10 = (게시글수 + 페이지크기 - 1) / 페이지크기
	int pageSize = (count + boardSize - 1) / boardSize;

	if(endBlock > pageSize){
		endBlock = pageSize;
	}
%>
<link rel="stylesheet" type="text/css" href="./css/common.css">
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
		$(".write").click(function(){
			location.href ="<%=request.getContextPath()%>/board/notice_write.jsp";
		});
	});
</script>
	 <div class="trans" align ="right" style="line-height:20px">
		<form action="notice_list.jsp" method="post">
			<div class="row">
				<select name="type" class="input input-inline">
					<option value="board_title" <%if(type!=null&&type.equals("board_title")){%>selected<%}%>>제목</option>
					<option value="board_writer" <%if(type!=null&&type.equals("board_writer")){%>selected<%}%>>작성자</option>
				</select>
				
			<%if(isSearch){ %>
				<input type="text" class="input input-inline" name="key" required value="<%=key%>">
			<%}else{ %>
				<input type="text" class="input input-inline" name="key" required>
			<%} %>
			
				<input type="submit" class="input input-inline" value="검색">
			
			</div>
		</form>
    </div>
<div class="outbox">	
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
					<%for(BoardDto dto : noticelist){ %>
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
					<%if(isSearch){ %>
						<li><a href="notice_list.jsp?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
					<%}else{ %>
						<li><a href="notice_list.jsp?p=<%=startBlock-1%>">&lt;</a></li>
					<%} %>
					
					
					<%for(int i=startBlock; i<=endBlock; i++){ %>
					<%if(i == p){ %>
					<li class="active">
					<%}else{ %>
					<li>
					<%} %>
						<%if(isSearch){ %>	
						<!-- 검색용 링크  -->
						<a href="notice_list.jsp?p=<%=i%>&type=<%=type%>&key=<%=key%>"><%=i%></a>
						<%}else{ %>
						<!--  목록용 링크  -->
						<a href="notice_list.jsp?p=<%=i%>"><%=i%></a>
						<%} %>
					<li>
					<%} %>
					
					<%if(isSearch){ %>
						<li><a href="notice_list.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
					<%}else{ %>
						<li><a href="notice_list.jsp?p=<%=endBlock+1%>">&gt;</a></li>
					<%} %>
									
				</ul>
			</div>
		</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>