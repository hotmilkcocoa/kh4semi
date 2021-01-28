<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@page import="groupware.beans.Share_schDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.Share_schDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<%
	//int emp_no = (int) session.getAttribute("check");
	int emp_no = 3;
	
	String no = request.getParameter("emp_no");
	Share_schDao shareDao = new Share_schDao();
	List<Share_schDto> shareList = shareDao.select(emp_no);
%>
<h3>내 일정 관리</h3>
<div class="row">
    <span>내 일정 전체 정리하기</span>
    <input type="button" value="실행" class="delBtn delAll">
</div>
<div class="row">
    <form action="sch_del.do" id="form">
        <input class="dataInput date" type="date" name="delDate" required>
	    <span>이전 일정 정리하기</span>
	    <input type="submit" value="실행" class="delBtn delDate">
    </form>
</div>
<hr>
<h3>공유 일정 관리</h3>
<div class="row">
    <span>목록</span>
</div>
<div>
    <div>
        <table class="table table-border">
            <%for(Share_schDto shareDto : shareList){ 
            	EmployeeDto empDto = new EmployeeDao().find(shareDto.getTarget_no());%>
            <tr>
                <td><%=empDto.getEmp_name()%></td>
                <td><button class="shareDel">삭제하기</button><input type="hidden" value="<%=shareDto.getShare_no()%>"></td>
            </tr>
            <%} %>
        </table>
    </div>
    <div class="row">
    	<form action="share_add.do" method="post">
	        <span>이메일</span>
	        <input class="dataInput" type="text" name="emp_email" value="">
			<input type="submit" value="추가하기">
    	</form>
        <button id="search-btn">+ 주소록</button>
    </div>
</div>
<button class="return">내 일정으로</button>

<script>
	<%if(request.getParameter("error") != null){%>
		alert("이메일을 확인해주세요.");
	<%}%>
	document.querySelector(".delBtn.delAll").addEventListener("click", function(){
		if(confirm("정말 지우시겠습니까?")){
			location.href = "sch_del.do";			
		}
	});
	document.querySelector(".delBtn.delDate").addEventListener("click", function(e){
		e.preventDefault();
		if(confirm("정말 지우시겠습니까?")){
			document.querySelector("#form").submit();
		}
	});
	document.querySelector(".return").addEventListener("click", function(){
		location.href = "calendar.jsp";
	});
	document.querySelectorAll(".shareDel").forEach(function(ele){
		ele.addEventListener("click", function(){
			location.href = "share_del.do?share_no=" + this.nextElementSibling.value;
		});
	});
	$("#search-btn").click(function() {
		window.open("<%=request.getContextPath()%>/message/search.jsp", "사원검색", "width=700px, height=600px");
	});
</script>
            
<jsp:include page="/template/footer.jsp"></jsp:include>  