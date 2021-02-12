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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" ></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  	
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="resources/blog.css" rel="stylesheet">
<script type="text/javascript">
	$(function(){
		$("#birth").datepicker({
			dateFormat: "yy-mm-dd",
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			showMonthAfterYear: true,
			changeYear: true,
			changeMonth: true,
			yearRange: "c-60:c"
	    });
		$("#regDate").datepicker({
			dateFormat: "yy-mm-dd",
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			showMonthAfterYear: true,
			changeYear: true,
			changeMonth: true,
			yearRange: "c-60:c"
	    });
	});
	
	function formCheck()
	{
		if($("#dept").val()=="")
			{
				alert('부서를 선택해야 합니다.');
				$("#dept").focus();
				return false;
			}
		
		if($("#lvl").val()=="")
			{
				alert('직급을 선택해야 합니다.');
				$("#lvl").focus();
				return false;
			}
		
		if($("#enabled").val()=="")
			{
				alert('재직유무를 선택해야 합니다.');
				$("#enabled").focus();
				return false;
			}
		
		if($("#role").val()=="")
			{
				alert('권한을 선택해야 합니다.');
				$("#role").focus();
				return false;
			}
	}
	
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
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
	<h2>신규 직원 등록</h2>
	<hr />
</div>
	<form class="registerForm" action="insertMember" onsubmit="return formCheck();">
		<div class="form-row">
			<div class="form-group col-md-6">
				<label for="userid">사번</label>
				<input type="text"	class="form-control" id="userid" name="userid" required="required">
			</div>
			<div class="form-group col-md-6">
				<label for="password">패스워드</label>
				<input type="password" class="form-control" id="password" name="password" required="required">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-6">
				<label for="name">이름</label> 
				<input type="text" class="form-control" id="name" name="name" required="required">
			</div>
			<div class="form-group col-md-6">
				<label for="phone">연락처</label>
				<input type="text" class="form-control" id="phone" name="phone" placeholder="ex. 010-0000-0000" required="required">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-4">
				<label for="birth">생일</label> 
				<input type="text"	class="form-control" id="birth" name="birth" required="required">
			</div>
			<div class="form-group col-md-3">
				<label for="dept">부서</label> 
				<select id="dept" name="dept"	class="form-control">
					<option selected value="">- 부서 선택 -</option>
					<option value="경리부">경리부</option>
					<option value="영업부">영업부</option>
					<option value="기술부">기술부</option>
					<option value="개발부">개발부</option>
					<option value="임원진">임원진</option>
					<option value="대표">대표</option>
				</select>
			</div>
			<div class="form-group col-md-3">
				<label for="lvl">직급</label> 
				<select id="lvl" name="lvl"	class="form-control">
					<option selected value="">- 직급 선택 -</option>
					<option value="사원">사원</option>
					<option value="대리">대리</option>
					<option value="과장">과장</option>
					<option value="부장">부장</option>
					<option value="이사">이사</option>
					<option value="상무">상무</option>
					<option value="대표">대표</option>
				</select>
			</div>
		</div>
		<div class="form-check form-check-inline">
			<input class="form-check-input" type="radio" name="gender" id="gender1" value="M" checked="checked">
			<label class="form-check-label" for="gender1">남자</label>
		</div>
		<div class="form-check form-check-inline">
			<input class="form-check-input" type="radio" name="gender" id="gender2" value="F">
			<label class="form-check-label" for="gender2">여자</label>
		</div>
		<hr />
		<div class="form-row">
		<div class="form-group col-md-3">
		<input type="text" class="form-control" id="sample6_postcode" name="postCode" placeholder="우편번호" required="required">
		</div>
		<div class="form-group col-md-3">
		<input type="button" class="btn btn-success" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
		</div>
		</div>
		<div class="form-row">
		<div class="form-group col-md-6">
			<label for="addr1">주소</label> 
			<input type="text" class="form-control" id="sample6_address" name="addr1" placeholder="주소" required="required">
		</div>
		</div>
		<div class="form-row">
		<div class="form-group col-md-6">
			<label for="addr2">상세주소</label> 
			<input type="text"  class="form-control" id="sample6_detailAddress" name="addr2" placeholder="상세주소">
		</div>
		<div class="form-group col-md-5">
			<label for="exAddr">참고항목</label> 
			<input type="text"  class="form-control" id="sample6_extraAddress" name="exAddr"  placeholder="참고항목">
		</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-4">
				<label for="regDate">입사일</label> 
				<input type="text" class="form-control" id="regDate" name="regDate" required="required">
			</div>
			<div class="form-group col-md-3">
				<label for="enabled">재직유무</label> 
				<select id="enabled" name="enabled" class="form-control">
					<option selected value="">- 재직 유무 -</option>
					<option value="1">재직</option>
					<option value="0">퇴직</option>
				</select>
			</div>
			<div class="form-group col-md-3">
				<label for="role">권한</label> 
				<select id="role" name="role" class="form-control">
					<option selected value="">- 권한 설정 -</option>
					<option value="ROLE_USER">일반</option>
					<option value="ROLE_ADMIN">관리자</option>
				</select>
			</div>
		</div>
		<div style="text-align: center; margin: 30px;">
			<button type="submit" class="btn btn-primary">등록</button>
		</div>
	</form>




</body>
</html>