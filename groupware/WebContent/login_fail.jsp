<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="groupware.beans.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gwork</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<style>
	outbox	{
		
	}
	main, footer
	{
		border: 1px dotted #ccc;
		padding:1rem;
	}
	main {
		width:1200px;
		margin:auto;
	}	
	
	.parents{
		display:flex;
	}
	
	.popup{
		background-color: white;
		border:1px solid black;
        display:block;
		position: absolute;
		top:50px;
        left:300px;
        width: 1000px;
        height: 600px;		
	}
		
</style>

<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	int boardSize = 9;
	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();
	}
	catch(Exception e){
		p = 1;
	}
	
	int endRow = p * boardSize;
	int startRow = endRow - boardSize +1;
%>
<% 	
	BoardDao boardDao = new BoardDao();
	List<BoardDto> mainlist = boardDao.mainlist(startRow, endRow);
%>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	$(function(){
		$(".popup").hide();
		
		$(".loginBtn").click(function(){
			$(".popup").show();
		});
		
		$(".hideBtn").click(function(){
			$(".popup").hide();
		});
	});
</script> 
</head>
<body>
	<main>
		<header>
			<h1 class="center">G_Work!</h1>			
		</header>
		<div class="right">
			<input type="button" value="로그인" class="loginBtn">
		</div>
		
		<div class="parents" style="height:250px; background-color:#95a5a6;">
			<div class="left" style="height:auto; width:400px; background-color:#3498db;"></div>
			<div class="right" style="height:auto; width:400px; background-color:#34495e;"></div>			
		</div>
		<div class="parents" style="height:250px; background-color:#30336b;">
			<div class="left" style="height:auto; width:400px; background-color:#2c3e50;"></div>
			<div class="right" style="height:auto; width:400px; background-color:#2980b9;"></div>			
		</div>
	
	<div class="outbox popup">
			<header class="right">
				<button class="hideBtn">x</button>
				<h2 class="center">반갑습니다.</h2>				
			</header>		
	
			<div  style="height:503px; width:50%; background-color:#2980b9; float:right;">
			
				<div class="row center">
					<h2>공지사항</h2>
				</div>	
	
				<div class="row">
					<table class="table table-border" style="background-color:#ffffff;">
						<thead>
							<tr>
								<th>no</th>
								<th width="70%">제목</th>
								<th>부서</th>
							</tr>
						</thead>
						<tbody>
							<%for(BoardDto dto :mainlist){ %>						
							<tr>
								<td><%=dto.getBoard_no() %></td>
								<td><%=dto.getBoard_title()%></td>
								<td><%=dto.getBoard_dep() %></td>
							</tr>
							<%} %>	
						</tbody>
					</table>
			
				</div>
			</div>
	
	<form action="login.do" method="post">	
		<div  style="height:503px; width:50%; background-color:#95a5a6; float:left"> 
					
				<div class="outbox" style="width:350px;">
					<div class="center">
						<h2>로그인</h2>
					</div>
					<div class="row">
						<label>ID</label>
						<input type="text" name="emp_id" class="input" required>
					</div>
					<div class="row">							
						<label>Password</label>
						<input type="password" name="emp_pw" class="input" required>
					</div>
							
					<div class="right">
						<input type="submit" value="로그인" class="input">
					</div>					
				
				</div>
			</div>
		</form>	
	</div>
	</main>
	
</body>


<div class="outbox">
	<div class="row center" style="color:red">
		<h3>정보를 다시확인해주세요</h3>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>