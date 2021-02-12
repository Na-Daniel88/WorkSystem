<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <%
		request.setCharacterEncoding("UTF-8");
    
    // 기본 값 설정
	 	int currentPage = 1;
	 	int pageSize = 5;
	 	int blockSize = 5;
	 	int idx = -1;
	 	// 넘어온 파라메터를 받아 숫자로 변경
	 	try
	 	{
	 		currentPage = Integer.parseInt(request.getParameter("p"));
	 	}
	 	catch (Exception e)
	 	{
	 		;
	 	}
	 	try
	 	{
	 		pageSize = Integer.parseInt(request.getParameter("s"));
	 	}
	 	catch (Exception e)
	 	{
	 		;
	 	}
	 	try
	 	{
	 		blockSize = Integer.parseInt(request.getParameter("b"));
	 	}
	 	catch (Exception e)
	 	{
	 		;
	 	}
	 	
	 	
	 	// EL 처리를 위해 4개 변수도 request 영역에 저장
	 	request.setAttribute("currentPage", currentPage);
	 	request.setAttribute("pageSize", pageSize);
	 	request.setAttribute("blockSize", blockSize);
	 	
	 	// EL 줄바꿈 처리
	 	request.setAttribute("newLine", "\n");
	 	request.setAttribute("br", "<br>");
    %>