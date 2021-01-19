<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
<Style>
	/*임시 모든 구역 구분 선(테스트)*/	
	main, section, footer, article, aside, div, label, table, th, td{
	    border: 1px dotted #ccc;
	}
	
	/*메인 테두리, 헤더 바닥, 섹션 중간, 푸터 위 구분선 적용*/
	main{
	    border: 2px solid gray;
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
	
	/*푸터 영역 : 높이 30px 고정*/
	footer{
	    height: 25px;
	} 
	/*전체 영역 안쪽 여백 0.1~0.3rem*/
	article{
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
	    width: 20%;
	    height: 570px;
	}
	article{
	    float: right;
	    width: 80%;
	    min-height: 570px;
	}
	

	/*메뉴 설정*/
    aside h2{
    	padding : 0.5rem;
    	margin-top : 5px;
    	margin-bottom : 5px;
    }
    aside #homeBtn{
    	width: 25px;
    	height: 25px;
    	margin-right : 10px;
    }
    
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
    /*본문 제목 부분 설정*/
    article span, .headerImg{
    	margin-left: 10px;
    	font-size: 25px;
    	text-align: center;
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
</head>
<body>
	<main>
        
        <section>
             <!-- 메뉴 부분 -->
            <aside>
            	<div class="row">
            		<h2>관리 메뉴</h2>
            	</div>
            	
            	<div class="row right">
            		<a href="<%=request.getContextPath()%>"><img alt="홈으로" id="homeBtn" src="<%=request.getContextPath()%>/image/house.svg"></a>
            	</div>
            
                <div class="menu">
                    <ul>
                        <li class="menu menu-title"><a href="<%=request.getContextPath()%>/admin/hr.jsp">인사관리</a></li>
                        <ul>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/admin/group.jsp">조직관리</a></li>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/admin/employee.jsp">사원관리</a></li>
                        </ul>
                    </ul>
                    <ul>
                        <li class="menu menu-title"><a href="<%=request.getContextPath()%>/admin/tna.jsp">근태관리</a></li>
                        <ul>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/admin/tna_setting.jsp">기본설정</a></li>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/admin/rest_emp.jsp">휴직자관리</a></li>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/admin/tna_list.jsp">사원근태관리</a></li>
                        </ul>
                    </ul>
                    <ul>
                        <li class="menu menu-title"><a href="<%=request.getContextPath()%>/admin/event.jsp">일정관리</a></li>
                        <ul>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/admin/event_list.jsp">추가일정관리</a></li>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/admin/prev_event_list.jsp">지난일정관리</a></li>
                        </ul>
                    </ul>
                    <ul>
                        <li class="menu menu-title"><a href="<%=request.getContextPath()%>/admin/setting.jsp">설정관리</a></li>
                        <ul>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/admin/data_list.jsp">추가데이터관리</a></li>
                            <li class="menu menu-detail"><a href="<%=request.getContextPath()%>/admin/auth.jsp">권한설정관리</a></li>
                        </ul>
                    </ul>
                </div>
            </aside>
            
            <article>