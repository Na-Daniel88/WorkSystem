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
<script type="text/javascript" src="/resources/js/comm.js" ></script>
<!-- fullcalendar 사용시 추가!!! -->
<link href='https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.13.1/css/all.css' rel='stylesheet'>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.1.0/main.css">
<script	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.1.0/main.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.1.0/locales/ko.js"></script>
<script type="text/javascript" src="resources/datetime/jquery.datetimepicker.full.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/datetime/jquery.datetimepicker.min.css" />
<!-- 날짜 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/locale/ko.min.js" ></script>
<!-- 툴팁 -->
<script src="https://unpkg.com/@popperjs/core@2"></script>
<script src="https://unpkg.com/tippy.js@6"></script>
<link href="resources/blog.css" rel="stylesheet">
<script type="text/javascript">
	var dataset = [
		<c:forEach var="vo" items="${list}">
		{
			id : "${vo.id }",
			title : "${vo.title }",
			start : "${vo.startDate }",
			end : "${vo.endDate }",
			type : "${vo.type }",
			backgroundColor : "${vo.color }",
			description : "${vo.description }",
			//allDay : "${vo.allDay }"
		},
		</c:forEach>
	];
	var calendar;
	$(function(){
		var calendarEl = document.getElementById('calendar');
		calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth', // 기본 월별 표시
			events : dataset,
			timeZone : 'local',
			locale : 'ko',
			themeSystem : 'bootstrap',
			headerToolbar : {
				left : 'prevYear,prev,next,nextYear today',
				center : 'title',
				right : 'timeGridDay,timeGridWeek,dayGridMonth,list'
			},
			dayMaxEvents : true,
			editable : true,
			selectable : true,
			selectMirror : true,
			select : function(arg) {
				$("#insertBtns").css('display','block');
				$("#updateBtns").css('display','none');

				// 아이디 자동부여
				$("#id").val(uuidv4());
				// 일정 입력받아
				$("#allDay").prop("checked", arg.allDay); 
				// 체크박스 체크여부에 따라 datetimepicker 형식 변경
				if(arg.allDay){
					$('#startDate').datetimepicker({
						format : 'Y-m-d',
						timepicker : false
					});
					$('#endDate').datetimepicker({
						format : 'Y-m-d',
						timepicker : false
					});
				}else{
					$('#startDate').datetimepicker({
						format : 'Y-m-d H:i',
						timepicker : true
					});
					$('#endDate').datetimepicker({
						format : 'Y-m-d H:i',
						timepicker : true
					});
				}
				$("#startDate").val(arg.startStr);
				$("#endDate").val(arg.endStr);
				$("#title").val('');
				$("#description").val('');
				$("#modalDialog").modal(); // 대화상자 띄우기
				calendar.unselect(); // 선택해제
			},
			eventClick : function(arg){
				$("#insertBtns").css('display', 'none');
				$("#updateBtns").css('display', 'block');
				var eventSchedule = arg.event.toJSON();
				eventSchedule['allDay'] = arg.event['allDay'];
				$("#id").val(eventSchedule.id);
				$("#allDay").prop("checked", eventSchedule.allDay);
				if(eventSchedule.allDay)
				{
					$('#startDate').datetimepicker({
						format : 'Y-m-d',
						timepicker : false
					});
					$('#endDate').datetimepicker({
						format : 'Y-m-d',
						timepicker : false
					});
				}
				else
				{
					$('#startDate').datetimepicker({
						format : 'Y-m-d H:i',
						timepicker : true
					});
					$('#endDate').datetimepicker({
						format : 'Y-m-d H:i',
						timepicker : true
					});
				}
				var start = moment(eventSchedule.start).format(
						eventSchedule.allDay ? 'YYYY-MM-DD' : 'YYYY-MM-DD HH:mm')
				$("#startDate").val(start);
				
				if(!eventSchedule['allDay']){
					var end = moment(eventSchedule.end).
						format(eventSchedule.allDay ? 'YYYY-MM-DD' : 'YYYY-MM-DD HH:mm')
				}
				$("#endDate").val(end);
				$("#title").val(eventSchedule.title);
				if(eventSchedule.extendedProps){
					// 카테고리
					$("#type").val(eventSchedule.extendedProps.type).prop("selected", true);
					// 색상
					$("#color").val(eventSchedule.backgroundColor).prop("selected", true);
					$("#description").val(eventSchedule.extendedProps.description);
				}else{
					// 카테고리
					$("#type").prop("selected", true);
					// 색상
					$("#color").prop("selected", true);
					$("#description").val("");
					
				}
				
				$("#modalDialog").modal();
				calendar.unselect();
			},
			//일정 리사이즈
			  eventResize: function (arg) {
				  var eventSchedule = arg.event.toJSON();
					eventSchedule['id'] = arg.event['id'];
					eventSchedule['allDay'] = arg.event['allDay'];
					eventSchedule['startDate'] = moment(eventSchedule.start).format(eventSchedule.allDay ? 'YYYY-MM-DD' : 'YYYY-MM-DD HH:mm');
					eventSchedule['endDate'] = moment(eventSchedule.end).format(eventSchedule.allDay ? 'YYYY-MM-DD' : 'YYYY-MM-DD HH:mm');
					eventSchedule['description'] = eventSchedule.extendedProps.description;
					eventSchedule['type'] = eventSchedule.extendedProps.type;
					eventSchedule['color'] = eventSchedule.backgroundColor;
									  					
					$.ajax('update', {
						data : eventSchedule
					})

			  }
		});
		calendar.render();
		$.ajax('eventList.json').done(function(data) {
			for (i in data) {
				calendar.addEvent(data[i]);
			}
		});
	});
		
		
		
	$(function(){
		$('#saveBtn').click(function(){
			var id = $("#id").val();
			var allDay = $("#allDay").val();
			var title = $("#title").val();
			var edit_start = $("#startDate").val();
			var edit_end = $("#endDate").val();
			var edit_type = $("#type").val();
			var edit_color = $("#color").val();
			var edit_desc = $("#description").val();
			var event_schedule = {
					id : id,
					title : title,
					start : edit_start,
					end : edit_end,
					type : edit_type,
					backgroundColor : edit_color,
					description : edit_desc,
					allDay : $("#allDay").is(':checked')
			}
			if(!event_schedule['allDay']){
				event_schedule['end'] = moment(event_schedule.end).
				                     format(event_schedule.allDay ? 'YYYY-MM-DD' : 'YYYY-MM-DD HH:mm')
			}else{
				event_schedule['end'] = moment(event_schedule.end).
									 add(1,'days').
				                     format(event_schedule.allDay ? 'YYYY-MM-DD' : 'YYYY-MM-DD HH:mm')
			}
			
			calendar.addEvent(event_schedule);
			
			$.ajax("insert", {
				data : {
					id : $('#id').val(),
					title : $('#title').val(),
					startDate : $('#startDate').val(),
					endDate : $('#endDate').val(),
					type : $('#type').val(),
					color : $('#color').val(),
					description : $('#description').val(),
					allDay : $('#allDay').is(':checked')
				}
			});
			$('#modalDialog').modal('hide');
		});
		
		$('#updateBtn').click(function(){
			var id = $("#id").val();
			var allDay = $("#allDay").val();
			var title = $("#title").val();
			var edit_start = $("#startDate").val();
			var edit_end = $("#endDate").val();
			var edit_type = $("#type").val();
			var edit_color = $("#color").val();
			var edit_desc = $("#description").val();
			var event_schedule = {
					id : id,
					title : title,
					start : edit_start,
					end : edit_end,
					type : edit_type,
					backgroundColor : edit_color,
					description : edit_desc,
					allDay : $("#allDay").is(':checked')
			}
			var delEv = calendar.getEventById($("#id").val());
			delEv.remove();
			if(!event_schedule['allDay']){
				event_schedule['end'] = moment(event_schedule.end).
				                     format(event_schedule.allDay ? 'YYYY-MM-DD' : 'YYYY-MM-DD HH:mm')
			}else{
				event_schedule['end'] = moment(event_schedule.end).
									 add(1,'days').
				                     format(event_schedule.allDay ? 'YYYY-MM-DD' : 'YYYY-MM-DD HH:mm')
			}
			calendar.addEvent(event_schedule);
			
			$.ajax("update", {
				data : {
					id : $('#id').val(),
					title : $('#title').val(),
					startDate : $('#startDate').val(),
					endDate : $('#endDate').val(),
					type : $('#type').val(),
					color : $('#color').val(),
					description : $('#description').val(),
					allDay : $('#allDay').is(':checked')
				}
			})
			$('#modalDialog').modal('hide');
		});
		
		$('#deleteBtn').click(function(){
			if(confirm('일정을 삭제하시겠습니까?')){
				var delEv = calendar.getEventById($("#id").val());
				delEv.remove();
				$.ajax("delete", {
					data : {
						id : $('#id').val()
					}
				});
				$('#modalDialog').modal('hide');
			}
		});
		
		$("#allDay").change(function(){
			if($(this).is(':checked'))
			{
				$('#startDate').datetimepicker({
					format : 'Y-m-d',
					timepicker : false
				});
				$('#endDate').datetimepicker({
					format : 'Y-m-d',
					timepicker : false
				});
			}
			else
			{
				$('#startDate').datetimepicker({
					format : 'Y-m-d H:i',
					timepicker : true
				});
				$('#endDate').datetimepicker({
					format : 'Y-m-d H:i',
					timepicker : true
				});
			}
		});
		
		$('#startDate').datetimepicker({
			format : 'Y-m-d H:i',
			onShow : function(ct)
			{
				this.setOptions({
					maxDate : $('#endDate').val() ? $('#endDate').val() : false
				})
			},
			timepicker : true
		});
		$('#endDate').datetimepicker({
			format : 'Y-m-d H:i',
			onShow : function(ct)
			{
				this.setOptions({
					minDate : jQuery('#startDate').val() ? $('#startDate').val() : false
				})
			},
			timepicker : true
		});

	});
	
	// JS UUID생성 함수!!!
	function uuidv4() {
	  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
	    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
	    return v.toString(16);
	  });
	}	
	
