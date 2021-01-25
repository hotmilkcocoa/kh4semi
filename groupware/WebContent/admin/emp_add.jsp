<%@page import="groupware.beans.DataSettingDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.DataSettingDao"%>
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
		<img alt="사원추가" class="headerImg" src="<%=request.getContextPath()%>/image/playlist_add.svg" width="30" height="30"> 
		<span>사원 추가</span>	
	</div>

	<form action="<%=request.getContextPath()%>/admin/emp_add.do" method="post" style="width:800px">
		<div class="row center">
			<table class="table" style="border-color: transparent;">
				<tbody>
					<tr>
						<th width="15%">이름</th>
						<td width="35%"><input type="text" class="input" name="emp_name" required></td>
						<th width="15%">아이디</th>
						<td><input type="text" class="input" name="emp_id" required></td>					
					</tr>
					<tr>	
						<th>비밀번호</th>
						<td><input type="text" class="input" name="emp_pw" value="welcome" required></td>
						<th>이메일</th>
						<td><input type="text" class="input" name="emp_email" required></td>					
					</tr>
					<tr>	
						<th>전화번호</th>
						<td><input type="text" class="input" name="emp_phone" required></td>
						<th>생년월일</th>
						<td><input type="date" class="input" name="emp_birth" required></td>						
					</tr>
					<tr> 
						<th>주소</th>
						<td colspan="3"><input type="text" class="input" name="emp_addr" required></td>					
					</tr>
					<tr>
						<th>부서</th>
						<td>
							<select class="input" name="emp_dep" required>
								<%for(DataSettingDto dataSettingDto : depList){ %>
								<option><%=dataSettingDto.getDep_name()%></option>
								<%} %>
							</select>
						</td>	
						<th>직급</th>
						<td>
							<select class="input" name="emp_title" required>
								<%for(DataSettingDto dataSettingDto : titleList){ %>
								<option><%=dataSettingDto.getTitle_name()%></option>
								<%} %>
							</select>
						</td>					
					</tr>
					<tr>
						<th>급여</th>
						<td><input type="text" class="input" name="emp_salary" required></td>	
						<th>사진</th>
						<td><input type="file" name="f" accept=".jpg, .png"></td>					
					</tr>
					<tr>
						<th>권한</th>
						<td>
							<label><input type="radio" class="input input-inline" name="emp_auth" value="일반" checked>일반</label>
							<label><input type="radio" class="input input-inline" name="emp_auth" value="관리">관리</label>
						</td>	
						<th>상태</th>
						<td>
							<label><input type="radio" class="input input-inline" name="emp_state" value="정상" checked>정상</label>
							<label><input type="radio" class="input input-inline" name="emp_state" value="휴가">휴가</label>
							<label><input type="radio" class="input input-inline" name="emp_state" value="미사용">미사용</label>
						</td>					
					</tr>
					<tr>
						<th>기타사항</th>
						<td colspan="3"><textarea rows="2" name="emp_etc" class="input"></textarea></td>					
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4" class="right">
							<input type="submit" class="input input-inline" style="width:100px;" value="추가">
							<a href="<%=request.getContextPath()%>/admin/employee.jsp"><input type=button id="cancle-Btn" class="input input-inline" style="width:100px;" value="취소"></a>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</form>
	
</div>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>