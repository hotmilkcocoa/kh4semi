<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String emp_name = request.getParameter("emp_name"); //주소록에서 선택한 사원의 이름
	String emp_no = request.getParameter("emp_no"); //주소록에서 선택한 사원의 번호
	
	boolean isCheck = emp_name != null && emp_no != null; //체크가 되어서 들어온 정보라면 isCheck
	
	String[] empName = new String[]{};
	String[] empNo = new String[]{};
	if(isCheck) {
		empName = emp_name.split(",");
		empNo = emp_no.split(",");
	}
	
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<style>
</style>
<script>
	//자식창에서 값전달
	function empAdd1(nameArray){
		var a = $("#msg_receiver").prop("value");
		if(a != "") {
		var b = a +","+ nameArray;
		var valArray = b.split(",");
		var set = new Set(valArray);
		var uniqueArr = [...set];
		$("#msg_receiver").prop("value", uniqueArr);
		} else {
			var set = new Set(nameArray);
			var uniqueArr = [...set];
			$("#msg_receiver").prop("value", uniqueArr);
		}
	};
	
	function empAdd2(noArray) {
		var a = $("input[name=msg_receiver]").prop("value");
		var b;
		if(a != "") {
			b = a +"," + noArray;	
			var valArray = b.split(",");
			var set = new Set(valArray);
			var uniqueArr = [...set];
			$("input[name=msg_receiver]").prop("value", uniqueArr);
		} else {
			var set = new Set(noArray);
			var uniqueArr = [...set];
			$("input[name=msg_receiver]").prop("value", uniqueArr);
		}
		
		
		console.log(uniqueArr);
		
	}

	$(function() {
		var empno = new Array();
		<% for(int i = 0; i < empNo.length; i ++) {%>
			empno.push(<%=empNo[i]%>)
		<%}%>
		$("input[name=msg_receiver]").attr("value", empno);
		
		
		//주소록에서 가져온 사원추가
		<%if(isCheck) {  %>		
				var array = new Array();
				<%for(int i = 0; i < empName.length; i++) {%>
					array.push(
						"<%=empName[i]%>"
					);
					<%} %>
				$("#msg_receiver").val(array);
		<% } else {%>
				$("#msg_receiver").val("");
		<% }%>
		
		//검색버튼
		$("#search-btn").click(function() {
			window.open("search.jsp", "사원검색", "width=700px, height=600px");
		});
		
		//취소버튼
		$("#cancel-btn").click(function() {
			if(confirm("작성 중인 내용이 사라집니다. 취소하시겠습니까?")) {
				location.href="inbox.jsp"
			}
		});
		
		
		
	});
	
	
</script>
<div class="outbox" style="width:700px;">
	<div class="row">
		<form action="upload.do" method="post" enctype="multipart/form-data" id="file-form" name="form">
		<input type="hidden" name="msg_receiver">
			<table class="table table-board">
				<tbody>
					<tr>
						<th width="20%">제목</th>
						<td>
							<input name="msg_title" type="text" placeholder="제목을 입력하세요" class="input" required>
						</td>
					</tr>
					<tr>
						<th>받는사람</th>
						<td>
							<input type="text" class="input" id="msg_receiver" style="display:inline; width:90%; float:left;" required>
							<input type="button" id="search-btn" class="input" value="검색" style="diplay:inline; width:10%; float:left;">
						</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
							<input type="file" id="file" class="input" name="f" accept=".jsp, .png, .gif, .jpeg, .pdf, .ppt, .txt, .hwp, .zip">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea name="msg_content" class="input" rows="15" required></textarea>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="row center">
				<input type="button" class="input input-inline" value="취소" id="cancel-btn">
				<input type="submit" class="input input-inline" value="전송">
			</div>
		</form>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>