package kr.co.work.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.work.vo.NoticeBoardVO;

public interface NoticeBoardDAO {

	public int noticeBoardCount();

	public int searchCount(HashMap<String, String> map);
	
	public int selectMaxIdx();
	
	public NoticeBoardVO selectByIdx(int idx);
	
	public List<NoticeBoardVO> noticeList(HashMap<String, String> map);

	public void noticeInsert(NoticeBoardVO vo);

	public void noticeUpdate(NoticeBoardVO vo);
	
	public void noticeDelete(int idx);
}
