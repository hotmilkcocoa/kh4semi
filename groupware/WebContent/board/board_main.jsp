<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="groupware.beans.*" %>
<jsp:include page="/template/board_header.jsp"></jsp:include>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
BoardDao boardDao = new BoardDao();
List<BoardDto> mainlist = boardDao.mainlist();
%>

<%
BoardPaymentDao boardpaymentDao = new BoardPaymentDao();
List<BoardPaymentDto> paymentlist = boardpaymentDao.paymentlist();
%>

<%
BoardFreeDao boardfreeDao = new BoardFreeDao();
List<BoardFreeDto> freelist = boardfreeDao.freelist();
%>

<%
//검색창
String type = request.getParameter("type");
String key = request.getParameter("key");
boolean isSearch = type != null && key != null;
%>

<link rel="stylesheet" type="text/css" href="./css/common.css">
<style>
.outbox{
	padding:0.75rem;
}
</style>
    <div class="outbox" align="center">
    
    <!-- 검색창 -->	
	 <div class="trans" align ="right" style="line-height:20px">
		<form action="board_main.jsp" method="post">
			<div class="row">
				<select name="type" class="input input-inline">
					<option value="board_title" <%if(type!=null&&type.equals("board_title")){%>selected<%}%>>제목</option>
					<option value="board_dep" <%if(type!=null&&type.equals("board_dep")){%>selected<%}%>>부서</option>
				</select>
				
			<%if(isSearch){ %>
				<input type="text" class="input input-inline" name="key" required value="<%=key%>">
			<%}else{ %>
				<input type="text" class="input input-inline" name="key" required>
			<%} %>
			
				<input type="submit" class="input input-inline" value="검색">
			
			</div>
		</form>
    </div>
    		<table class="payment" style="width:900px">
    			<tbody>
  		  			<tr>
    					<th>번호</th>
    					<th>결재</th>
    					<th>제목</th>
    					<th>일시</th>
    					<th>부서</th>
    				</tr>
    			</tbody>
    		
    			<tbody>
    			
    			<%for(BoardPaymentDto dto : paymentlist){ %>
    				<tr>	
    					<td><%=dto.getPayment_no() %></td>
    					<td><%=dto.getPayment_header()%></td>
						<td class="left">
							<%if(dto.getPayment_header() != null){ %>
								[<%=dto.getPayment_header()%>]
							<%}%>
							<a href="detail.jsp?board_no=<%=dto.getPayment_no()%>">				
								<%=dto.getPayment_title()%>
							</a>
						</td>
    					<td><%=dto.getPayment_date()%></td>
    					<td><%=dto.getBoard_dep()%></td>
    				</tr>
    				<%} %>
    				
    			</tbody>    		
    		</table>
<br>
<hr>
<br>
    		<table class="notice" style="width:900px">
    			<tbody>
    				<tr>
    					<th>번호</th>
    					<th>공지</th>
    					<th width="400px;">제목</th>
    					<th>일시</th>
    					<th>부서구분</th>
    				</tr>
				</tbody>
				
				<tbody>
				<%for(BoardDto dto :mainlist){ %>
    					<tr>
						<td><%=dto.getBoard_no() %></td>
						<td><%=dto.getBoard_header() %></td>
						<td class="left">
							<%if(dto.getBoard_header() != null){ %>
								[<%=dto.getBoard_header()%>]
							<%}%>
							<a href="detail.jsp?board_no=<%=dto.getBoard_no()%>">				
								<%=dto.getBoard_title()%>
							</a>
						</td>
    					<td><%=dto.getBoard_writedate()%></td>
    					<th><%=dto.getBoard_dep() %></th>
    					</tr>
    					<%} %>
    			</tbody>
    		</table>
         <br>
         <hr>
         <br>
    		<table class="free" style="width:900px;">
    		    	<tr>
    		    		<th>글 번호</th>
    		    		<th>제목</th>
    		    		<th>작성자</th>
    					<th>작성날짜</th> 
    				</tr>  
    			
    			<tbody>
    			<%for(BoardFreeDto dto : freelist){%>
    				<tr>
    					<td><%=dto.getFree_no() %></td>
						<td class="left">
							<%if(dto.getFree_header() != null){ %>
								[<%=dto.getFree_header()%>]
							<%}%>
							<a href="detail.jsp?free_no=<%=dto.getFree_no()%>">				
								<%=dto.getFree_title()%>
							</a>
						</td>
    		    		<td><%=dto.getFree_writer() %></td>
    					<td><%=dto.getFree_writedate()%></td> 
    				</tr> 
    				<%} %>
    			</tbody>  			
    		</table>
    </div>
<jsp:include page="/template/board_footer.jsp"></jsp:include>

