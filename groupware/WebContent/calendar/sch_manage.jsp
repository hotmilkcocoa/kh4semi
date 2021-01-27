<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<h3>내 일정 관리</h3>
<div class="row">
    <span>내 일정 전체 정리하기</span>
    <input type="button" value="실행" class="delBtn delAll">
</div>
<div class="row">
    <form action="sch_del.do" id="form">
        <input class="dataInput date" type="date" name="delDate" required>
	    <span>이전 일정 정리하기</span>
	    <input type="submit" value="실행" class="delBtn delDate">
    </form>
</div>
<hr>
<h3>공유 일정 관리</h3>
<div class="row">
    <span>목록</span>
</div>
<div>
    <div>
        <table class="table table-border">
            <tr>
                <td>이름</td>
                <td>관리</td>
            </tr>
            <tr>
                <td>박효길</td>
                <td>삭제하기</td>
            </tr>
        </table>
    </div>
    <div class="row">
        <span>이름</span>
        <input class="dataInput" type="text" name="" id="">
        <button>+ 주소록</button>
        <button>추가하기</button>
    </div>
</div>
<button>돌아가기</button>

<script>
	document.querySelector(".delBtn.delAll").addEventListener("click", function(){
		if(confirm("정말 지우시겠습니까?")){
			location.href = "sch_del.do";			
		}
	});
	document.querySelector(".delBtn.delDate").addEventListener("click", function(e){
		e.preventDefault();
		if(confirm("정말 지우시겠습니까?")){
			document.querySelector("#form").submit();
		}
	});
</script>
            
<jsp:include page="/template/footer.jsp"></jsp:include>  