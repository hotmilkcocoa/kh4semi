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
		
		$(".corp-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/info.jsp";
		});
	});


</script> 

<div class="outbox" style="width:900px">
	<div class="row center">
	
		<button class="corp-Btn">
			<div class="row left">
				<span>회사정보</span>
			</div>
			<div class="row center">
				<img alt="회사정보관리로" src="<%=request.getContextPath()%>/image/house.svg">
			</div>
		</button>	
		
		<button class="group-Btn">
			<div class="row left">
				<span>조직관리</span>
			</div>
			<div class="row center">
				<img alt="조직관리로" src="<%=request.getContextPath()%>/image/flowchart_alt.svg">			
			</div>
		</button>
		
	</div>
	<div class="row center">
		
		<button class="emp-Btn">
			<div class="row left">
				<span>사원관리</span>
			</div>
			<div class="row center">
				<img alt="사원관리로" src="<%=request.getContextPath()%>/image/people.svg">
			</div>
		</button>	
		
		<button class="">
			<div class="row left">
				<span></span>
			</div>
			<div class="row center">
				<img>
			</div>
		</button>
	</div>
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>