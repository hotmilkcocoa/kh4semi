<%@page import="groupware.beans.AnnualDto"%>
<%@page import="groupware.beans.AnnualDao"%>
<%@page import="groupware.beans.VacationDto"%>
<%@page import="java.util.List"%>
<%@page import="groupware.beans.VacationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
//	int emp_no = (int) session.getAttribute("check");
	int emp_no = 3;
	//연차 테이블 데이터 가져오기
	AnnualDao annualDao = new AnnualDao();
	AnnualDto annualDto = annualDao.find(emp_no);
	
	//휴가 신청 내역 가져오기
	int listSize = 5;
	
	//페이징 정보
	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p<1) throw new Exception();
	} catch(Exception e){
		p = 1;
	}
	int endRow = p * listSize;
	int startRow = endRow - listSize + 1;
	
	VacationDao vacationDao = new VacationDao();
	List<VacationDto> vacationList = vacationDao.select(emp_no, startRow, endRow);
	
	//블록 정보
	int blockSize = 5;
	
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	int count = vacationDao.getCount(emp_no);
	
	int pageSize = (count + listSize -1) / listSize;
	
	if(endBlock > pageSize) endBlock = pageSize;
%>

<h1 class="title center">2021.1</h1>
<hr>
<div class="row right">
 	입사일 : <%=annualDao.getHireDate(emp_no) %>
</div>
<div class="row center">
    <table class="table table-border vacationTable">
        <tr>
            <td>발생 월차</td>
            <td>총 연차</td>
            <td>사용 연차</td>
            <td>잔여 연차</td>
        </tr>
        <tr>
            <td>?</td>
            <td><%=annualDto.getAnn_occurred() %></td>
            <td><%=annualDto.getAnn_used() %></td>
            <td><%=annualDto.getAnn_occurred() - annualDto.getAnn_used() %></td>
        </tr>
    </table>
</div>
<hr>
<div class="row">
	<h3>사용 내역</h3>
</div>
<div class="row">
    <table class="vacTable table table-border">
        <tr>
            <td>번호</td>
            <td>분류</td>
            <td>기간</td>
            <td>사유</td>
            <td>기타사항</td>
            <td>신청일</td>
            <td>상태</td>
            <td>관리</td>
        </tr>
        <%
        int index = vacationList.size();
        for(VacationDto dto : vacationList){ 
        %>
        <tr>
            <td><%=index%></td>
            <td><%=dto.getVac_category() %></td>
            <td><%=dto.getVac_start() %> - <%=dto.getVac_end() %></td>
            <td><%=dto.getVac_reason() %></td>
            <td><%=dto.getVac_comment() %></td>
            <td><%=dto.getVac_write_date() %></td>
            <td><%=dto.getVac_status() %></td>
            <td>
            	<%if(!dto.getVac_status().equals("대기")){ %>
            		<button class="vacEditBtn" disabled>수정</button> | 
            		<button class="vacDelBtn" disabled>취소</button>
            	<%} else{ %>
            		<button class="vacEditBtn" vac_no=<%=dto.getVac_no() %>>수정</button> | 
            		<button class="vacCancelBtn" vac_no=<%=dto.getVac_no() %>>취소</button>
            	<%} %>
            </td>
        </tr>
        <%index--;} %>
    </table>
</div>
<div class="row">
	<ul class="pagination">
		<li><a class="paginatin arrow" href="vac_status.jsp?p=<%=startBlock-1%>">&lt;</a></li>
		
		<%for(int i=startBlock; i<=endBlock; i++){ %>
			<%if(i == p){ %>
			<li class="active">
			<%}else{ %>
			<li>
			<%} %>
			<a class="pagination num" href="vac_status.jsp?p=<%=i%>"><%=i%></a>
			</li>
		<%} %>
		
		<li><a class="paginatin arrow" href="vac_status.jsp?p=<%=endBlock+1 > pageSize ? pageSize : endBlock+1%>">&gt;</a></li>
	</ul>
</div>
<div class="row right">
	<input type="button" value="신청하기" class="vacAdd">
</div>
<script>
	document.querySelector(".vacAdd").addEventListener("click", function(){
		location.href = "vac_add.jsp";
	});
	document.querySelectorAll(".vacEditBtn").forEach(function(ele){
		ele.addEventListener("click", function(){
			location.href = "vac_add.jsp?edit&vac_no=" + this.getAttribute("vac_no");
		});
	});
	document.querySelectorAll(".vacCancelBtn").forEach(function(ele){
		ele.addEventListener("click", function(){
			location.href = "vac_sign.do?cancel&vac_no=" + this.getAttribute("vac_no");
		});
	});
</script>
<jsp:include page="/template/footer.jsp"></jsp:include>