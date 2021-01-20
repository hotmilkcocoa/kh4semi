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
		$(".data-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/data_list.jsp";
		});
		
		$(".auth-Btn").click(function(){
			location.href = "<%=request.getContextPath()%>/admin/auth.jsp";
		});
		
		
	});
		
</script> 


<div class="outbox">
	<div class="row center">
		<button class="data-Btn">
			<div class="row left">
				<span>추가데이터관리</span>
			</div>
			<div class="row">
				<img alt="추가데이터관리로" src="<%=request.getContextPath()%>/image/playlist_add.svg">
			</div>
		</button>
		<button class="auth-Btn">
			<div class="row left">
				<span>권한설정관리</span>
			</div>
			<div class="row">
				<img alt="권한설정관리로" src="<%=request.getContextPath()%>/image/format_list_numbered.svg">
			</div>
		</button>
	</div>
	<div class="row center">
		<button class=""></button>
		<button class=""></button>
	</div>
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>