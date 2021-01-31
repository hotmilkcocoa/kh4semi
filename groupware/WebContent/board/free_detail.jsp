<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="groupware.beans.*" %>
<%@ page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%
	int free_no = Integer.parseInt(request.getParameter("free_no"));

	BoardFreeDao dao = new BoardFreeDao();
	BoardFreeDto dto = dao.find(free_no);
	
	EmployeeDao employeedao = new EmployeeDao();
	EmployeeDto writedto = employeedao.find(dto.getFree_writer());
	
	String auth = (String)session.getAttribute("auth");
	boolean isAdmin = auth.equals("관리자");
	
	int emp_no = (int)session.getAttribute("check");
	EmployeeDto employeedto = employeedao.find(emp_no);
	boolean isOwner = employeedto.getEmp_no()==(dto.getFree_writer());
%>
<%
	BoardReplyDao replyDao = new BoardReplyDao();
	List<BoardReplyDto> replyList = replyDao.select(free_no); 
%>
<%
 	//게시물목록
	int boardSize = 5;

	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();//강제예외
	}
	catch(Exception e){
		p = 1;
	}
	
 	//p의 값에 따라 시작 row번호와 종료 row번호를 계산
	int endRow = p * boardSize;
	int startRow = endRow - boardSize + 1;
%> 
<%
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	boolean isSearch = type != null && key != null;
	
	List<BoardReplyDto> Replylist; 
	
	if(isSearch){
		Replylist = replyDao.pagingList(type,key, startRow, endRow);
		//noticelist = boardDao.select(type,key);
	}
	else{
		Replylist =  replyDao.pagingList(startRow, endRow);
		//noticelist = boardDao.noticelist();
	}
%>    
<%
 	//페이지 네비게이터 계산 코드를 작성
 	//블록 크기를 설정
	int blockSize = 5;
 	
	//페이지 번호에 따라 시작블록과 종료블럭을 계산
	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
 	//endBlock이 마지막 페이지 번호보다 크면 안된다 = 데이터베이스에서 게시글 수를 구해와야 한다.

	int count;
	if(isSearch){
		 count = replyDao.getCount(type,key);
	}
	else{
		count = replyDao.getCount();
	}
	
 	//페이지 개수 = (게시글수 + 9) / 10 = (게시글수 + 페이지크기 - 1) / 페이지크기
	int pageSize = (count + boardSize - 1) / boardSize;

	if(endBlock > pageSize){
		endBlock = pageSize;
	}
%>
<jsp:include page="/template/header.jsp"></jsp:include>

<script>
	$(function(){
		$(".write-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/board/free_write.jsp";
		});
		
		$(".edit-btn").click(function(){
			location.href = "free_edit.jsp?free_no=<%=free_no%>";
		});
		
		$(".delete-btn").click(function(){
			if(confirm("정말 지우시겠습니까?")){
				location.href = "free_delete.do?free_no=<%=free_no%>";
			}
		});
		
		$(".list-btn").click(function(){
			location.href = "<%=request.getContextPath()%>/board/free_list.jsp";
			});
		
		
		//댓글관련 처리
		//1. 최초에 수정화면(.reply-edit)를 숨김 처리
		$(".reply-edit").hide();
		
		//2. 수정버튼(.reply-edit-btn)을 누르면 일반화면(.reply-normal)을 숨기고 수정화면(.reply-edit)을 표시
		// = a태그이므로 기본이벤트를 차단해야한다
		$(".reply-edit-btn").click(function(e){
			e.preventDefault();
			
			$(this).parents(".reply-normal").hide();
			$(this).parents(".reply-normal").next().show();
		});
		
		//3. 작성 취소 버튼(.reply-edit-cancel-btn)을 누르면 수정화면을 숨기고 일반화면을 표시한다.
		$(".reply-edit-cancel-btn").click(function(){
			$(this).parents(".reply-edit").hide();
			$(this).parents(".reply-edit").prev().show();
		});
	});
