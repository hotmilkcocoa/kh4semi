<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<h1 class="title">일정 등록</h1>
<hr>
<div class="container">
    <form action="">
        <div class="row rel">
            <span>일정명</span>
            <div class="data">
                <input class="dataInput text" type="text" name="sch_name">
            </div>
        </div>
        <div class="row rel">
            <span>일시</span>
            <div class="data">
                <input class="dataInput date" type="date" name="sch_start_date">
                <select class="dataInput select" name="sch_start_time">
                    <option value="">00:00</option>
                    <option value="">01:00</option>
                    <option value="">02:00</option>
                    <option value="">03:00</option>
                    <option value="">04:00</option>
                    <option value="">05:00</option>
                    <option value="">06:00</option>
                    <option value="">07:00</option>
                    <option value="">08:00</option>
                    <option value="">09:00</option>
                    <option value="">10:00</option>
                    <option value="">11:00</option>
                    <option value="">12:00</option>
                    <option value="">13:00</option>
                    <option value="">14:00</option>
                    <option value="">15:00</option>
                    <option value="">16:00</option>
                    <option value="">17:00</option>
                    <option value="">18:00</option>
                    <option value="">19:00</option>
                    <option value="">20:00</option>
                    <option value="">21:00</option>
                    <option value="">22:00</option>
                    <option value="">23:00</option>
                </select>
                - 
                <input class="dataInput date" type="date" name="sch_end_date">
                <select class="dataInput select" name="sch_end_time">
                    <option value="">00:00</option>
                    <option value="">01:00</option>
                    <option value="">02:00</option>
                    <option value="">03:00</option>
                    <option value="">04:00</option>
                    <option value="">05:00</option>
                    <option value="">06:00</option>
                    <option value="">07:00</option>
                    <option value="">08:00</option>
                    <option value="">09:00</option>
                    <option value="">10:00</option>
                    <option value="">11:00</option>
                    <option value="">12:00</option>
                    <option value="">13:00</option>
                    <option value="">14:00</option>
                    <option value="">15:00</option>
                    <option value="">16:00</option>
                    <option value="">17:00</option>
                    <option value="">18:00</option>
                    <option value="">19:00</option>
                    <option value="">20:00</option>
                    <option value="">21:00</option>
                    <option value="">22:00</option>
                    <option value="">23:00</option>
                </select>
            </div>
        </div>
        <div class="row rel">
            <span>내용</span>
            <div class="data">
                <textarea class="dataInput textarea" name="sch_content" rows="10"></textarea>
            </div>
        </div>
        <div class="row rel">
            <span>장소</span>
            <div class="data">
                <input class="dataInput text" type="text" name="">
            </div>
        </div>
        <div class="row rel">
            <span>공개</span>
            <div class="data">
                <label>
                    <input type="radio" name="sch_open">
                    공개
                </label>
                <label>
                    <input type="radio" name="sch_open">
                    비공개
                </label>
            </div>
        </div>
        <div class="row rel">
            <input class="dataInput" type="submit" value="저장">
            <input class="dataInput" type="button" value="취소">
        </div>
    </form>
</div>
            
<jsp:include page="/template/footer.jsp"></jsp:include>  