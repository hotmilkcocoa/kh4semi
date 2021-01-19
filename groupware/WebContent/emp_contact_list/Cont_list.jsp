<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	$(function () {
		$("#add_cont").click(function(){
			window.open("Cont_add.jsp", "주소록추가", "width=600px,height=400px");
 		});
		
		$("#delete_btn").click(function(){
			var list_delete = window.confirm("삭제하시겠습니까?")
			if(list_delete) {
				//목록 화면으로 이동
			}
		});
		
		$("#allCheck-btn").on("input", function(){
			var check = $(this).prop("checked");
			$(".check-btn").prop("checked", check);
		});

	})
</script>

<div class="outbox">
	<div class="row float-box">
	<div class="row" style="float:left;">
			<input type="button" value="주소록 추가" id="add_cont" class="input input-inline">
		</div>
		<div class="row" style="float:right;">
			<input type="text" class="input input-inline" placeholder="검색어를 입력해주세요.">
			<input type="button"  class="input input-inline" value="검색">
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