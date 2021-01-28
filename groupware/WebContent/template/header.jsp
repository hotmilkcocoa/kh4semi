<%@page import="groupware.beans.EmployeeDto"%>
<%@page import="groupware.beans.EmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/hg19910.css">
<Style>
	/*임시 모든 구역 구분 선(테스트)*/	
	main, header, section, footer, article, aside, div, label, table, th, td{
	    border: 1px dotted #ccc;
	}
	
	/*메인 테두리, 헤더 바닥, 섹션 중간, 푸터 위 구분선 적용*/
	main{
	    border: 2px solid gray;
	}
	header{
	    border-bottom: 2px solid gray;
	}
	aside{
	    border-right: 2px solid gray;
	}
	footer{
	    border-top: 2px solid gray;
	}
	/*메인 영역 : 폭 1200px, 높이 600px 고정*/
	main{
	    width: 1200px;
	    height: 600px;
	    margin: auto;
	}
	/*헤더 영역 : 높이 80px 고정*/
	header{
	    height: 80px;
	}
	/*푸터 영역 : 높이 30px 고정*/
	footer{
	    height: 25px;
	} 
	/*전체 영역 안쪽 여백 0.1~0.3rem*/
	header, article{
	    padding-top: 0.1rem;
	}
	aside, footer{
	    padding: 0rem;
	}
	
	/*사이드와 본문은 2단 배치*/
	section::after{
	    content: "";
	    display: block;
	    clear: both;
	}
	aside{
	    float: left;
	    width: 15%;
	    height: 490px;
	}
	article{
	    float: right;
	    width: 85%;
	    min-height: 490px;
	}
	
	/*헤더 위치 설정*/
	header .profile, .nowpage, .iconbox{
	    display: inline-block;
	}
	header .profile{
	    float: left;
	    width: 30%;
	}
	header .nowpage{
	    float: left;
	    width: 45%;
	}
	header .iconbox{
	    float: left;
	    width: 25%;
	}
	header .profile th,
	header .profile td{
	    width: 85px;
	    height: 29px;
	}
	header .profile td #profileImg{
	    width: 80px;
	    height: 55px;         
	}
	header .nowpage h2{
	    margin-top: 16px;
	    margin-bottom: 16px;
	    width: 400px;
	    text-align: center;
	    display: inline-block;
	}
	header .iconbox td{
	    width: 90px;
	    height: 60px;
	}
	.float-box:after{
	    content: "";
	    display: block;
	    clear: both;
	}
	
	/*메뉴 설정*/
    aside .menu ul{
        padding-left: 30px;
        margin-top: 10px;
        margin-bottom: 10px;
    }
    aside .menu li{
        margin-top: 10px;
        margin-bottom: 10px;
    }
    .menu .menu-title{
        font: bold 18px "";
        list-style: square;
    }
    .menu .menu-detail{
        list-style: circle;
    }
    aside .menu li:hover{
        background-color: #ccc;
    }
    aside .menu li:hover > a{
        color: white;
    }
    .menu a{
        text-decoration: none;
        color: black;
    }
	
	/*푸터 이미지, 글자 설정*/
	footer label{
	    font: bold 12px "";
	    text-align: center;
	}
	footer img{
	    vertical-align: middle;
	}
	
</Style>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>

</script>

<%
	int emp_no = (int) request.getSession().getAttribute("check");
	EmployeeDao empDao = new EmployeeDao();
	EmployeeDto empDto = empDao.find(emp_no);
	
	//부서장인지 인사부 팀장인지 검사
	boolean isHrhead = empDto.getEmp_dep().equals("인사부") && empDto.getEmp_title().equals("팀장");
	boolean isDephead = empDto.getEmp_title().equals("팀장");
%>
</head>
<body>
	<main>
        <header>
            <div class="float-box">
                <!-- 프로필 부분 -->
                <div class="profile">
                    <table>
                        <tbody>
                            <tr>
                                <td rowspan="2" class="center"><img alt="직원사진" id="profileImg" class="img img-circle" src="<%=request.getContextPath()%>/image/profile_img.png"></td>
                                <th>이름</th>
                                <th>직급</th>
                                <td rowspan="2" class="center"><button>로그아웃</button></td>
                            </tr>
                            <tr>
                                <th>부서</th>
                                <td class="center"><a href="#"><img alt="개인정보수정" src="<%=request.getContextPath()%>/image/cog.svg" width="20" height="20"></a></td>     
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- 현재 메뉴 텍스트 부분 -->
                <div class="nowpage">
                    <h2>현재메뉴</h2>
                </div>

                <!-- 아이콘 박스 부분 -->
                <div class="iconbox">
                    <table class="table table-border">
                        <tbody>
                            <tr>
                                <td><a href="<%=request.getContextPath()%>"><img alt="홈버튼" src="<%=request.getContextPath()%>/image/house.svg"></a></td>
                                <td><a href="#"><img alt="쪽지버튼" src="<%=request.getContextPath()%>/image/chat.svg"></a></td>
                                <td><a href="<%=request.getContextPath()%>/admin/home.jsp"><img alt="관리자모드버튼" src="<%=request.getContextPath()%>/image/key.svg"></a></td>
                            </tr>
                        </tbody>   
                    </table>
                </div>
            </div>
        </header>
        <section>
             <!-- 메뉴 부분 -->
            <aside>
                <div class="menu">
                    <ul>
                        <li class="menu menu-title"><a href="<%=request.getContextPath()%>/calendar/calendar.jsp">일정</a></li>
                        <ul>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/calendar/calendar.jsp">내 일정</a></li>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/calendar/share_calendar.jsp">공유 일정</a></li>
                        </ul>
                    </ul>
                    <ul>
                        <li class="menu menu-title"><a href="<%=request.getContextPath()%>/contactList/contList.jsp">주소록</a></li>
                        <ul>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/contactList/contList.jsp">나의 주소록</a></li>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/contactList/contMain.jsp">직원 주소록</a></li>
                        </ul>
                    </ul>
                    <ul>
                        <li class="menu menu-title"><a href="<%=request.getContextPath()%>/attendance/att_status.jsp">근태</a></li>
                        <ul>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/attendance/att_status.jsp">근태 현황</a></li>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/vacation/vac_status.jsp">휴가 현황</a></li>
                            <%if(isDephead || isHrhead){ %>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/vacation/vac_app.jsp">휴가 승인</a></li>
                        	<%} %>
                        </ul>
                    </ul>
                    <ul>
                        <li class="menu menu-title"><a href="">게시판</a></li>
                        <ul>
                            <li class="menu menu-detail"><a href="">공지사항</a></li>
                            <li class="menu menu-detail"><a href="">자유게시판</a></li>
                            <li class="menu menu-detail"><a href="">동호회</a></li>
                            <li class="menu menu-detail"><a href="">결재</a></li>
                        </ul>
                    </ul>
                </div>
            </aside>
            
            <article>
    