<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/template/admin_header.jsp"></jsp:include>

<div class="outbox" style="width:900px;">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg" width="15" height="15">
	</div>
	
	<!-- 검색 도구 -->
	<form action="" method="post">
		<div class="row right">
			<select class="input input-inline">
				<option>사번</option>
				<option>이름</option>
				<option>부서</option>
				<option>직급</option>
				<option>계정구분</option>
				<option>계정상태</option>
			</select>
			<input type="text" class="input input-inline" placeholder="사원검색">
			<input type="submit" class="input input-inline" value="검색">
		</div>
	</form>
	
	<!-- 리스트 -->
	<div class="row">
		<table>
			<thead>
				<tr>
					<th>사번</th>
					<th>이름</th>
					<th>부서</th>
					<th>직급</th>
					<th>계정구분</th>
					<th>계정상태</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>??</td>
					<td>??</td>
					<td>??</td>
					<td>??</td>
					<td>??</td>
					<td>??</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td>추가버튼</td>
				</tr>
			</tfoot>
		</table>
	</div>
	
	<!-- 페이지 네비게이션 -->
	
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>
		