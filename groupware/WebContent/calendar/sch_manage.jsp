<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@page import="groupware.beans.Share_schDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.Share_schDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<style>
	div{
		border: none;
	}
	.shareContainer{
		border: 1px solid lightgray;
		background-color: #f7f7f7;
		padding: 0.5rem;
		width: 550px;
		font-size: 14px;
	}
	.shareContainer>ul{
		list-style: none;
		margin: 0;
		padding: 0;
		text-align: left;
		width: 550px;
	}
	.shareContainer>ul>li{
		display: inline-block;
		width: 250px;
		max-width: 250px;
		padding-left: 1rem;
		position: relative;
		overflow: hidden;
	}
	.shareContainer>ul>li:nth-child(even){
		border-left: 1px solid dimgray;
		margin-left: 1rem;
	}
	.shareContainer>ul>li>.mail{
		color: #6d6d6d;
		font-size: 12px;
	}
	.shareContainer>ul>li>.delBtn{
		position: absolute;
		top: 0;
		right: 0;
		margin-right: 5px;
	}
	form{
		display: inline-block;
	}
</style>

<%
	int emp_no = (int) session.getAttribute("check");
	
	String target_no = request.getParameter("emp_no");
	if(target_no!=null && !target_no.isEmpty()){
		response.sendRedirect("share_add.do?target_no="+target_no);
	}
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
<div class="row">
    <div class="shareContainer center">목록이 없어요</div>
    <div class="row">
    	<form action="share_add.do" method="post">
	        <span>이메일</span>
	        <input class="dataInput" type="text" name="emp_email" required>
			<input type="submit" value="추가하기">
    	</form>
        <button id="search-btn">주소록에서 추가하기</button>
    </div>
</div>
<button class="return">내 일정으로</button>

<script>
	//부모의 자식 엘리먼트 지우기
	function removeAllChild(parent) {
		while (parent.firstChild) {
			parent.removeChild(parent.firstChild);
		}
	}
	<%if(!shareList.isEmpty()){%>
		var container = document.querySelector(".shareContainer");
		removeAllChild(container);
		var newUl = document.createElement("ul");
		container.append(newUl);
		<%for(Share_schDto shareDto : shareList){
			EmployeeDto empDto = new EmployeeDao().find(shareDto.getTarget_no());%>
			var newLi = document.createElement("li");
			newUl.append(newLi);
			var emp = document.createElement("span");
			emp.classList.add("emp");
			emp.innerText = "<%=empDto.getEmp_name()%>";
			var mail = document.createElement("span");
			mail.classList.add("mail");
			mail.innerText = "<" + "<%=empDto.getEmp_email()%>" + ">";
			var delBtn = document.createElement("span");
			delBtn.classList.add("delBtn");
			delBtn.classList.add("cursor-pointer");
			delBtn.innerText = "X";
			delBtn.addEventListener("click", function(){
				location.href = "share_del.do?share_no=<%=shareDto.getShare_no()%>";
			});
			
			newLi.append(emp);
			newLi.append(mail);
			newLi.append(delBtn);
		<%}%>
	<%}%>
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
	$("#search-btn").click(function() {
		window.open("<%=request.getContextPath()%>/message/search.jsp", "사원검색", "width=700px, height=600px");
	});
</script>
            
<jsp:include page="/template/footer.jsp"></jsp:include>  