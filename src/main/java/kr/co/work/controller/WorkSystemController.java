package kr.co.work.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.support.RequestContextUtils;

import kr.co.work.service.BoardService;
import kr.co.work.service.MemberService;
import kr.co.work.service.NoticeBoardService;
import kr.co.work.service.ScheduleService;
import kr.co.work.vo.BoardVO;
import kr.co.work.vo.CommVO;
import kr.co.work.vo.MemberRoleVO;
import kr.co.work.vo.MemberVO;
import kr.co.work.vo.NoticeBoardVO;
import kr.co.work.vo.PagingVO;
import kr.co.work.vo.ScheduleListVO;
import kr.co.work.vo.ScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class WorkSystemController {

	@Autowired
	private ScheduleService scheduleService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private NoticeBoardService noticeBoardService;

	@Autowired
	private BoardService boardService;

	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;

	@RequestMapping(value = "/")
	public String index(Model model) {
		log.debug("MemberController.login 호출");

		return "login";
	}

	// JSP파일이름 자동 맵핑 가능하다.
	@RequestMapping(value = "/{name}")
	public String path(@PathVariable("name") String name, Model model, Principal principal) {
		log.info("WorkSystemController." + name + " 호출");

		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}

		return name;
	}

	//-------------------------------------------------------------------------------------------------------------------------

	// 공지사항 관련
	//-------------------------------------------------------------------------------------------------------------------------
	
	@RequestMapping(value = "/notice")
	public String notice(@ModelAttribute CommVO commVO, Model model, Principal principal, HttpServletRequest request) {
		log.info("WorkSystemController.notice 호출");

		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}

		String search_field = request.getParameter("search_field");
		String search_content = request.getParameter("search_content");

		
		if(search_field == "") {
			search_field = null;
			search_content = null;
			int noticeCount = noticeBoardService.searchCount(search_field, search_content);
			model.addAttribute("noticeCount", noticeCount);
		} else {
			int noticeCount = noticeBoardService.searchCount(search_field, search_content);
			model.addAttribute("noticeCount", noticeCount);
		}
				
		

		PagingVO<NoticeBoardVO> pagingVO = noticeBoardService.noticeList(commVO.getCurrentPage(), commVO.getPageSize(),
				commVO.getBlockSize(), search_field, search_content);

		model.addAttribute("search_field", search_field);
		model.addAttribute("search_content", search_content);
		model.addAttribute("pagingVO", pagingVO);
		

		return "notice";
	}
	
	@RequestMapping(value = "/noticeInsertOK")
	public String noticeInsertOK(@ModelAttribute NoticeBoardVO vo, Model model, Principal principal) {
		log.info("WorkSystemController.noticeInsertOK 호출" + vo);
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}

		if (vo != null) {
			noticeBoardService.noticeInsert(vo);
		}

		log.info("WorkSystemController.noticeInsertOK 종료" + vo);
		return "noticeInsertOK";
	}
	
	@RequestMapping(value = "/noticeViewer")
	public String noticeViewer(@RequestParam("idx") int idx, Model model, Principal principal) {
		log.info("WorkSystemController.noticeViewer 호출");
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}

		NoticeBoardVO noticeVO = noticeBoardService.selectByIdx(idx);
		
		model.addAttribute("vo", noticeVO);

		log.info("WorkSystemController.noticeViewer 종료" + noticeVO);
		return "noticeViewer";
	}

	@RequestMapping(value = "/editform")
	public String editform(@RequestParam("idx") int idx, Model model, Principal principal) {
		log.info("WorkSystemController.editform 호출");
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
		
		NoticeBoardVO noticeVO = noticeBoardService.selectByIdx(idx);
		
		model.addAttribute("vo", noticeVO);
		
		log.info("WorkSystemController.editform 종료" + noticeVO);
		return "editform";
	}

	@RequestMapping(value = "/editformOK")
	public String editformOK(@ModelAttribute NoticeBoardVO vo, Model model, Principal principal) {
		log.info("WorkSystemController.editformOK 호출" + vo);
	
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
	
		noticeBoardService.noticeUpdate(vo);
		
		log.info("WorkSystemController.editformOK 저장" + vo);
		return "editformOK";
	}

	@RequestMapping(value = "/noticeDeleteOK")
	public String noticeDeleteOK(@RequestParam("idx") int idx, Model model, Principal principal) {
		log.info("WorkSystemController.noticeDelete 호출");
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
		
		noticeBoardService.noticeDelete(idx);
		
		log.info("WorkSystemController.noticeDelete 종료");
		return "noticeDeleteOK";
	}

	
	
	//-------------------------------------------------------------------------------------------------------------------------

	// 사내게시판 관련
	//-------------------------------------------------------------------------------------------------------------------------
	
	@RequestMapping(value = "/board")
	public String board(@ModelAttribute CommVO commVO, Model model, Principal principal, HttpServletRequest request) {
		log.info("WorkSystemController.board 호출");
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
		
		String search_field = request.getParameter("search_field");
		String search_content = request.getParameter("search_content");

		if(search_field == "") {
			search_field = null;
			search_content = null;
			int boardCount = boardService.searchCount(search_field, search_content);
			model.addAttribute("boardCount", boardCount);
		} else {
			int boardCount = boardService.searchCount(search_field, search_content);
			model.addAttribute("boardCount", boardCount);
		}
		
		
		PagingVO<BoardVO> pagingVO = boardService.boardList(commVO.getCurrentPage(), commVO.getPageSize(),
				commVO.getBlockSize(), search_field, search_content);
		
		model.addAttribute("search_field", search_field);
		model.addAttribute("search_content", search_content);
		model.addAttribute("pagingVO", pagingVO);
		
		return "board";
	}
	
	@RequestMapping(value = "/boardwriteform")
	public String boardwriteform(@ModelAttribute BoardVO vo, Model model, Principal principal) {
		log.info("WorkSystemController.boardwriteform 호출" + vo);
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
		
		String userid = principal.getName();
		
		MemberVO memberVO = memberService.selectUserForPassword(userid);
		
		model.addAttribute("memberVO", memberVO);
		
		log.info("WorkSystemController.boardwriteform 종료" + vo);
		return "boardwriteform";
	}

	@RequestMapping(value = "/boardInsertOK")
	public String boardInsertOK(@ModelAttribute BoardVO vo, Model model, Principal principal) {
		log.info("WorkSystemController.boardInsertOK 호출" + vo);
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
		
		String userid = principal.getName();
		
		MemberVO memberVO = memberService.selectUserForPassword(userid);
		
		model.addAttribute("memberVO", memberVO);
		
		if (vo != null) {
			boardService.boardInsert(vo);
		}
		
		log.info("WorkSystemController.boardInsertOK 종료" + vo);
		return "boardInsertOK";
	}
	
	@RequestMapping(value = "/boardViewer")
	public String boardViewer(@RequestParam("idx") int idx, Model model, Principal principal) {
		log.info("WorkSystemController.boardViewer 호출");
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
		
		BoardVO boardVO = boardService.selectByIdx(idx);
		
		model.addAttribute("vo", boardVO);
		
		log.info("WorkSystemController.boardViewer 종료" + boardVO);
		return "boardViewer";
	}

	@RequestMapping(value = "/boardeditform")
	public String boardeditform(@RequestParam("idx") int idx, Model model, Principal principal) {
		log.info("WorkSystemController.boardeditform 호출");
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
		
		BoardVO boardVO = boardService.selectByIdx(idx);
		
		model.addAttribute("vo", boardVO);
		
		log.info("WorkSystemController.boardeditform 종료" + boardVO);
		return "boardeditform";
	}
	
	@RequestMapping(value = "/boardeditformOK")
	public String boardeditformOK(@ModelAttribute BoardVO vo, Model model, Principal principal) {
		log.info("WorkSystemController.boardeditformOK 호출" + vo);
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
		
		boardService.boardUpdate(vo);
		
		log.info("WorkSystemController.boardeditformOK 저장" + vo);
		return "boardeditformOK";
	}

	@RequestMapping(value = "/boardDeleteOK")
	public String boardDeleteOK(@RequestParam("idx") int idx, Model model, Principal principal) {
		log.info("WorkSystemController.boardDelete 호출");
		
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
		
		boardService.boardDelete(idx);
		
		log.info("WorkSystemController.boardDelete 종료");
		return "boardDeleteOK";
	}
	
	//-------------------------------------------------------------------------------------------------------------------------

	
	
	// 스케줄 관련
	//-------------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/eventList.xml")
	@ResponseBody
	public ScheduleListVO event() {
		ScheduleListVO listVO = new ScheduleListVO();
		listVO.setScheduleVO(scheduleService.select());
		return listVO;
	}

	@RequestMapping(value = "/eventList.json")
	@ResponseBody
	public List<ScheduleVO> event2() {
		return scheduleService.select();
	}

	@RequestMapping(value = "/schedule")
	public String schedule(Model model, Principal principal) {
		log.info("WorkSystemController.schedule");

		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}

		List<ScheduleVO> list = scheduleService.select();
		model.addAttribute("list", list);

		log.info("WorkSystemController.schedulelist 호출" + list);

		return "schedule";
	}

	@RequestMapping(value = "/insert")
	public String insert(@ModelAttribute ScheduleVO vo, Model model) {
		log.info("WorkSystemController.scheduleinsert 호출" + vo);

		if (vo != null) {
			scheduleService.insert(vo);
		}

		log.info("WorkSystemController.scheduleinsert 종료" + vo);
		return "insert";
	}

	@RequestMapping(value = "/update")
	public String update(@ModelAttribute ScheduleVO vo) {
		log.info("WorkSystemController.scheduleupdate 호출" + vo);

		scheduleService.update(vo);

		log.info("WorkSystemController.scheduleupdate 종료" + vo);
		return "update";
	}

	@RequestMapping(value = "/delete")
	public String delete(String id, Model model) {
		log.info("WorkSystemController.scheduledelete 호출" + id);

		scheduleService.delete(id);

		log.info("WorkSystemController.scheduledelete 종료" + id);
		return "delete";
	}
	
	//-------------------------------------------------------------------------------------------------------------------------

	// 직원 관련 (조회, 찾기, 등록, 수정)
	//-------------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/searchMember")
	public String searchMember(@ModelAttribute CommVO commVO, Model model, Principal principal,
			HttpServletRequest request) {
		log.info("WorkSystemController.searchMember호출");

		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}

		int memberCount = memberService.memberCount();
		model.addAttribute("memberCount", memberCount);

		List<MemberVO> list = memberService.selectAllMember();
		model.addAttribute("list", list);

		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);

		if (flashMap != null) {

			HashMap<String, Integer> map = (HashMap<String, Integer>) flashMap.get("hashMap");
			commVO.setP(map.get("p"));
			commVO.setS(map.get("s"));
			commVO.setB(map.get("b"));
		} else {
			// GET방식으로 값을 변경하려 한다면 누군가가 장난을 치는 것이므로
			if (request.getMethod().equals("GET")) {
				// 모든 값을 기본값을 가지게 한다.
				commVO.setP(-1);
				commVO.setS(-1);
				commVO.setB(-1);
			}
		}

		PagingVO<MemberVO> pagingVO = memberService.selectList(commVO.getCurrentPage(), commVO.getPageSize(),
				commVO.getBlockSize());

		model.addAttribute("commVO", commVO);
		model.addAttribute("pagingVO", pagingVO);

		return "searchMember";
	}

	@RequestMapping(value = "/searchName")
	public String searchName(@ModelAttribute CommVO commVO, HttpServletRequest request, Model model,
			Principal principal) {
		log.info("WorkSystemController.searchName호출");

		String name = request.getParameter("name");

		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}

		int nameCount = memberService.nameCount(name);
		model.addAttribute("nameCount", nameCount);

		PagingVO<MemberVO> pagingVO = memberService.selectByName(commVO.getCurrentPage(), commVO.getPageSize(),
				commVO.getBlockSize(), name);

		model.addAttribute("name", name);
		model.addAttribute("pagingVO", pagingVO);

		
		log.info("WorkSystemController.searchName호출" + pagingVO);

		return "searchName";
	}

	
	@RequestMapping(value = "/changeMember")
	public String changeMember(HttpServletRequest request, Model model, Principal principal) {
		log.info("WorkSystemController.changeMember호출");

		String userid = request.getParameter("userid");
		log.info("WorkSystemController.changeMember호출" + userid);

		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}

		List<MemberVO> list = memberService.selectByUserId(userid);
		model.addAttribute("list", list);

		List<MemberRoleVO> roleVO = memberService.selectRole(userid);
		model.addAttribute("roleVO", roleVO);
		log.info("WorkSystemController.changeMember호출" + list);

		return "changeMember";
	}

	@RequestMapping(value = "/updatePersonal")
	public String updatePersonal(HttpServletRequest request, Model model, Principal principal) {
		log.info("WorkSystemController.changeMember호출");

		String userid = principal.getName();

		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}

		List<MemberVO> list = memberService.selectByUserId(userid);
		model.addAttribute("list", list);

		List<MemberRoleVO> roleVO = memberService.selectRole(userid);
		model.addAttribute("roleVO", roleVO);
		log.info("WorkSystemController.changeMember호출" + list);

		return "updatePersonal";
	}

	@RequestMapping(value = "/insertMember")
	public String insertMember(@ModelAttribute MemberVO vo, @ModelAttribute MemberRoleVO rvo, Model model) {
		log.info("WorkSystemController.insertMember 호출" + vo);
		log.info("WorkSystemController.insertMember 호출" + rvo);

		if (vo != null) {
			memberService.insert(vo);
			memberService.insertRole(rvo);
		}

		log.info("WorkSystemController.insertMember 종료" + vo);
		log.info("WorkSystemController.insertMember 종료" + rvo);
		return "registerOK";
	}

	@RequestMapping(value = "/updateMember")
	public String updateMember(@ModelAttribute MemberVO vo, @ModelAttribute MemberRoleVO rvo,
			HttpServletRequest request, Model model) {
		log.info("WorkSystemController.updateMember 호출" + vo);
		log.info("WorkSystemController.updateMember 호출" + rvo);
		log.info("WorkSystemController.updateMember 호출   " + vo.getPassword());

		if (vo.getPassword() == null) {
			memberService.update(vo);
		} else {
			memberService.updatePassword(vo);
		}

		MemberRoleVO roleVO = memberService.selectRoleById(vo.getUserid());
		log.info("WorkSystemController.updateMember selectRoleById" + roleVO);
		
		if(roleVO == null) {
			memberService.insertRole(rvo);
		} else {
			memberService.updateRole(rvo);
		}

		log.info("WorkSystemController.updateMember 종료" + vo);
		log.info("WorkSystemController.updateMember 종료" + rvo);
		return "updateMemberOK";
	}

	@RequestMapping(value = "/updateMemberOK")
	public String findPasswordOK(Model model, Principal principal) {
		log.debug("MemberController.updateMemberOK 호출");
		if (principal != null) {
			List<MemberVO> auth = memberService.selectByUserId(principal.getName());
			model.addAttribute("auth", auth);
		}
		return "redirect:/";
	}

	@RequestMapping(value = "/deleteMember")
	public String deleteMember(@ModelAttribute MemberVO vo, @ModelAttribute MemberRoleVO rvo,
			HttpServletRequest request, Model model) {
		log.info("WorkSystemController.deleteMember 호출");

		memberService.delete(vo);
		memberService.deleteRole(rvo);

		log.info("WorkSystemController.deleteMember 종료");
		return "deleteMemberOK";
	}
	
	//-------------------------------------------------------------------------------------------------------------------------
	
	// 아이디 & 패스워드 찾기
	//-------------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/findUseridPassword", method = RequestMethod.POST)
	public String findUserid(@ModelAttribute MemberVO vo, HttpServletRequest request, Model model) {
		log.info("WorkSystemController.findUserid 호출 ");

		String name = request.getParameter("name");

		List<String> memberVO = memberService.findUserid(vo);

		model.addAttribute("memberVO", memberVO);
		model.addAttribute("name", name);
		log.info("WorkSystemController.findUserid 호출" + memberVO);

		return "findUseridOK";
	}

	@RequestMapping(value = "/findPasswordOK")
	public String findPasswordOKPost(HttpServletRequest request, Model model) {
		log.debug("MemberController.findPasswordOK 호출");

		String userid = request.getParameter("userid");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String password = null;

		MemberVO dbVO = memberService.selectUserForPassword(userid);
		if (dbVO.getUserid().equals(userid) && dbVO.getName().equals(name) && dbVO.getPhone().equals(phone)) {

			password = makePassword(6);

			memberService.findPassword(password, userid);

		}
		model.addAttribute("newPassword", password);

		return "findPasswordOK";
	}

	public String makePassword(int length) {

		StringBuffer sb = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < length; i++) {
			if ((i + 1) % 3 == 0) {
				sb.append((char) ('A' + rnd.nextInt(26)));
			} else if ((i + 1) % 3 == 1) {
				sb.append((char) ('a' + rnd.nextInt(26)));
			} else {
				sb.append((char) ('0' + rnd.nextInt(10)));
			}
		}
		return sb.toString();
	}

}
