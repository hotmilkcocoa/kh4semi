<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="groupware.beans.*" %>
<%@ page import="java.util.*" %>
<%
	int payment_no = Integer.parseInt(request.getParameter("payment_no"));

	BoardPaymentDao paymentdao = new BoardPaymentDao();
	BoardPaymentDto paymentdto = paymentdao.find(payment_no);

	EmployeeDao employeedao = new EmployeeDao();
	EmployeeDto writedto = employeedao.find(paymentdto.getPayment_writer());
	
	String auth = (String)session.getAttribute("auth");
	boolean isAdmin = auth.equals("관리자");
	
	int emp_no = (int)session.getAttribute("check");
	EmployeeDto employeedto = employeedao.find(emp_no);
	boolean isOwner = employeedto.getEmp_no()==(paymentdto.getPayment_writer());
%>
<%
	BoardReplyDao replyDao = new BoardReplyDao();
	List<BoardReplyDto> replyList = replyDao.select(payment_no); 
%>
<%

%>
<jsp:include page="/template/header.jsp"></jsp:include>
<script>
$(function(){
		$(".write-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/board/payment_write.jsp";
		});
		
		$(".edit-btn").click(function(){
			location.href = "payment_edit.jsp?payment_no=<%=payment_no%>";
		});
		
		$(".delete-btn").click(function(){
			if(confirm("정말 지우시겠습니까?")){
				location.href = "payment_delete.do?payment_no=<%=payment_no%>";
			}
		});
		
		$(".list-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/board/payment_list.jsp";
			});
		
	      $(".submit").click(function(){
	          var sessionCheck = '<%=session.getAttribute("check")%>';
	          var isMember = '<%=employeedto.getEmp_no()%>';
	          if(sessionCheck == isMember){
 	             var re = "결재진행중"
	             re.replace("결재진행중","결재완료");
		         location.href = "payment_btn_submit.do?payment_no=<%=payment_no%>";
	          }
	          else{
	             alert("권한이 없습니다.");
	          }
	       });
		
	      $(".reject").click(function(){
	          var sessionCheck = '<%=session.getAttribute("check")%>';
	          var isMember = '<%=employeedto.getEmp_no()%>';
	          if(sessionCheck == isMember){
 	             var re = "결재진행중"
	             re.replace("결재진행중","결재반려");
		         location.href = "payment_btn_reject.do?payment_no=<%=payment_no%>";
	          }
	          else{
	             alert("권한이 없습니다.");
	          }
	       }); 

	});
</script>

<div class="outbox">
	<div class="row center">
		<h2>
			<%=paymentdto.getPayment_no() %>번 결재게시글
			<%if(paymentdto.getPayment_heater()!=null){ %>
				[<%=paymentdto.getPayment_heater() %>]
			<%} %>
		</h2>
	</div>
	
	<div class="row">
		<table class="table table-boarder">
			<thead>
			</thead>
			
			<tbody>	
				<tr>
					<th>작성자</th>
					<td class="left"><%=paymentdto.getPayment_writer()%></td>
				</tr>
				<tr>
					<th width="20%">제목</th>
					<td class="left"><%=paymentdto.getPayment_title()%></td>
				</tr>
				<tr height="200">
					<th>내용</th>
					<td class="left" valign="top"><%=paymentdto.getPayment_context()%></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td class="left"><%=paymentdto.getPayment_date()%></td>
				</tr>
				<tr>
					<th>받는사람</th>
					<td class="row left"><%=employeedto.getEmp_name() %>
						<button class="input input-inline submit">승인</button>
						<button class="input input-inline reject">거절</button>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td class="row left">
							<form aciton="/file/download.do" method="post" enctype="multipart/form-data">
								file:<input type="file" name="file">
								<input type="submit" value="file download">
						</form>
					</td>
				</tr>
			</tbody>
			
			<tfoot>

				<tr>
					<th class="right" colspan="2">
						<button class="input input-inline write-btn">새글</button>
						<button class="input input-inline edit-btn">수정</button>
						<button class="input input-inline delete-btn">삭제</button>
						<button class="input input-inline list-btn">목록</button>
					</th>
				</tr>
			</tfoot>
		</table>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>