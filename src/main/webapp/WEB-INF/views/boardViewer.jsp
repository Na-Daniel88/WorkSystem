<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script src="https://code.jquery.com/jquery-3.2.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" ></script>
<link href="resources/blog.css" rel="stylesheet">
<script type="text/javascript">
function edit_page(idx) {
	var form = document.createElement("form");
	
	form.action = "boardeditform";
	form.method = "post";
	
	var csrfValue = $("#_csrf").val();
	
    csrf = document.createElement("input");
    csrf.setAttribute("type", 'hidden');
    csrf.setAttribute("name", '_csrf');
    csrf.setAttribute("value", csrfValue);
    form.appendChild(csrf);
	
	var hiddenField = document.createElement("input");
	hiddenField.setAttribute("name", "idx");
	hiddenField.setAttribute("value", idx);
	
	form.appendChild(hiddenField);
	document.body.appendChild(form);
	form.submit();
	
}

function boardDelete(idx) {
	var form = document.createElement("form");
	
	form.action = "boardDeleteOK";
	form.method = "post";
	
	var csrfValue = $("#_csrf").val();
	
    csrf = document.createElement("input");
    csrf.setAttribute("type", 'hidden');
    csrf.setAttribute("name", '_csrf');
    csrf.setAttribute("value", csrfValue);
    form.appendChild(csrf);
	
	var hiddenField = document.createElement("input");
	hiddenField.setAttribute("type", "hidden");
	hiddenField.setAttribute("name", "idx");
	hiddenField.setAttribute("value", idx);
	
	form.appendChild(hiddenField);
	document.body.appendChild(form);
	form.submit();
	
}
	
</script>
<style type="text/css">
	.loginUser { margin: auto; text-align: right;  }
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
      <sec:authentication property="principal.username" var="username"/>
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
<div style="width: 700px; margin: auto; ">
	<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="idx" value="${vo.idx}" />

		<table class="table table-bordered">
			<thead>
				<tr>
					<th scope="col" width="15%">제목</th>
					<th scope="col">${vo.title }</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row">작성자</th>
					<td>${vo.writer }</td>
				</tr>
				<tr>
					<th scope="row">시간</th>
					<td><fmt:formatDate value="${vo.boardDate }" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td style="height: 250px;">${vo.content }</td>
				</tr>
			</tbody>
		</table>

  <div style="text-align: center; margin: 30px;">
  <c:if test="${role eq '[ROLE_ADMIN]' }">
  	<button type="submit" class="btn btn-danger" onclick="javascript:boardDelete('${vo.idx }')">삭제</button>
  </c:if>
  <c:if test="${vo.userid eq username }">
	<button type="submit" class="btn btn-primary" onclick="javascript:edit_page('${vo.idx }')">수정</button>
  </c:if>
	<button type="submit" class="btn btn-primary" onclick="location='board'">목록</button>
  </div>
</div>
	



	
</body>
</html>