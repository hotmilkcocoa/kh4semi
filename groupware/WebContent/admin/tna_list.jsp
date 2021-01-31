<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@page import="groupware.beans.VacationDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.VacationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int emp_no = (int) session.getAttribute("check");
	String title = (String) session.getAttribute("title");
	EmployeeDao empDao = new EmployeeDao();
	EmployeeDto empDto = empDao.find(emp_no);
	
	//팀장인지 검사
	boolean isDephead = title.equals("팀장");
		
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
	
	//목록 가져오기
	String approver;
	int count;
	
	vacationList = vacationDao.selectForHrhead(emp_no, startRow, endRow);
	count = vacationDao.getCountForHrhead(emp_no);
	approver = "hrhead";
	
	
	//블록 정보
	int blockSize = 5;
	
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	
	int pageSize = (count + listSize -1) / listSize;
	
	if(endBlock > pageSize) endBlock = pageSize;
%>
    
<jsp:include page="/template/admin_header.jsp"></jsp:include>

<div class="outbox" style="width:900px;">
	<!-- 페이지 명 -->
	<div class="row">
		<img alt="휴가 승인" class="headerImg" src="<%=request.getContextPath()%>/image/format_list_bulleted.svg" width="30" height="30"> 
		<span>휴가 승인</span>	
	</div>

	<div class="row">
    <table class="vacTable table table-border">
        <tr>
            <td>번호</td>
            <td>분류</td>
            <td>기간</td>
            <td>사유</td>
            <td>신청자</td>
            <td>신청일</td>
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
		            <td><%=targetDto.getEmp_name()%>(<%=targetDto.getEmp_dep()%>)</td>
		            <td><%=dto.getVac_write_date() %></td>
		            <td>
		        		<button class="vacRejectBtn" vac_no=<%=dto.getVac_no() %>>반려</button> | 
		        		<button class="vacApproveBtn" vac_no=<%=dto.getVac_no() %>>승인</button>
		            </td>
		        </tr>
		        <%index++;
	        }%>
	        <tr>
	        	<td colspan="7">
					<div class="row center">
						<ul class="pagination">
							<li><a href="tna_list.jsp?p=<%=startBlock-1%>">&lt;</a></li>
							<%for(int i=startBlock; i<=endBlock; i++){ %>
								<%if(i == p){ %>
								<li class="active">
								<%}else{ %>
								<li>
								<%} %>
								<a href="tna_list.jsp?p=<%=i%>"><%=i%></a>
								</li>
							<%} %>
							<li><a href="tna_list.jsp?p=<%=endBlock+1 > pageSize ? pageSize : endBlock+1%>">&gt;</a></li>
						</ul>
					</div>
	        	</td>
	        </tr>
        <% } else {%>
        	<tr>
        		<td colspan="8">정보가 없습니다.</td>
        	</tr>
        <%} %>
    </table>
</div>

</div>

<script>
	var approver = "<%=approver%>";
	document.querySelectorAll(".vacRejectBtn").forEach(function(ele){
		ele.addEventListener("click", function(){
			location.href = "<%=request.getContextPath()%>/vacation/vac_sign.do?reject&vac_no={1}&approver={2}".replace("{1}", this.getAttribute("vac_no")).replace("{2}", approver);
		});
	});
	document.querySelectorAll(".vacApproveBtn").forEach(function(ele){
		ele.addEventListener("click", function(){
			location.href = "<%=request.getContextPath()%>/vacation/vac_sign.do?approve&vac_no={1}&approver={2}".replace("{1}", this.getAttribute("vac_no")).replace("{2}", approver);
		});
	});
	
	<%if(request.getParameter("error")!=null){%>
		alert("잔여 연차가 부족합니다.");
	<%}%>
</script>

<jsp:include page="/template/admin_footer.jsp"></jsp:include>    

