<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<div class="scrollbox">
	<h1 class="title center"></h1>
	<input type="button" value="이전" class="prevNext" prev>
	<input type="button" value="다음" class="prevNext">
	<button class="close">모두 접기</button>
    <div class="contentContainer">
    </div>
</div>

<script type="text/template" id="template">
<div class="weekContainer">
	<div class="center listHeader cursor-pointer">
		<span>{week}</span>
		<span>주간 누적 시간 : {cumulative}</span>
	</div>
	<div class="tableContainer hide">
		<table class="workingHourTable table table-border">
			<thead>
				<tr>
					<td width="100px">일자</td>
					<td>출근 시간</td>
					<td>퇴근 시간</td>
					<td>총 근무 시간</td>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<hr>
</div>
</script>
<script>
    function removeAllChild(parent) {
		while (parent.firstChild) {
			parent.removeChild(parent.firstChild);
		}
    }
        
    var today = new Date();
    var temp_date = new Date(today.getFullYear(), today.getMonth(), 1);
    var dayArr = ["일", "월", "화", "수", "목", "금", "토", "일"];

    function paintTemplate(){
		var contentContainer = document.querySelector(".contentContainer");
        removeAllChild(contentContainer);

        for(var i=0; i<6; i++){
            var template = document.querySelector("#template").innerHTML;
            template = template.replace("{week}", (i+1) + "주차");
            contentContainer.innerHTML = contentContainer.innerHTML + template;
        }
        };
 
    function paintTable(){
        paintTemplate();

        document.querySelector(".title").innerHTML = temp_date.getFullYear() + "." + (temp_date.getMonth() + 1);
           
        var start = new Date(temp_date);
        start.setDate(1-start.getDay());
        for(var i=0; i<6; i++){
            for(var j=0; j<7; j++){
                var newTr = document.createElement("tr");
                for(var k=0; k<4; k++){
                    var newTd = document.createElement("td");
                    if(k==0){
                        newTd.innerHTML = start.getDate() + " " + dayArr[j];
                        start.setDate(start.getDate() + 1);
                    }
                    newTr.append(newTd);
                }
                document.querySelectorAll(".workingHourTable>tbody")[i].append(newTr);
            }
            document.querySelectorAll(".listHeader")[i].addEventListener("click", function(){
                this.nextElementSibling.classList.toggle("hide");
            });
        }
    };
    paintTable();

    //이전, 다음 클릭 시 달 변경
	document.querySelectorAll(".prevNext").forEach(function (ele) {
		ele.addEventListener("click", function () {
            var val = 1;
            if (this.hasAttribute("prev")) val = -1;
            temp_date.setMonth(temp_date.getMonth() + val);
            paintTable();
		});
	});
    document.querySelector(".close").addEventListener("click", function(){
        document.querySelectorAll(".tableContainer").forEach(function(ele){
            ele.classList.add("hide");
        });
    });
</script>
<jsp:include page="/template/footer.jsp"></jsp:include>