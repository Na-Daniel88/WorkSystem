// 자바스크립트를 이용하여 POST전송하기
function post_to_url(path, params, _csrf) {
    var form = document.createElement("form"); // form만들기
    form.setAttribute("method", 'POST'); // 메서드를 POST로 지정
    form.setAttribute("action", path); // 액션 지정
    // 히든으로 값을 주입시킨다.

	var csrfValue = $("#_csrf").val();
	
    csrf = document.createElement("input");
    csrf.setAttribute("type", 'hidden');
    csrf.setAttribute("name", '_csrf');
    csrf.setAttribute("value", csrfValue);
    form.appendChild(csrf);


		val_name = $("#s_name").val();
		
		sc_name = document.createElement("input");
		sc_name.setAttribute("type", 'hidden');
		sc_name.setAttribute("name", 'name');
		sc_name.setAttribute("value", val_name);

		form.appendChild(sc_name);

		
    for(var key in params) {
        var hiddenField = document.createElement("input"); // input태그 작성
        hiddenField.setAttribute("type", "hidden"); // hidden속성 지정
        hiddenField.setAttribute("name", key); // 키를 이름으로 지정
        hiddenField.setAttribute("value", params[key]); // 값을 값으로 지정
        form.appendChild(hiddenField); // 폼에 input태그 추가
    }
    document.body.appendChild(form); // 폼을 body에 추가
    
    form.submit(); // 서버로 전송
}



//replaceAll prototype 선언
String.prototype.replaceAll = function(org, dest) {
    return this.split(org).join(dest);
}


