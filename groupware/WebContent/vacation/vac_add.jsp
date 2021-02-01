<%@page import="groupware.beans.EmployeeDao"%>
<%@page import="groupware.beans.AnnualDto"%>
<%@page import="groupware.beans.AnnualDao"%>
<%@page import="groupware.beans.VacationDto"%>
<%@page import="groupware.beans.VacationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	request.setCharacterEncoding("UTF-8");
	
	String emp_name = request.getParameter("emp_name"); //주소록에서 선택한 사원의 이름
	String empno = request.getParameter("emp_no"); //주소록에서 선택한 사원의 번호
	
	boolean isCheck = emp_name != null && empno != null; //체크가 되어서 들어온 정보라면 isCheck
	
	String[] empName = new String[]{};
	String[] empNo = new String[]{};
	if(isCheck) {
		empName = emp_name.split(",");
		empNo = empno.split(",");
	}	
	
	int emp_no = (int) session.getAttribute("check");

	boolean isEdit = request.getParameter("edit") != null;
	VacationDto vacationDto = null;
	if(isEdit){
		VacationDao vacationDao = new VacationDao();
		vacationDto = vacationDao.find(Integer.parseInt(request.getParameter("vac_no")));
	}
	AnnualDao annualDao = new AnnualDao();
	AnnualDto annualDto = annualDao.find(emp_no);
	
	String target_no = request.getParameter("emp_no");
	String[] noArr = target_no!=null ? target_no.split(",") : null;
	
	EmployeeDao empDao = new EmployeeDao();
%>
<script>
	//자식창에서 값전달
	function empAdd1(nameArray){
		var a = $("#msg_receiver").prop("value");
		if(a != "") {
		var b = a +","+ nameArray;
		var valArray = b.split(",");
		var set = new Set(valArray);
		var uniqueArr = [...set];
		$("#msg_receiver").prop("value", uniqueArr);
		} else {
			var set = new Set(nameArray);
			var uniqueArr = [...set];
			$("#msg_receiver").prop("value", uniqueArr);
		}
		document.querySelector(".target_no").value = nameArray.toString();
	};
	
	function empAdd2(noArray) {
		document.querySelector("input[name=target_no]").value = noArray.toString();
	}
	$(function() {
		var empno = new Array();
		<% for(int i = 0; i < empNo.length; i ++) {%>
			empno.push(<%=empNo[i]%>)
		<%}%>
		$("input[name=msg_receiver]").attr("value", empno);
		
		
		//주소록에서 가져온 사원추가
		<%if(isCheck) {  %>		
				var array = new Array();
				<%for(int i = 0; i < empName.length; i++) {%>
					array.push(
						"<%=empName[i]%>"
					);
					<%} %>
				$("#msg_receiver").val(array);
		<% } else {%>
				$("#msg_receiver").val("");
		<% }%>
		
		$("#search-btn").click(function() {
			window.open("<%=request.getContextPath()%>/message/search.jsp", "사원검색", "width=700px, height=600px");
		});
		
		//취소버튼
		$("#cancel-btn").click(function() {
			if(confirm("작성 중인 내용이 사라집니다. 취소하시겠습니까?")) {
				location.href="inbox.jsp"
			}
		});
		
		
		
	});
	
	
</script>
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
	                <span class="addr">
		                <input type="text" name="" class="target_no" readonly>
		                <input type="hidden" name="target_no" >
		                <button id="search-btn">주소록</button>
	                </span>
                </div>
            </div>
            <div class="row rel">
                <span>신청기간</span>
                <div class="data">
                    <input class="dataInput date start" type="date" name="vac_start" required <%if(isEdit){ %>value="<%=vacationDto.getVac_start()%>"<%} %>>
                    <span class="hyphen">-</span> 
                    <input class="dataInput date end" type="date" name="vac_end" required <%if(isEdit){ %>value="<%=vacationDto.getVac_end()%>"<%} %>>
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
	document.querySelector(".dataInput.select").addEventListener("input", function(){
		if(this.value=="반차"){
			document.querySelector(".hyphen").classList.add("hide");
			document.querySelector(".date.end").classList.add("hide");
			document.querySelector(".date.end").value = document.querySelector(".date.start").value;
		} else{
			document.querySelector(".hyphen").classList.remove("hide");
			document.querySelector(".date.end").classList.remove("hide");
		}
	});
	document.querySelector(".date.start").addEventListener("input", function(){
		if(document.querySelector(".dataInput.select").value == "반차"){
			document.querySelector(".date.end").value = this.value;
		}
	});
	var targetInput = document.querySelector(".target_no");
	<%if(noArr!=null){
		for(int i=0; i<noArr.length; i++){%>
			targetInput.value = targetInput.value + "<%=empDao.find(Integer.parseInt(noArr[i])).getEmp_name() + (i==noArr.length-1?"":", ")%>";
		<%}
	}%>

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

	$("#search-btn").click(function() {
		window.open("<%=request.getContextPath()%>/message/search.jsp", "사원검색", "width=700px, height=600px");
	});
</script>
<jsp:include page="/template/footer.jsp"></jsp:include>