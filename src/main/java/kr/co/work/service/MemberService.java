package kr.co.work.service;

import java.util.List;

import kr.co.work.vo.MemberRoleVO;
import kr.co.work.vo.MemberVO;
import kr.co.work.vo.PagingVO;

public interface MemberService {
	
	public int memberCount();
	
	public int nameCount(String name);
	
	public PagingVO<MemberVO> selectList(int currentPage, int pageSize, int blockSize);

	public MemberVO selectUserForPassword(String userid);
	
	public PagingVO<MemberVO> selectByName(int currentPage, int pageSize, int blockSize, String name);
	
	public List<MemberVO> selectByUserId(String userid);
	
	public List<MemberRoleVO> selectRole(String userid);
	
	public MemberRoleVO selectRoleById(String userid);
	
	public List<MemberVO> selectAllMember();
	
	public List<String> findUserid(MemberVO vo);
	
	// 비밀번호 찾기
	public void findPassword(String password, String userid);
	
	public void insert(MemberVO vo);
	
	public void insertRole(MemberRoleVO rvo);
	
	public void update(MemberVO vo);
	
	public void updatePassword(MemberVO vo);
	
	public void updateRole(MemberRoleVO rvo);
	
	public void delete(MemberVO vo);
	
	public void deleteRole(MemberRoleVO rvo);
}
