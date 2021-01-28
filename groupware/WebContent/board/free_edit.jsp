<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="groupware.beans.*" %>
<%
	int free_no = Integer.parseInt(request.getParameter("free_no"));
	BoardFreeDao boardFreeDao = new BoardFreeDao();
	BoardFreeDto boardFreeDto = boardFreeDao.find(free_no);
%>    
<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	$(function(){
		$("select[name=free_header]").val("<%=boardFreeDto.getFree_header_string()%>"); 
	});
</script>
	<div class="outbox" style="width:900px">
		<div class="row center">
			<h2>게시글 수정</h2>
		</div>

		<div>
			<form action="<%=request.getContextPath()%>/board/free_edit.do" method="post">
			
			<input type="hidden" name="free_no" value="<%=boardFreeDto.getFree_no()%>">
			
			<div class="row">
				<label>말머리</label>
				<select name="free_header" class="input">
					<option value="">말머리를 선택하세요</option>
					<option value="개발부">개발부</option>
					<option value="홍보부">홍보부</option>
					<option value="경리부">경리부</option>
					<option value="행정부">행정부</option>
					<option value="인사부">인사부</option>
					<option value="기획부">기획부</option>
					<option value="생산부">생산부</option>
					<option value="총리부">총리부</option>
					<option value="기술부">기술부</option>
				</select>	
			</div>
			
			<div class="row">
				<label>제목</label>
				<input type="text" class="input" name="free_title" value="<%=boardFreeDto.getFree_title()%>" required>
			</div>
	
			<div class="row">
				<label>내용</label>
				<textarea name="free_context" class="input" required rows="20"><%=boardFreeDto.getFree_context()%></textarea>
			</div>
	
			<div class="row">
				<input type="submit" class="input" value="수정" onclick="alert('글을 수정하시겠습니까?')">
			</div>
		
			</form>
		</div>		
		
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>