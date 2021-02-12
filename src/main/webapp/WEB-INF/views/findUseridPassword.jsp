<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Work-System Sign Page</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" ></script>
<script src="https://code.jquery.com/jquery-3.2.1.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
   <!-- Custom styles for this template 
   -->
  <link rel="stylesheet" type="text/css" href="resources/css/signin.css" >

<script type="text/javascript">

</script>
<style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      
     
    </style>
</head>
<body class="text-center">
	<div class="container">
	<hr />
		<div class="row">
			<div class="col-md-6" style="margin: auto;">
				<form action="findUseridPassword" method="post">
				<%-- 이부분을 반드시 숨겨서 가져가야 한다. --%>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<h3>USER ID 찾기</h3>
					<div>
						<label>이름</label> <input type="text" class="form-control"	name="name" required="required">
					</div>
					<div>
						<label>전화번호(ex.010-1234-1234)</label> <input type="text" class="form-control"	name="phone" required="required">
					</div>
					<br />
					<button type="submit" class="btn btn-primary">찾기</button>
				</form>
			</div>
		</div>
		<br />
	<hr />
		<br />
		<div class="row">
			<div class="col-md-6" style="margin: auto;">
				<form action="findPasswordOK" method="post" onsubmit="return formCheck();">
				<%-- 이부분을 반드시 숨겨서 가져가야 한다. --%>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<h3>임시 비밀번호 발급</h3>
					<div>
						<label>User ID</label> <input type="text" class="form-control" name="userid" required="required">
					</div>
					<div>
						<label>이름</label> <input type="text" class="form-control"	name="name" required="required">
					</div>
					<div>
						<label>전화번호(ex.010-1234-1234)</label> <input type="text" class="form-control"	name="phone" required="required">
					</div>
					<!-- 
					<div>
						<label>변경할 비밀번호</label> <input type="password" class="form-control" id="password" name="password">
					</div>
					<div>
						<label>변경할 비밀번호 확인</label> <input type="password" class="form-control" id="password2" name="password2">
					</div>
					 -->
					<br />
					<button type="submit" class="btn btn-primary">발급</button>
				</form>
			</div>
		</div>
	<hr />
	<button type="button" class="btn btn-info" onclick="location='login'">돌아가기</button>
	</div>

</body>
</html>
