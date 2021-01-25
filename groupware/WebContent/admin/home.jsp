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
		$(".hr-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/hr.jsp";
		});
		
		$(".tna-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/tna.jsp";
		});
		
		$(".event-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/event.jsp";
		});
		
		$(".setting-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/setting.jsp";
		});
		
	});
		
</script> 


<div class="outbox">
	<div class="row center">
		<button class="hr-Btn">
			<div class="row left">
				<span>인사관리</span>
			</div>
			<div class="row">
				<img alt="인사관리로" src="<%=request.getContextPath()%>/image/people.svg">
			</div>
		</button>
		<button class="tna-Btn">
			<div class="row left">
				<span>근태관리</span>
			</div>
			<div class="row">
				<img alt="근태관리로" src="<%=request.getContextPath()%>/image/timelapse.svg">
			</div>
		</button>
	</div>
	<div class="row center">
		<button class="event-Btn">
			<div class="row left">
				<span>일정관리</span>
			</div>
			<div class="row">
				<img alt="일정관리로" src="<%=request.getContextPath()%>/image/calendar.svg">
			</div>
		</button>
		<button class="setting-Btn">
			<div class="row left">
				<span>설정관리</span>
			</div>
			<div class="row">
				<img alt="설정관리로" src="<%=request.getContextPath()%>/image/settings.svg">
			</div>
		</button>
	</div>
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>