<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	$(function() {
		$("#submit_btn").click(function(e){
				e.preventDefault();
				document.form.target = opener.name;
				document.form.submit();
				self.close();
		});
		
		$("#candel_btn").click(function() {
			if(confirm("취소하시겠습니까?")) {
				window.close();
			}
		});
	});
</script>
<div class="outbox">
		<div class="row center">
			<h2>주소록 추가</h2>
		</div>
		<hr>
	<div class="row">
		<form action="add.do" method="post" name="form">
		<table class="table table-border">
			<tbody>
				<tr>
					<th width="20%">이름 *</th>
					<td>
						<input class="input" type="text" name="cont_name" required>
					</td>
				</tr>
				<tr>
					<th>회사</th>
					<td>
						<input class="input" type="text" name="cont_corp">
					</td>
				</tr>
				<tr>
					<th>연락처 *</th>
					<td>
						<input class="input" type="text" name="cont_phone" required>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input class="input" type="email" name="cont_email">
					</td>
				</tr>
				<tr>
					<th>메모</th>
					<td>
						<textarea class="input" rows="10" name="cont_memo"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="row center" >
			<input type="button" value="취소" id="candel_btn" class="input input-inline">
			<input type="submit" value="추가" id="submit_btn" class="input input-inline">
		</div>
	</form>
	
	
</div>
</div>