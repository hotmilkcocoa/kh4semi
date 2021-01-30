<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@page import="groupware.beans.AnnualDto"%>
<%@page import="groupware.beans.AnnualDao"%>
<%@page import="groupware.beans.VacationDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.VacationDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupware.beans.AttendanceDto"%>
<%@page import="groupware.beans.AttendanceDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<%
	int emp_no = (int) session.getAttribute("check");

	EmployeeDao empDao = new EmployeeDao();
	EmployeeDto empDto = empDao.find(emp_no);
	
	//부서장인지 검사(인사부 제외)
	boolean isDephead = empDto.getEmp_title().equals("팀장");
	if(!isDephead) response.sendError(403);
	
	VacationDao vacationDao = new VacationDao();
	List<VacationDto> vacationList;

	//페이징 정보
	int listSize = 10;
	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p<1) throw new Exception();
	} catch(Exception e){
		p = 1;
	}
	int endRow = p * listSize;
	int startRow = endRow - listSize + 1;
	
	//직급에 맞게 목록 가져오기
	String approver;
	int count;
	vacationList = vacationDao.selectForDephead(emp_no, startRow, endRow);
	count = vacationDao.getCountForDephaed(emp_no);
	approver = "dephead";
	
	//블록 정보
	int blockSize = 5;
	
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	
	int pageSize = (count + listSize -1) / listSize;
	
	if(endBlock > pageSize) endBlock = pageSize;
%>
<div class="row">
	<h1><%=approver %></h1>
	<h3>신청 리스트</h3>
</div>
<div class="row">
    <table class="vacTable table table-border">
        <tr>
            <td>번호</td>
            <td>분류</td>
            <td>기간</td>
            <td>사유</td>
            <td>기타사항</td>
            <td>신청자</td>
            <td>신청일</td>
            <td>상태</td>
            <td>관리</td>
        </tr>
        
        <%
		//목록 가져와서 출력
        int index = 0;
        if(vacationList.size() != 0){
	        for(VacationDto dto : vacationList){ 
	        	EmployeeDto targetDto = empDao.find(dto.getVac_target_no());
	        %>
		        <tr>
		            <td><%=count-((p-1)*listSize)-index%></td>
		            <td><%=dto.getVac_category() %></td>
		            <td><%=dto.getVac_start() %> - <%=dto.getVac_end() %></td>
		            <td><%=dto.getVac_reason() %></td>
		            <td><%=dto.getVac_comment() %></td>
		            <td><%=targetDto.getEmp_name()%>(<%=targetDto.getEmp_dep()%>)</td>
		            <td><%=dto.getVac_write_date() %></td>
		            <td><%=dto.getVac_status() %></td>
		            <td>
		        		<button class="vacRejectBtn" vac_no=<%=dto.getVac_no() %>>반려</button> | 
		        		<button class="vacApproveBtn" vac_no=<%=dto.getVac_no() %>>승인</button>
		            </td>
		        </tr>
		        <%index++;
	        }%>
	        <tr>
	        	<td colspan="9">
					<div class="row center">
						<ul class="pagination">
							<li><a href="vac_app.jsp?p=<%=startBlock-1%>">&lt;</a></li>
							<%for(int i=startBlock; i<=endBlock; i++){ %>
								<%if(i == p){ %>
								<li class="active">
								<%}else{ %>
								<li>
								<%} %>
								<a href="vac_app.jsp?p=<%=i%>"><%=i%></a>
								</li>
							<%} %>
							<li><a href="vac_app.jsp?p=<%=endBlock+1 > pageSize ? pageSize : endBlock+1%>">&gt;</a></li>
						</ul>
					</div>
	        	</td>
	        </tr>
        <% } else {%>
        	<tr>
        		<td colspan="9">정보가 없습니다.</td>
        	</tr>
        <%} %>
    </table>
</div>
<script>
	var approver = "<%=approver%>";
	document.querySelectorAll(".vacRejectBtn").forEach(function(ele){
		ele.addEventListener("click", function(){
			location.href = "vac_sign.do?reject&vac_no={1}&approver={2}".replace("{1}", this.getAttribute("vac_no")).replace("{2}", approver);
		});
	});
	document.querySelectorAll(".vacApproveBtn").forEach(function(ele){
		ele.addEventListener("click", function(){
			location.href = "vac_sign.do?approve&vac_no={1}&approver={2}".replace("{1}", this.getAttribute("vac_no")).replace("{2}", approver);
		});
	});
	
	<%if(request.getParameter("error")!=null){%>
		alert("잔여 연차가 부족합니다.");
	<%}%>
</script>
<jsp:include page="/template/footer.jsp"></jsp:include> 