<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/template/header.jsp"></jsp:include>    

<div class="outbox" style="width:900px">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="비밀번호수정" class="headerImg" src="<%=request.getContextPath()%>/image/key.svg" width="30" height="30"> 
		<span>비밀번호 수정</span>	
	</div>

	<form action="pw.do" method="post">
		<div class="row">
			<label>기존 비밀번호 확인 :</label>
			<input type="password" name="emp_pw" class="input" placeholder="비밀번호를 입력하세요" required>
		</div>
		<div class="row">
			<label>변경할 비밀번호 :</label>
			<input type="password" name="change_pw" class="input" placeholder="수정할 비밀번호를 입력하세요" required>
		</div>
		<div class="row  center">
			<%if(request.getParameter("error")!= null){ %>
			<span style="Color:red">비밀번호를 잘못입력하였습니다.</span>
			<%} %>
		</div>
		<div class="row">
			<input type="submit" class="input" value="수정">
		</div>
	</form>

</div>    
    
<jsp:include page="/template/footer.jsp"></jsp:include>  