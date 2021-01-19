<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="/template/admin_header.jsp"></jsp:include>

<style>
	button{
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
		$(".group-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/group.jsp";
		});
		
		$(".emp-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/employee.jsp";
		});
		
	});


</script> 

<div class="outbox" style="width:900px">
	<div class="row center">
	
		<button class="group-Btn">
			<div class="row left">
				<span>조직관리</span>
			</div>
			<div class="row center">
				<img alt="조직관리로" src="<%=request.getContextPath()%>/image/people.svg">			
			</div>
		</button>
		
		<button class="emp-Btn">
			<div class="row left">
				<span>사원관리</span>
			</div>
			<div class="row center">
				<img alt="사원관리로" src="<%=request.getContextPath()%>/image/timelapse.svg">
			</div>
		</button>	
		
	</div>
	<div class="row center">
		<button class=""></button>
		<button class=""></button>
	</div>
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>