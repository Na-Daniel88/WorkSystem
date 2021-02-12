package kr.co.work.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import kr.co.work.dao.MemberDAO;
import kr.co.work.vo.MemberVO;
import lombok.Data;
// 로그인 성공시 처리할 핸들러 클래스
/*
1. 로그인 성공시, 어떤 URL로 Redirect 할 지 결정. 회원정보를 세션에 저장
2. 로그인 실패 에러 세션 지우기
3. 로그인 성공시, 실패 카운터 초기화
 */
@Data
public class LoginSuccessHandler implements AuthenticationSuccessHandler{

	@Autowired
	private MemberDAO memberDAO;
	private String  successUrl;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// 여기서는 회원 정보를 읽어서 세션에 저장하기
		// 아이디 받기
		String userid = request.getParameter("userid");
		// 아이디로 회원정보 얻기
		List<MemberVO> list = memberDAO.selectByUserId(userid);
		if(list!=null && list.size()>0) {
			
			MemberVO vo = list.get(0);
		// 회원정보를 세션에 저장하기
		request.getSession().setAttribute("memberVO", vo);
		// 어딘가로 이동
		// request.getRequestDispatcher(successUrl).forward(request, response);
		}
		response.sendRedirect(successUrl);
	}

}
