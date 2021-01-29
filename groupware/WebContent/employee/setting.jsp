<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="/template/header.jsp"></jsp:include>

<style>
	.outbox button{
		width:350px;
		height: 250px;
		margin: 5px 20px;
		background-color: white;		
	}
	
	button label{
		display: block;
	}
	
	button img{
		display: block;
		width:120px;
		height: 120px;
		margin-left: 100px;	
	}
	
</style>

<script>
	$(function(){
		$(".info-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/employee/info_edit.jsp";
		});
		
		$(".pw-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/employee/pw_edit.jsp";
		});
		
		
	});
		
</script> 


<div class="outbox">
	<div class="row center">
		<button class="info-Btn">
			<div class="row left">
				<span>기본정보수정</span>
			</div>
			<div class="row">
				<img alt="기본정보수정으로" src="<%=request.getContextPath()%>/image/edit.svg">
			</div>
		</button>
		<button class="pw-Btn">
			<div class="row left">
				<span>비밀번호수정</span>
			</div>
			<div class="row">
				<img alt="비밀번호수정으로" src="<%=request.getContextPath()%>/image/key.svg">
			</div>
		</button>
	</div>
</div>







<jsp:include page="/template/footer.jsp"></jsp:include>