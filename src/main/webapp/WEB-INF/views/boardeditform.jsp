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
	<form action="boardeditformOK">
	<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="idx" value="${vo.idx}" />
	<input type="hidden" name="userid" value="${vo.userid}" />
	<div class="form-row">
		<div class="form-group col-md-10">
			<label for="title">제목</label>
			<input type="text"	class="form-control" id="title" name="title" value="${vo.title }">
		</div>
	</div>
	<div class="form-row">
		<div class="form-group col-md-4">
			<label for="writer">작성자</label>
			<input type="text" class="form-control" id="writer" name="writer" value="${vo.writer }" readonly="readonly">
		</div>
		<div class="form-group col-md-4">
			<label>시간</label>
			<input type="text" class="form-control" value="<fmt:formatDate value="${vo.boardDate }" pattern="yyyy-MM-dd"/>">
		</div>
	</div>
  <div class="form-group">
    <label for="content">내용</label>
    <textarea class="form-control" id="content" name="content" rows="6">${vo.content }</textarea>
  </div>
  <div style="text-align: center; margin: 30px;">
    <button type="submit" class="btn btn-danger" formaction="javascript:boardDelete('${vo.idx }')">삭제</button>
	<button type="submit" class="btn btn-primary">수정</button>
	<button type="submit" class="btn btn-primary" formaction="board">취소</button>
  </div>
</form>
</div>
	



	
</body>
</html>