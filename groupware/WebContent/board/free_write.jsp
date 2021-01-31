<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
	
	<div class="outbox">
		<form action="free_write.do" method="post" >
	
		<div class="row">
			<label>말머리</label>
			<select name="free_header" class="input">
				<option value="">말머리를 선택하세요</option>
				<option value="개발부">개발부</option>
				<option value="인사부">인사부</option>
				<option value="기획부">영업부</option>
				<option value="생산부">경영관리</option>
				<option value="총리부">품질부</option>
				<option value="기술부">지원부</option>
			</select>	
		</div>		
		
		<div class="row">
			<label>제목</label>
			<input type="text" class="input" name="free_title" required>
		</div>
	
		<div class="row">
			<label>내용</label>
			<textarea name="free_context" class="input" required rows="20"></textarea>
		</div>
		
		<div class="row">
			<input type="submit" class="input" onclick="alert('글을 등록하시겠습니까?')" value="등록">
		</div>
		
		</form>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>