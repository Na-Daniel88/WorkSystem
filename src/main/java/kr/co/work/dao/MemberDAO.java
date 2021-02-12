package kr.co.work.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.work.vo.MemberRoleVO;
import kr.co.work.vo.MemberVO;

public interface MemberDAO {
	
	public int memberCount();

	public int nameCount(String name);
	
	public List<MemberVO> selectList(HashMap<String, Integer> map);

	public MemberVO selectUserForPassword(String userid);

	public List<MemberVO> selectByName(HashMap<String, String> map);
	
	public List<MemberVO> selectByUserId(String userid);

	public List<MemberRoleVO> selectRole(String userid);
	
	public MemberRoleVO selectRoleById(String userid);
	
	public List<MemberVO> selectAllMember();
	
	public List<String> findUserid(MemberVO vo);
	
	public void findPassword(HashMap<String, String> map);
	
	public void insert(MemberVO vo);
	
	public void insertRole(MemberRoleVO rvo);
	
	public void update(MemberVO vo);
	
	public void updatePassword(MemberVO vo);
	
	public void updateRole(MemberRoleVO rvo);
	
	public void delete(MemberVO vo);
	
	public void deleteRole(MemberRoleVO rvo);
	
	
}
