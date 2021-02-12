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
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js" ></script>
<script src="${pageContext.request.contextPath }/resources/js/comm.js" ></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<link href="resources/blog.css" rel="stylesheet">
<script type="text/javascript">
function edit_page(idx) {
	var form = document.createElement("form");
	
	form.action = "noticeViewer";
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
	.noticeform { width: 900px; margin: auto;}
	.no { text-align: center; }
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
	<%-- 이부분을 반드시 숨겨서 가져가야 한다. --%>
	<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
	<div style="display: inline; float: right;" >
	<span style="font-size: 18px;">전체 : ${noticeCount } 개</span>
	</div>
	<table class="table table-sm noticeform">
  <thead>
    <tr>
      <th class="no" scope="col" width="7%">#</th>
      <th scope="col" width="50%">title</th>
      <th scope="col" width="15%">date</th>
      <th scope="col" width="10%">writer</th>
    </tr>
  </thead>
  <tbody>
  	<c:if test="${empty pagingVO.list }">
  	<tr>
  	  	<td colspan="5" style="text-align: center;"><h3 style="margin: 30px;">등록된 글이 없습니다.</h3></td>
  	</tr>
  	</c:if>
  	<c:if test="${not empty pagingVO.list }">
  <c:forEach items="${pagingVO.list }" var="vo">
    <tr>
      <th class="no" scope="row">${vo.idx }</th>
      <td><a href="javascript:edit_page('${vo.idx }')">${vo.title }</a></td>
      <td><fmt:formatDate value="${vo.noticeDate }" pattern="yy-MM-dd HH:mm"/></td>
      <td>${vo.writer }</td>
    </tr>
  </c:forEach>
  </c:if>
  </tbody>
</table>
<input type="hidden" id="searchField" name="search_field" value="${search_field}" />
<input type="hidden" id="searchContent" name="search_content" value="${search_content}" />
	<div>
  		${pagingVO.pageList }
  	</div>
    <hr />
    <c:if test="${role eq '[ROLE_ADMIN]' }">
    <div style="float: right; display: inline;">
    <button type="button" class="btn btn-primary" onclick="location='writeform'">글쓰기</button>
    </div>
    </c:if>
    <div>
    	<form action="searchNotice" method="post">
    	<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
    	<div class="form-row">
			<div class="form-group col-md-2">
				<select id="search_field" name="search_field"	class="form-control">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="all">제목 + 내용</option>
				</select>
			</div>
			<div>
	    	<input type="text" name="search_content"/><button class="btn btn-dark btn-sm" style="margin: 5px auto 10px 10px;">검색</button>
			</div>
		</div>
    	</form>
    </div>
</div>



	
</body>
</html>