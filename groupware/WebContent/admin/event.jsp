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
		$(".event-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/event_list.jsp";
		});
		
		$(".prev-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/prev_event_list.jsp";
		});
		
		
	});
		
</script> 


<div class="outbox">
	<div class="row center">
		<button class="event-Btn">
			<div class="row left">
				<span>추가일정관리</span>
			</div>
			<div class="row">
				<img alt="추가일정관리로" src="<%=request.getContextPath()%>/image/playlist_add.svg">
			</div>
		</button>
		<button class="prev-Btn">
			<div class="row left">
				<span>지난일정관리</span>
			</div>
			<div class="row">
				<img alt="지난일정관리로" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg">
			</div>
		</button>
	</div>
	<div class="row center">
		<button class=""></button>
		<button class=""></button>
	</div>
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>