</script>
<style type="text/css">
	#calendar { width: 900px; margin: auto; padding: 30px; }
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
<!-- 입력 Modal -->
	<div class="modal fade" id="modalDialog" tabindex="-1" role="dialog"
		aria-labelledby="Label" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="font-weight-bold" id="modalDialogLabel" >일정 입력</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<div class="modal-body">
					<div class="form-group row">
						<label class="col-sm-3 col-form-label" for="allDay">구분</label>
						<div class="form-check col-sm-9">
							<input class="form-check-input" type="checkbox" id="allDay">
							<label class="form-check-label" for="allDay">하루종일</label>
						</div>
					</div>
					<div class="form-group row">
						<label for="title" class="col-sm-2 col-form-label">일정명</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="title" id="title" required="required">
							<input type="hidden" name="id" id="id" >
						</div>
					</div>

					<div class="form-group row">
						<label for="startDate" class="col-sm-2 col-form-label">시작</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="startDate" id="startDate" required="required">
						</div>
					</div>
					<div class="form-group row">
						<label for="endDate" class="col-sm-2 col-form-label">종료</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="endDate" id="endDate" required="required">
						</div>
					</div>
					<div class="form-group row">
						<label for="type" class="col-sm-2 col-form-label">구분</label>
						<div class="col-sm-10">
							<select name="type" id="type" class="form-control">
								<option value="영업 업무">영업 업무</option>
								<option value="출장">출장</option>
								<option value="업무회의">업무회의</option>
								<option value="휴가">휴가</option>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<label for="color" class="col-sm-2 col-form-label">색상</label>
						<div class="col-sm-10">
							<select id="color" class="form-control">
								<option value="#ffa94d" style="color: #ffa94d;">영업 업무</option>
								<option value="#D25565" style="color: #D25565;">출장</option>
								<option value="#74c0fc" style="color: #74c0fc;">업무회의</option>
								<option value="#63e6be" style="color: #63e6be;">휴가</option>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<label for="description" class="col-sm-2 col-form-label">설명</label>
						<div class="col-sm-10">
							<textarea rows="6" cols="40" id="description" class="form-control" required="required"></textarea>
						</div>
					</div>


				</div>
				<div class="modal-footer">
					<%-- 날짜를 클릭하면 보여줌 --%>
					<div id="insertBtns">
						<button type="button" class="btn btn-secondary"	data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" id="saveBtn">저장</button>
					</div>
					<%-- 일정을 클릭하면 보여줌 --%>
					<div id="updateBtns">
						<button type="button" class="btn btn-secondary"	data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-danger" id="deleteBtn">삭제</button>
						<button type="button" class="btn btn-primary" id="updateBtn">수정</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="calendar"></div>
</body>
</html>