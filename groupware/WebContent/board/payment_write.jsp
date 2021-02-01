<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="groupware.*" %>
<%@ page import="java.util.*" %>
<%@ page import="groupware.beans.*"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<%
EmployeeDao empDao = new EmployeeDao();
List<EmployeeDto> empList = empDao.select();

%>


<div class="outbox">
	<form action="payment_write.do" method="post" >
		<div class="row">
			<label>말머리</label>
			<select name="payment_heater" class="input">
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
			<textarea name="payment_context" class="input" required rows="8"></textarea>
		</div>

		<div class="row">
			<label>받는사람</label>
				<select name="payment_recive" class="input">
					<%for(EmployeeDto empDto : empList){ %>
					<option value="<%=empDto.getEmp_no()%>"><%=empDto.getEmp_name()%></option>
					<%} %>
				</select>
		</div>
		
 		<div class="row">
			<label>첨부파일</label>
			<form aciton="file/receive.do" method="post" enctype="multipart/form-data">
				file:<input type="file" name="file">
				<input type="submit" value="file upload">
			</form>
		</div> 
		
		<div class="row">
			<input type="submit" class="input" onclick="alert('글을 등록하시겠습니까?')" value="등록">
		</div>
	 
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>