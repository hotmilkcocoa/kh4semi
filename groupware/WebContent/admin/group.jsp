<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/template/admin_header.jsp"></jsp:include>

<div class="outbox" style="width:900px;">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="회사정보" class="headerImg" src="<%=request.getContextPath()%>/image/flowchart_alt.svg" width="30" height="30"> 
		<span>회사 정보</span>	
	</div>

	<div class="row">
		<table class="table table-border">
			<tbody>
				<tr>
					<th width="20%">회사명</th>
					<td width="30%"><span>G.work</span></td>
					<th width="20%">구분</th>
					<td width="30%"><span>법인</span></td>
				</tr>
				<tr>
					<th>사업자등록번호</th>
					<td></td>
					<th>법인등록번호</th>
					<td></td>
				</tr>
				<tr>
					<th>대표자명</th>
					<td></td>
					<th>전화번호</th>
					<td></td>
				</tr>
				<tr>
					<th>업태</th>
					<td></td>
					<th>종목</th>
					<td></td>
				</tr>
				<tr>
					<th>담당자명</th>
					<td></td>
					<th>전화번호</th>
					<td></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3"></td>
				</tr>
				<tr>
					<th colspan="2">회사로고</th>
					<th colspan="2">회사조직도</th>
				</tr>
				<tr>
					<td colspan="2" height="100"></td>
					<td colspan="2"></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" class="right"><button class="edit-Btn">회사정보수정</button></td>
				</tr>
				
			</tfoot>
		</table>
	</div>

</div>    
    
<jsp:include page="/template/admin_footer.jsp"></jsp:include>