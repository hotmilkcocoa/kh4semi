<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>

</style>
	<div>
		<form action="write.do" method="post" >
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
			<input type="text" class="input" name="board_title" required>
		</div>
	
		<div class="row">
			<label>내용</label>
			<textarea name="board_context" class="input" required rows="20"></textarea>
		</div>
		
		<div class="row">
			<input type="submit" class="input" value="등록">
		</div>
		
		</form>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>