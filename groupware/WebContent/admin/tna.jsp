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
		$(".setting-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/tna_setting.jsp";
		});
		
		$(".rest-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/rest_emp.jsp";
		});
		
		$(".list-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/tna_list.jsp";
		});
			
	});
		
</script> 


<div class="outbox">
	<div class="row center">
		<button class="setting-Btn">
			<div class="row left">
				<span>기본설정</span>
			</div>
			<div class="row">
				<img alt="기본설정으로" src="<%=request.getContextPath()%>/image/settings.svg">
			</div>
		</button>
		<button class="rest-Btn">
			<div class="row left">
				<span>휴직자관리</span>
			</div>
			<div class="row">
				<img alt="휴직자관리로" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg">
			</div>
		</button>
	</div>
	<div class="row center">
		<button class="list-Btn">
			<div class="row left">
				<span>사원근태관리</span>
			</div>
			<div class="row">
				<img alt="사원근태관리로" src="<%=request.getContextPath()%>/image/timelapse.svg">
			</div>
		</button>
		<button class="">
			<div class="row left">
				<span></span>
			</div>
			<div class="row">
				<img>
			</div>
		</button>
	</div>
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>