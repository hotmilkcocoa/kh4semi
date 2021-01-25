<%@page import="java.util.List"%>
<%@page import="groupware.beans.DataSettingDao"%>
<%@page import="groupware.beans.DataSettingDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	DataSettingDao dataSettingDao = new DataSettingDao();
	List<DataSettingDto> depList = dataSettingDao.depSelect();
	List<DataSettingDto> titleList = dataSettingDao.titleSelect();
%>


<jsp:include page="/template/admin_header.jsp"></jsp:include>

<div class="outbox" style="width:900px">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="데이터 관리" class="headerImg" src="<%=request.getContextPath()%>/image/playlist_add.svg" width="30" height="30"> 
		<span>추가 데이터 관리</span>	
	</div>

	<div>		
		<label>부서 설정</label>
		<div class="row">
			<form action="<%=request.getContextPath()%>/admin/dep_add.do" method="post">
				<input type="text" class="input input-inline" style="width:600px;" name="dep_name">
				<input type="submit" style="width:100px;" class="input input-inline" value="추가">
			</form>
		</div>
		<div class="row">
			<form action="<%=request.getContextPath()%>/admin/dep_delete.do" method="post">
				<select class="input input-inline" name="dep_no" style="width:600px;">
					<%for(DataSettingDto dataSettingDto : depList){ %>
					<option value="<%=dataSettingDto.getDep_no()%>"><%=dataSettingDto.getDep_name()%></option>
					<%} %>
				</select>	
				<input type="submit" style="width:100px;" class="input input-inline" value="삭제">
			</form>
		</div>
	</div>
	<div>
		<label>직급 설정</label>
		<div class="row">
			<form action="<%=request.getContextPath()%>/admin/title_add.do" method="post">
				<input type="text" class="input input-inline" style="width:600px;" name="title_name">
				<input type="submit" style="width:100px;" class="input input-inline" value="추가">
			</form>	
		</div>
		<div class="row">
			<form action="<%=request.getContextPath()%>/admin/title_delete.do" method="post">
				<select class="input input-inline" name="title_no" style="width:600px;">
					<%for(DataSettingDto dataSettingDto : titleList){ %>
					<option value="<%=dataSettingDto.getTitle_no()%>"><%=dataSettingDto.getTitle_name()%></option>
					<%} %>
				</select>
				<input type="submit" style="width:100px;" class="input input-inline" value="삭제">
			</form>
		</div>
	</div>

</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>