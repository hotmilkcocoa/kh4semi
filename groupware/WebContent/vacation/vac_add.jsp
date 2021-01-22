<%@page import="groupware.beans.VacationDto"%>
<%@page import="groupware.beans.VacationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	boolean isEdit = request.getParameter("edit") != null;
	VacationDto vacationDto = null;
	if(isEdit){
		VacationDao vacationDao = new VacationDao();
		vacationDto = vacationDao.find(Integer.parseInt(request.getParameter("vac_no")));
	}
%>

<h1 class="title center">2021.01</h1>
<hr>
<div class="row right">
    입사일 : 2019.01.01
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
            <td>?</td>
            <td>?</td>
            <td>?</td>
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
                    <select class="dataInput select" name="vac_category">
                        <option <%if(isEdit && vacationDto.getVac_category().equals("연차")){ %>selected<%} %>>연차</option>
                        <option <%if(isEdit && vacationDto.getVac_category().equals("반차")){ %>selected<%} %>>반차</option>
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
                    <input class="dataInput date" type="date" name="vac_start" <%if(isEdit){ %>value="<%=vacationDto.getVac_start()%>"<%} %>>
                     - 
                    <input class="dataInput date" type="date" name="vac_end" <%if(isEdit){ %>value="<%=vacationDto.getVac_end()%>"<%} %>>
                </div>
            </div>
            <div class="row rel">
                <span>사유</span>
                <div class="data">
                    <input class="dataInput text" type="text" name="vac_reason"  <%if(isEdit){ %>value="<%=vacationDto.getVac_reason()%>"<%} %>>
                </div>
            </div>
            <div class="row rel">
                <span>기타사항</span>
                <div class="data">
                    <textarea class="dataInput textarea" name="vac_comment"> <%if(isEdit){ %><%=vacationDto.getVac_comment()%><%} %></textarea>
                </div>
            </div>
            <div class="row">
                <input type="submit" value="신청">
                <input type="button" value="취소" class="cancel">
            </div>
        </fieldset>
    </form>
</div>
<script>
	document.querySelector(".cancel").addEventListener("click", function(){
		location.href = "vac_status.jsp";
	});
</script>
<jsp:include page="/template/footer.jsp"></jsp:include>