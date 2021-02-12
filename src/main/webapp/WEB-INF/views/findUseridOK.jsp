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
	<br />
	<hr />
		<div class="row">
			<div class="col-md-8" style="margin: auto;">
			<br /><br />
			<c:if test="${not empty memberVO }">
				<h2>${name } 님의 사번은 <span style="color: blue;">${memberVO }</span> 입니다.</h2>
			</c:if>
			<c:if test="${empty memberVO }">
				<h2>정보가 존재하지 않습니다.</h2>
			</c:if>
			<br /><br />
			<button type="button" class="btn btn-info" onclick="location='findUseridPassword'">돌아가기</button>
			</div>
		</div>
	<br />
	<hr />
	</div>

</body>
</html>
