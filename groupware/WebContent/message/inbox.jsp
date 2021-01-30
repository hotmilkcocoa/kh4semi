<%@page import="java.util.List"%>
<%@page import="groupware.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int emp_no = (int)request.getSession().getAttribute("check");

	//받은 메세지함 조회
	MessageDao msgDao = new MessageDao();
	MessageDto dto = new MessageDto();
	List<MessageDto> msgList = msgDao.selectIn(emp_no);
	int count = msgDao.getCount(emp_no);

	
	MessageFileDao msg_FileDao = new MessageFileDao();
	
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<style>
	a {
		text-decoration: none;
		color:#333333;
	}
	/*안읽음표시*/
	.n {
		color:#6633FF;
	}
	
	.float-right {
		float:right;
	}
	
	.float-left {
		float:left;
	}
	
	.choose {
		color: black;
		font: bold 20px "";
	}
	
</style>
<script type="text/javascript">
	
	$(function(){
		//읽음표시
		for(var i = 0; i < <%=count%>; i++) {
			if($(".readCk").eq(i).val() == "N"){
				$(".read").eq(i).addClass("n");
			} else {
				$(".read").eq(i).removeClass("n");
			}
		}
		//전체선택
		$("#allCheck-btn").on("input", function(){
			var check = $(this).prop("checked");
			$(".check-btn").prop("checked", check);
		});
		
		//쪽지작성
		$("#message_write").click(function(){
			location.href="messageWrite.jsp";
		});
		
		//선택삭제
		var chkArray = new Array();
		$("#delete_btn").click(function(){
			if(window.confirm("삭제하시겠습니까?")) {
				$(".check-btn:checked").each(function(index, item){
					chkArray.push($(item).val());
					
				});
				$("#form").append($("<input>").attr("type", "hidden").attr("name", "msg_no").attr("value", chkArray));
					document.form.submit();	
			}
			
		});
		
		
		
		
/* 		var chkArray = new Array();
		$("#delete_btn").click(function(){
			if(window.confirm("삭제하시겠습니까?")) {
				$(".check-btn:checked").each(function(index, item){
					chkArray.push($(item).val());
				});
				$("#hiddenValue").val(chkArray);
				document.form.submit();
			}
			
		}); */
		if($("#msg_receiver").val() == <%=emp_no%>) {
			$("#inbox").addClass("choose");
		}
		
		
		
	});
	
</script>
<div class="outbox float-box">

	<div class="row float-left">
		<form action="inbox_delete.do" method="get" id="form" name="form">
			<input type="button" value="삭제" id="delete_btn" class="input input-inline">
			<input id="message_write" type="button" value="쪽지작성" class="input input-inline">
		</form>
	</div>
	<div class="row float-right">
		<span><a href="inbox.jsp" id="inbox">받은쪽지함</a></span>
		|
		<span><a href="sentbox.jsp" id="sentbox">보낸쪽지함</a></span>
	</div>
	<div class="row">
		<table class="table table-border table-pattern">
			<thead>
				<tr>
					<th style="width:10px;">
						<input type="checkbox" id="allCheck-btn">
					</th>
					<th style="width:10px;">no</th>
					<th style="width:50%;">제목</th>
					<th>발신인</th>
					<th>발신일자</th>
				</tr>
			</thead>
			<tbody>
				<%for(MessageDto msgDto : msgList) { %>
				<tr>
					<td>
						<input type="hidden" value=<%=msgDto.getMessage_receiver()%> id="msg_receiver">
						<input type="checkbox" class="check-btn" value=<%=msgDto.getMessage_no()%>>
					</td>
					<td><%=msgDto.getRownum()%></td>
					<td>
						<input type="hidden" class="readCk" value=<%=msgDto.getRead_check()%>>
						<a class="read" href="msg_detail.jsp?msg_no=<%=msgDto.getMessage_no()%>">
							<%=msgDto.getMessage_title()%>
							<%if(msg_FileDao.check(msgDto.getMessage_no())) {%>
								<img src="../image/file.png" alt="첨부파일여부" style="width:20px; height:20px;">
							<%} %>
							</a>
					</td>
					<td><%=msgDto.getEmp_name()%> <%=msgDto.getEmp_title()%></td>
					<td><%=msgDto.getMessage_time()%></td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>