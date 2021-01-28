<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="outbox">
	<form action="payment_write.do" method="post" >
		<div class="row">
			<label>말머리</label>
			<select name="payment_header" class="input">
				<option value="">부서를 선택하세요</option>
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
			<input type="text" class="input" name="payment_title" required>
		</div>
	
		<div class="row">
			<label>내용</label>
			<textarea name="payment_context" class="input" required rows="20"></textarea>
		</div>
		
		<div class="row">
			<input type="submit" class="input" onclick="alert('글을 등록하시겠습니까?')" value="등록">
		</div>
		
	</form>
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>