<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Work-System</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" ></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  	
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/searchMember/comm.js" ></script>
<link href="resources/blog.css" rel="stylesheet">
<script type="text/javascript">
	
</script>
<style type="text/css">
	.loginUser { margin: auto; text-align: right;  }
	.registerForm { width: 900px; margin: auto; }
</style>
	
</head>
<body>

<div class="container">
<header class="blog-header py-3">
    <div class="row flex-nowrap justify-content-between align-items-center">
      <div class="col-12 text-center">
        <a class="blog-header-logo text-dark" href="main">Work System</a>
      </div>
    </div>
      <sec:authentication property="authorities" var="role"/>
      <form:form action="${pageContext.request.contextPath}/logout" method="POST">
    <div class="loginUser">
		<span style=" font-size: 20px; font-weight: bold;">
		<c:forEach items="${auth }" var="vo">
		${vo.name } <c:if test="${role eq '[ROLE_ADMIN]' }">( 관리자 )</c:if> 님 </c:forEach></span><input class="btn btn-dark" type="submit" value="로그아웃" />
    </div>
	</form:form>
  </header>
<div class="nav-scroller py-1 mb-2">
    <nav class="nav d-flex justify-content-between">
      <a class="p-2 text-muted" href="notice">공지사항</a>
      <a class="p-2 text-muted" href="schedule">일정관리</a>
      <a class="p-2 text-muted" href="board">사내 게시판</a>
      <a class="p-2 text-muted" href="searchMember">직원 조회</a>
      <sec:authorize access="hasRole('ROLE_ADMIN')">
      <a class="p-2 text-muted" href="register">직원 등록</a>
      </sec:authorize>
      <a class="p-2 text-muted" href="updatePersonal">정보수정</a>
    </nav>
  </div>
	<hr />
</div>
<div style="width: 900px; margin: auto; ">
	<form action="searchName" method="POST">
	<div style="display:inline; width: 100px;">
	<span style="font-size: 18px;">전체 : ${nameCount } 명</span>
	</div>
	<div style="display:inline; float: right;">
	<%-- 이부분을 반드시 숨겨서 가져가야 한다. --%>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="text" id="name" name="name" /><button class="btn btn-dark btn-sm" style="margin: auto auto 10px 10px;">검색</button>
	</div>
	</form>
	<table class="table">
  <thead>
    <tr>
      <th scope="col">사번</th>
      <th scope="col">이름</th>
      <th scope="col">직급</th>
      <th scope="col">연락처</th>
    </tr>
  </thead>
  <tbody>
		<c:if test="${empty pagingVO.list }">
  		<tr>
  	  		<td colspan="5" style="text-align: center;"><h3 style="margin: 30px;">정보가 존재하지 않습니다.</h3></td>
  		</tr>
  		</c:if>
    	<c:if test="${not empty pagingVO.list }">
		<c:forEach items="${pagingVO.list }" var="vo">
    <tr>
    	<th scope="row">
    	<form action="changeMember" method="POST">
    	<%-- 이부분을 반드시 숨겨서 가져가야 한다. --%>
	<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
    	<c:if test="${role eq '[ROLE_ADMIN]' }">
			${vo.userid }  <button id="userid" name="userid" class="btn btn-outline-info btn-sm" value="${vo.userid }">수정</button>
    	</c:if>
    	</form>
    	<c:if test="${role eq '[ROLE_USER]' }">
	    	${vo.userid }
    	</c:if>
    	</th>
    	<td>${vo.name }</td>
  		<td>${vo.lvl }</td>
    	<td>${vo.phone }</td>
    </tr>
		</c:forEach>
    	</c:if>
  </tbody>
</table>
<input type="hidden" id="s_name" name="v_name" value="${name}" />
	<div>
  		${pagingVO.pageList }
  	</div>
</div>

</body>
</html>