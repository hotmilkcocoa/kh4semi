<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가만든 홈페이지</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<style>
	outbox	{
		
	}
	main, footer
	{
		border: 1px dotted #ccc;
	}
	main {
		width:1200px;
		margin:auto;
	}
	header, footer{
		padding:1rem;
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
		
		<div class="parents" style="height:250px; background-color:blue;">
			<div class="left" style="height:auto; width:400px; background-color:red;"></div>
			<div class="right" style="height:auto; width:400px; background-color:yellow;"></div>			
		</div>
		<div class="parents" style="height:250px; background-color:skyblue;">
			<div class="left" style="height:auto; width:400px; background-color:green;"></div>
			<div class="right" style="height:auto; width:400px; background-color:gray;"></div>			
		</div>
	
		<div class="outbox popup">
			<header class="right">
				<button class="hideBtn">x</button>
				<h3 class="center">반갑습니다.</h3>				
			</header>
	<form action="login.do" method="post">
			<div class="parents" style="height:500px; background-color:blue;">
				
				<div  style="height:auto; width:50%; background-color:pink;">
				
					<div class="outbox" style="width:400px;">
						<div class="row center">
							<h2>로그인</h2>
						</div>
						<div class="row">
							<label>ID</label>
							<input type="text" name="member_id" class="input" required>
						</div>
						<div class="row">
							<label>Password</label>
							<input type="password" name="member_pw" class="input" required>
						</div>
						
						<%if(request.getParameter("error")!=null){ %>
						
						<div class="row center" style="color:red;">
							입력하신 정보가 맞지 않습니다
						</div>
						<%} %>
						
						<div class="right">
							<input type="submit" value="로그인" class="input">
						</div>
					</div>
				</form>			
				</div>						
			</div>
			
<!--  			<aside>검색창</aside>
			
			<article>
			로그인창
			</article>  -->
		</div>
		
	</main>
	
</body>
<jsp:include page="/template/footer.jsp"></jsp:include>