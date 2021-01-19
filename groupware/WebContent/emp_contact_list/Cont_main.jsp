<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	$(function () {
		$("#delete_btn").click(function(){
			var list_delete = window.confirm("삭제하시겠습니까?")
			if(list_delete) {
				//목록 화면으 이동시키기(redirect?)
			} else {
			}
		});
		
		$("#allCheck-btn").on("input", function(){
			var check = $(this).prop("checked");
			$(".check-btn").prop("checked", check);
		});
	
		$("#message_write").click(function(){
			location.href = "<%=request.getContextPath()%>/message/Message_write.jsp";
		});
	})
</script>
<div class="outbox">
	<div class="row float-box">
		<div class="row" style="float:left;">
			<input type="button" value="쪽지보내기" id="message_write" class="input input-inline">
		</div>
		<div class="row" style="float:right;">
			<input type="text" class="input input-inline" placeholder="검색어를 입력해주세요.">
			<input type="button"  class="input input-inline" value="검색">
		</div>
		<div class="row" style="float:left;">
		<input type="button" id="delete_btn" value="선택삭제" class="input input-inline">
	</div>
	</div>
	<div class="row">
		<table class="table table-border table-pattern">
			<thead>
				<tr>
					<th>
						<input type="checkbox" id="allCheck-btn">
					</th>
					<th>이름</th>
					<th>부서</th>
					<th>연락처</th>
					<th>이메일</th>
					<th>메모</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<input type="checkbox" class="check-btn">
					</td>
					<td>.</td>
					<td>.</td>
					<td>.</td>
					<td>.</td>
					<td>.</td>
				</tr>
			</tbody>
		</table>
	</div>
	
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>