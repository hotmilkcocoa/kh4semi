<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<script type="text/javascript">
	window.onload = function () {
		var list = document.querySelectorAll(".checkList");
		var allselect = document.querySelector("#allck");
	
		allselect.addEventListener("click", function(){
		    for(var i = 0; i < list.length; i++){
		        list[i].checked = allselect.checked;
		    }
		});
	}
	
	$(function(){
		$("#message").click(function(){
			location.href="Message_write.jsp";
		});
	});
	
</script>
<div class="outbox float-box">
	<div class="row" style="float:right;">
		<select class="input">
			<option>보낸쪽지함</option>
			<option>받은쪽지함</option>
		</select>
	
	</div>
	<div class="row">
		<table class="table table-border table-pattern">
			<thead>
				<tr>
					<th style="width:10px;">
						<input type="checkbox" id="allck">
					</th>
					<th style="width:10px;">no</th>
					<th style="width:50%;">제목</th>
					<th>발신인</th>
					<th>발신일자</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<input type="checkbox" class="checkList">
					</td>
					<td>1</td>
					<td>안녕하세요</td>
					<td>오재원</td>
					<td>2020년11월11일11시11분11초</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" class="checkList">
					</td>
					<td>1</td>
					<td>안녕하세요</td>
					<td>오재원</td>
					<td>2020년11월11일11시11분11초</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" class="checkList">
					</td>
					<td>1</td>
					<td>안녕하세요</td>
					<td>오재원</td>
					<td>2020년11월11일11시11분11초</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox" class="checkList">
					</td>
					<td>1</td>
					<td>안녕하세요</td>
					<td>오재원</td>
					<td>2020년11월11일11시11분11초</td>
				</tr>
				
			</tbody>
		</table>
	</div>
	<div class="row" style="float:left; border-radius: 50px;">
		<input type="button" value="삭제" class="input input-inline" style=" background-color:gray; color:white; border-radius: 10px;">
	</div>
	<div class="row" style="float:right;">
		<input id="message" type="button" value="쪽지작성" class="input input-inline" style="background-color:gray; color:white; border-radius: 10px;">
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>