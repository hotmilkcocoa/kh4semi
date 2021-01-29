<%@page import="groupware.beans.AnnualDto"%>
<%@page import="groupware.beans.AnnualDao"%>
<%@page import="groupware.beans.VacationDto"%>
<%@page import="groupware.beans.VacationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	int emp_no = (int) session.getAttribute("check");

	boolean isEdit = request.getParameter("edit") != null;
	VacationDto vacationDto = null;
	if(isEdit){
		VacationDao vacationDao = new VacationDao();
		vacationDto = vacationDao.find(Integer.parseInt(request.getParameter("vac_no")));
	}
	AnnualDao annualDao = new AnnualDao();
	AnnualDto annualDto = annualDao.find(emp_no);
%>

<div class="row right">
 	입사일 : <%=annualDao.getHireDate(emp_no) %>
</div>
<div class="row center">
    <table class="table table-border vacationTable">
        <tr>
            <td>총 연차</td>
            <td>사용 연차</td>
            <td>잔여 연차</td>
        </tr>
        <tr>
            <td><%=annualDto.getAnn_occurred() %></td>
            <td><%=annualDto.getAnn_used() %></td>
            <td><%=annualDto.getAnn_occurred() - annualDto.getAnn_used() %></td>
        </tr>
    </table>
</div>
<hr>
<div class="row">
	<%if(isEdit){ %>
   		<h3>휴가 수정</h3>
    <%} else{ %>
    	<h3>휴가 신청</h3>
    <%} %>
</div>
<div class="row">
	<%if(isEdit){ %>
	    <form action="vac_add.do?edit" method="post">
	    <input type="hidden" name="vac_no" value="<%=vacationDto.getVac_no()%>">
    <%} else{ %>
    	<form action="vac_add.do" method="post">
	<%} %>
        <fieldset>
            <div class="row rel">
                <span>구분</span>
                <div class="data">
                    <select class="dataInput select" name="vac_category" required>
                        <option <%if(isEdit && vacationDto.getVac_category().equals("연차")){ %>selected<%} %>>연차</option>
                        <option <%if(isEdit && vacationDto.getVac_category().equals("반차")){ %>selected<%} %>>반차</option>
                        <option <%if(isEdit && vacationDto.getVac_category().equals("기타")){ %>selected<%} %>>기타</option>
                    </select>
                </div>
            </div>
            <div class="row rel">
                <span>대상자</span>
                <div class="data">
                    <label>
	                    <input type="radio" name="vac_target" value="true" checked>
	                   	 본인
	                </label>
	                <label>
	                    <input type="radio" name="vac_target" value="false">
	                   	 타 사용자
	                </label>
                </div>
            </div>
            <div class="row rel">
                <span>신청기간</span>
                <div class="data">
                    <input class="dataInput date" type="date" name="vac_start" required <%if(isEdit){ %>value="<%=vacationDto.getVac_start()%>"<%} %>>
                    <span class="hyphen">-</span> 
                    <input class="dataInput date" type="date" name="vac_end" required <%if(isEdit){ %>value="<%=vacationDto.getVac_end()%>"<%} %>>
                </div>
            </div>
            <div class="row rel">
                <span>사유</span>
                <div class="data">
                    <input class="dataInput text" type="text" name="vac_reason" required <%if(isEdit){ %>value="<%=vacationDto.getVac_reason()%>"<%} %>>
                </div>
            </div>
            <div class="row rel">
                <span>기타사항</span>
                <div class="data">
                    <textarea class="dataInput textarea" name="vac_comment" required> <%if(isEdit){ %><%=vacationDto.getVac_comment()%><%} %></textarea>
                </div>
            </div>
            <div class="row">
                <input type="submit" value="신청">
                <input type="button" value="취소" class="cancelBtn">
            </div>
        </fieldset>
    </form>
</div>
<script>
	document.querySelector(".cancelBtn").addEventListener("click", function(){
		window.history.back();
	});
	var vacDate = document.querySelectorAll(".dataInput.date");
	vacDate.forEach(function(ele){
		ele.addEventListener("input", function(){
			if(vacDate[1].value < vacDate[0].value && vacDate[1].value){
				alert("신청기간을 확인해주세요.");
				vacDate[1].value = vacDate[0].value;
			}
		});
	});
	<%if(request.getParameter("error")!=null){%>
		alert("잔여 연차가 부족합니다.");
	<%}%>

</script>
<jsp:include page="/template/footer.jsp"></jsp:include>