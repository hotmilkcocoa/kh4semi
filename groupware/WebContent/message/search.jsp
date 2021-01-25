<%@page import="java.util.List"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//int emp_no = (int) request.getSession().getAttribute("emp_no");
	int emp_no = 1;
	
	EmpFavoriteDto emp_favDto = new EmpFavoriteDto();
	
	EmpFavoriteDao emp_favDao = new EmpFavoriteDao();
	List<EmpFavoriteDto> emp_favList = emp_favDao.select(emp_no);
	
	
	
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	$(function() {
		$("#search-opt").change(function(){
			if($(this).val() == "opt2") {
				location.href = "search.jsp?opt=opt2";
			} else if($(this).val() == "opt1") {
				location.href = "search.jsp";
			}
		});
		
		
	});
</script>

<div class="outbox">
	<div class="row">
		<h1>사원검색</h1>
	</div>
	<div class="row">
		<select id="search-opt">
			<option value="opt1">즐겨찾기</option>
			<option value="opt2">전체사원</option>
		</select>
	</div>
	<div class="row">
		<table>
			<tbody>
				
			</tbody>
		</table>
	</div>
	<div class="row"> 
		<input type="button" value="취소">
		<input type="button" value="확인">
	</div>
</div>