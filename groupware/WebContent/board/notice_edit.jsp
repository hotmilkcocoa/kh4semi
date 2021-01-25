<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="groupware.beans.*" %>
<%
	int board_no = Integer.parseInt(request.getParameter("board_no"));
	BoardDao boardDao = new BoardDao();
	BoardDto boardDto = boardDao.find(board_no);
%>    
<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	$(function(){
		$("select[name=board_header]").val("<%=boardDto.getBoard_header_string()%>"); 
	});
</script>
	<div class="outbox" style="width:1000px">
		<div class="row center">
			<h2>게시글 수정</h2>
		</div>
		
		<div>
			<form action="<%=request.getContextPath()%>/#" method="post">
			<div class="row">
				<label>말머리</label>
				<select name="board_header" class="input">
					<option value="">말머리를 선택하세요</option>
					<option value="공지">공지</option>
					<option value="자유">자유</option>
				</select>	
			</div>
	
			<div class="row">
				<label>제목</label>
				<input type="text" class="input" name="board_title" value="<%=boardDto.getBoard_title()%>" required>
			</div>
	
			<div class="row">
				<label>내용</label>
				<textarea name="board_content" class="input" required rows="20"><%=boardDto.getBoard_context()%>></textarea>
			</div>
	
			<!--  -->
			<form action="receive.do" method="post" enctype="multipart/form-data">

				<input type="file" name="f" accept=".jpg , .png , .gif">
				<input type="submit" value="업로드">
	
			</form>
		
			<!--  -->
			
			<div class="row">
				<input type="submit" class="input" value="수정">
			</div>
		
			</form>
		</div>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>