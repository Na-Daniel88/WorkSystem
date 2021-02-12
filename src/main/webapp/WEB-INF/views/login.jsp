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
    <form class="form-signin" action="login" method="post">
    <%-- 이부분을 반드시 숨겨서 가져가야 한다. --%>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  <img class="mb-4" src="" alt="" width="72" height="72">
  <h1 class="h3 mb-3 font-weight-normal">Work-System</h1>
  <label for="userid" class="sr-only">USER ID</label>
  <input type="text" id="userid" name="userid" class="form-control" placeholder="USER ID" required autofocus>
  <label for="password" class="sr-only">Password</label>
  <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
  
  <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
  <br />
		<div class="text-center w-full p-t-23">
			<a href="findUseridPassword" class="txt1">Forgot USER ID? or Password?</a> <br />
		</div>
		<p class="mt-5 mb-3 text-muted">&copy; 2020</p>
</form>
</body>
</html>
