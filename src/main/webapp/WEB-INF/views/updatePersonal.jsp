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
		
		
		 $(".passwordchk").on('click',function(){
		        var passwordbtn = $('.passwordchk').is(":checked");
		        if(passwordbtn==true){
		            $('.password').prop('name','password');
		        }else{
		        	$('.password').removeAttr('name');
		        }
		 });
		
		
	});
	
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
	<h2>직원 정보 변경</h2>
	<hr />
</div>
	<form class="registerForm" action="updateMember">
	<%-- 이부분을 반드시 숨겨서 가져가야 한다. --%>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<c:forEach items="${list }" var="vo">
		<div class="form-row">
			<div class="form-group col-md-6">
				<label for="userid">사번</label>
				<input type="text"	class="form-control" id="userid" name="userid" value="${vo.userid }" readonly="readonly">
			</div>
			<div class="form-group col-md-6">
				<input type="checkbox" class="form-check-input passwordchk" id="passwordbtn" >
				<label class="form-check-label" for="passwordbtn">패스워드 변경</label>
				<input type="password" class="form-control password" id="password" >
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-6">
				<label for="name">이름</label> 
				<input type="text" class="form-control" id="name" name="name" value="${vo.name }" readonly="readonly">
			</div>
			<div class="form-group col-md-6">
				<label for="phone">연락처</label>
				<input type="text" class="form-control" id="phone" name="phone" value="${vo.phone }">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-4">
				<label for="birth">생일</label> 
				<input type="text"	class="form-control" id="birth" name="birth" value="${vo.birth }" readonly="readonly">
			</div>
			<c:if test="${role eq '[ROLE_USER]' }">
			<div class="form-group col-md-3">
				<label for="dept">부서</label>
				<input class="form-control" type="text" name=dept value="${vo.dept }" readonly="readonly"/>
			</div>
			<div class="form-group col-md-3">
				<label for="lvl">직급</label>
				<input class="form-control" type="text" name="lvl" value="${vo.lvl }" readonly="readonly"/>
			</div>
			</c:if>
			<c:if test="${role eq '[ROLE_ADMIN]' }">
			<div class="form-group col-md-3">
				<label for="dept">부서</label> 
				<select id="dept" name="dept"	class="form-control">
					<option selected>- 부서 선택 -</option>
					<option value="경리부" ${vo.dept=='경리부' ? 'selected="selected"' : "" }>경리부</option>
					<option value="영업부" ${vo.dept=='영업부' ? 'selected="selected"' : "" }>영업부</option>
					<option value="기술부" ${vo.dept=='기술부' ? 'selected="selected"' : "" }>기술부</option>
					<option value="개발부" ${vo.dept=='개발부' ? 'selected="selected"' : "" }>개발부</option>
					<option value="임원진" ${vo.dept=='임원진' ? 'selected="selected"' : "" }>임원진</option>
					<option value="대표" ${vo.dept=='대표' ? 'selected="selected"' : "" }>대표</option>
				</select>
			</div>
			<div class="form-group col-md-3">
				<label for="lvl">직급</label> 
				<select id="lvl" name="lvl"	class="form-control">
					<option selected>- 직급 선택 -</option>
					<option value="사원" ${vo.lvl=='사원' ? 'selected="selected"' : "" }>사원</option>
					<option value="대리" ${vo.lvl=='대리' ? 'selected="selected"' : "" }>대리</option>
					<option value="과장" ${vo.lvl=='과장' ? 'selected="selected"' : "" }>과장</option>
					<option value="부장" ${vo.lvl=='부장' ? 'selected="selected"' : "" }>부장</option>
					<option value="이사" ${vo.lvl=='이사' ? 'selected="selected"' : "" }>이사</option>
					<option value="상무" ${vo.lvl=='상무' ? 'selected="selected"' : "" }>상무</option>
					<option value="대표" ${vo.lvl=='대표' ? 'selected="selected"' : "" }>대표</option>
				</select>
			</div>
			</c:if>
		</div>
		<c:if test="${vo.gender eq 'M' }">
		<div class="form-check form-check-inline">
			<input class="form-check-input" type="radio" name="gender" id="gender1" value="M" ${vo.gender=='M' ? 'checked="checked"':"" }>
			<label class="form-check-label" for="gender1">남자</label>
		</div>
		</c:if>
		<c:if test="${vo.gender eq 'F' }">
		<div class="form-check form-check-inline">
			<input class="form-check-input" type="radio" name="gender" id="gender2" value="F" ${vo.gender=='F' ? 'checked="checked"':"" }>
			<label class="form-check-label" for="gender2">여자</label>
		</div>
		</c:if>
		<hr />
		<div class="form-row">
		<div class="form-group col-md-3">
		<input type="text" class="form-control" id="sample6_postcode" name="postCode" placeholder="우편번호" value="${vo.postCode }">
		</div>
		<div class="form-group col-md-3">
		<input type="button" class="btn btn-success" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
		</div>
		</div>
		<div class="form-row">
		<div class="form-group col-md-6">
			<label for="addr1">주소</label> 
			<input type="text" class="form-control" id="sample6_address" name="addr1" placeholder="주소" value="${vo.addr1 }">
		</div>
		</div>
		<div class="form-row">
		<div class="form-group col-md-6">
			<label for="addr2">상세주소</label> 
			<input type="text"  class="form-control" id="sample6_detailAddress" name="addr2" placeholder="상세주소" value="${vo.addr2 }">
		</div>
		<div class="form-group col-md-5">
			<label for="exAddr">참고항목</label> 
			<input type="text"  class="form-control" id="sample6_extraAddress" name="exAddr"  placeholder="참고항목" value="${vo.exAddr }">
		</div>
		</div>
	<div class="form-row">
			<div class="form-group col-md-4">
				<label for="regDate">입사일</label> 
				<input type="text" class="form-control" id="regDate" name="regDate" value="${vo.regDate }" readonly="readonly">
			</div>
		<c:if test="${role eq '[ROLE_USER]' }">
		<input type="hidden" name="enabled" value="${vo.enabled }" />
		</c:if>
			<c:if test="${role eq '[ROLE_ADMIN]' }">
			<div class="form-group col-md-3">
				<label for="enabled">재직유무</label> 
				<select id="enabled" name="enabled" class="form-control">
					<option selected>- 재직 유무 -</option>
					<option value="1" ${vo.enabled=='1' ? 'selected="selected"' : "" }>재직</option>
					<option value="0" ${vo.enabled=='0' ? 'selected="selected"' : "" }>퇴직</option>
				</select>
			</div>
			</c:if>
		</c:forEach>
		<c:if test="${role eq '[ROLE_USER]' }">
		<c:forEach items="${roleVO }" var="roleVO">
		<input type="hidden" name="role" value="${roleVO.role }" />
		</c:forEach>
		</c:if>
		<c:if test="${role eq '[ROLE_ADMIN]' }">
			<c:forEach items="${roleVO }" var="roleVO">
			<div class="form-group col-md-3">
				<label for="role">권한</label> 
				<select id="role" name="role" class="form-control">
					<option selected>- 권한 설정 -</option>
					<option value="ROLE_USER" ${roleVO.role=='ROLE_USER' ? 'selected="selected"' : "" }>일반</option>
					<option value="ROLE_ADMIN" ${roleVO.role=='ROLE_ADMIN' ? 'selected="selected"' : "" }>관리자</option>
				</select>
			</div>
			</c:forEach>
		</c:if>
	</div>
		<div style="text-align: center; margin: 30px;">
			<button type="submit" class="btn btn-primary">수정</button>
		</div>
	</form>




</body>
</html>