</script>
<div class="outbox">
	<div class="row center">
		<h2>
			<%=dto.getFree_no() %>번 자유게시글
			<%if(dto.getFree_header()!=null){ %>
				[<%=dto.getFree_header() %>]
			<%} %>
		</h2>
	</div>
	
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th>작성자</th>
					<td class="left"><%=dto.getFree_writer()%></td>
				</tr>
				<tr>
					<th width="20%">제목</th>
					<td class="left"><%=dto.getFree_header()%></td>
				</tr>
				<tr height="200">
					<th>내용</th>
					<td class="left" valign="top"><%=dto.getFree_context()%></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td class="left"><%=dto.getFree_writedate()%></td>
				</tr>
			</thead>
			<tbody>
			<!-- 댓글 목록 -->
				<tr>
					<td colspan="2">
						
						<div class="outbox">
							
							<%for(BoardReplyDto replyDto : replyList){ %>
							
							<!-- 일반 출력 화면 -->
							<div class="row left reply-normal">
								<div>
									<%=replyDto.getReply_writer()%>
									
									<%if(dto.getFree_writer()==(replyDto.getReply_writer())){ %>
										<span style="color:red;">(작성자)</span>
									<%} %>
								</div>
								<div><%=replyDto.getReply_context()%></div>
								<div>
									<%
										SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd E a h:mm:ss");
										String timeFormat = f.format(replyDto.getReply_date());
									%>
									<%=timeFormat%>
									
									<!-- 수정은 본인만, 삭제는 본인과 관리자만 -->
									<%
										boolean isReplyOwner = employeedto.getEmp_no()==(replyDto.getReply_writer());
										
									%>
									<%if(isReplyOwner){ %>
									<a href="#" class="reply-edit-btn">수정</a> |
									<a href="reply_delete.do?reply_no=<%=replyDto.getReply_no()%>&free_no=<%=free_no%>">삭제</a>
									<%} %>
									<%if(isAdmin || isReplyOwner){ %>
									<a href="reply_delete.do?reply_no=<%=replyDto.getReply_no()%>&free_no=<%=free_no%>">삭제</a>
									<%} %>
								</div>
							</div>
							
							<!-- 수정을 위한 화면 : 본인에게만 나오도록 조건을 설정 -->
							<div class="row left reply-edit">
								<form action="reply_edit.do" method="post">
									<input type="hidden" name="reply_no" value="<%=replyDto.getReply_no()%>">
									<input type="hidden" name="reply_origin" value="<%=free_no%>">
									<div class="row">
										<textarea class="input" name="reply_context" required rows="5" 
											placeholder="댓글 작성"><%=replyDto.getReply_context()%></textarea>
									</div>
									<div class="row">
										<input type="submit" value="댓글 수정" class="input input-inline">
										<input type="button" value="작성 취소" class="input input-inline reply-edit-cancel-btn">
									</div>
								</form>
							</div>
							<%} %>
							
						</div>
						
									
					</td>
				</tr>
				
				<!-- 댓글 작성란 -->
				<tr>
					<td colspan="2">
					
						<!-- 댓글 등록 form -->
						<form action="reply_insert.do" method="post">
							<input type="hidden" name="reply_origin" value="<%=free_no%>">
							<div class="row">
								<textarea class="input" name="reply_context" required rows="5" placeholder="댓글 작성"></textarea>
							</div>
							<div class="row">
								<input type="submit" value="댓글 작성" class="input">
							</div>
						</form>
					</td>
				</tr>
				
			<!-- 댓글 페이지 네비게이션 -->
				<tr>
					<td colspan="2">
					<div class="row center">
						<ul class="pagination">
							<%if(isSearch){ %>
								<li><a href="free_detail.jsp?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
							<%}else{ %>
								<li><a href="free_detail.jsp?p=<%=startBlock-1%>">&lt;</a></li>
							<%} %>
							
							
							<%for(int i=startBlock; i<=endBlock; i++){ %>
							<%if(i == p){ %>
							<li class="active">
							<%}else{ %>
							<li>
							<%} %>
								<%if(isSearch){ %>	
								<!-- 검색용 링크  -->
								<a href="free_detail.jsp?p=<%=i%>&type=<%=type%>&key=<%=key%>"><%=i%></a>
								<%}else{ %>
								<!--  목록용 링크  -->
								<a href="free_detail.jsp?p=<%=i%>"><%=i%></a>
								<%} %>
							<li>
							<%} %>
							
							<%if(isSearch){ %>
								<li><a href="free_detail.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
							<%}else{ %>
								<li><a href="free_detail.jsp?p=<%=endBlock+1%>">&gt;</a></li>
							<%} %>
						</ul>
					</div>				
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
