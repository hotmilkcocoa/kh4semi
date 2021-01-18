<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

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
    <h3>휴가 신청</h3>
</div>
<div class="row">
    <form action="">
        <fieldset>
            <div class="row rel">
                <span>신청기간</span>
                <div class="data">
                    <input class="dataInput date" type="date" name="vac_start">
                     - 
                    <input class="dataInput date" type="date" name="vac_end">
                </div>
            </div>
            <div class="row rel">
                <span>사유</span>
                <div class="data">
                    <select class="dataInput select" name="vac_category">
                        <option>연차</option>
                        <option>반차</option>
                    </select>
                </div>
            </div>
            <div class="row rel">
                <span>상세내용</span>
                <div class="data">
                    <input class="dataInput text" type="text" name="vac_reason">
                </div>
            </div>
            <div class="row rel">
                <span>기타사항</span>
                <div class="data">
                    <textarea class="dataInput textarea" name="vac_content" cols="30" rows="10"></textarea>
                </div>
            </div>
            <div class="row">
                <input type="submit" value="신청">
                <input type="button" value="취소">
            </div>
        </fieldset>
    </form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>