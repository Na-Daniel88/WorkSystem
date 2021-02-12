package kr.co.work.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.work.dao.MemberDAO;
import kr.co.work.vo.BoardVO;
import kr.co.work.vo.MemberRoleVO;
import kr.co.work.vo.MemberVO;
import kr.co.work.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Override
	public MemberVO selectUserForPassword(String userid) {
		
		return memberDAO.selectUserForPassword(userid);
	}
	
	@Override
	public List<MemberVO> selectByUserId(String userid) {
		
		return memberDAO.selectByUserId(userid);
	}

	@Override
	public void insert(MemberVO vo) {

		String password = vo.getPassword();
		password = bcryptPasswordEncoder.encode(password);
		vo.setPassword(password);
		
		memberDAO.insert(vo);
		
	}

	@Override
	public void insertRole(MemberRoleVO rvo) {

		memberDAO.insertRole(rvo);
		
	}

	@Override
	public void update(MemberVO vo) {
		
			memberDAO.update(vo);
						
	}
	@Override
	public void updatePassword(MemberVO vo) {
		
		if(vo.getPassword()!=null) {
			String password = vo.getPassword();
			password = bcryptPasswordEncoder.encode(password);
			vo.setPassword(password);
		}
		
		memberDAO.updatePassword(vo);
		
	}

	@Override
	public void updateRole(MemberRoleVO rvo) {

		memberDAO.updateRole(rvo);
		
	}

	@Override
	public void delete(MemberVO vo) {

		memberDAO.delete(vo);
		
	}

	@Override
	public void deleteRole(MemberRoleVO rvo) {

		memberDAO.deleteRole(rvo);
		
	}

	@Override
	public List<MemberVO> selectAllMember() {

		return memberDAO.selectAllMember();
	}

	@Override
	public List<MemberRoleVO> selectRole(String userid) {

		return memberDAO.selectRole(userid);
	}
	@Override
	public MemberRoleVO selectRoleById(String userid) {
		
		return memberDAO.selectRoleById(userid);
	}

	@Override
	public PagingVO<MemberVO> selectByName(int currentPage, int pageSize, int blockSize, String name) {

		int totalCount = memberDAO.nameCount(name);
		PagingVO<MemberVO> pagingVO = new PagingVO<MemberVO>(totalCount, currentPage, pageSize, blockSize);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("startNo", pagingVO.getStartNo()+"");
		map.put("endNo", pagingVO.getEndNo()+"");
		map.put("name", name);
		pagingVO.setList(memberDAO.selectByName(map));
		return pagingVO;
	}

	@Override
	public List<String> findUserid(MemberVO vo) {

		return memberDAO.findUserid(vo);
	}
	
	
	@Override
	public void findPassword(String password, String userid) {

		password = bcryptPasswordEncoder.encode(password);
		
		HashMap<String, String> map = new HashMap<>();
		map.put("password", password);
		map.put("userid", userid);
		
		memberDAO.findPassword(map);
		

	}

	@Override
	public int memberCount() {
		
		return memberDAO.memberCount();
	}

	@Override
	public int nameCount(String name) {

		return memberDAO.nameCount(name);
	}

	@Override
	public PagingVO<MemberVO> selectList(int currentPage, int pageSize, int blockSize) {

		int totalCount = memberDAO.memberCount();
		
		PagingVO<MemberVO> pagingVO = new PagingVO<MemberVO>(totalCount, currentPage, pageSize, blockSize);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("startNo", pagingVO.getStartNo());
		map.put("endNo", pagingVO.getEndNo());
		pagingVO.setList(memberDAO.selectList(map));
		
		
		return pagingVO;
	}

	

}
