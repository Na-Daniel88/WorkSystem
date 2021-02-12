package kr.co.work.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.work.vo.BoardVO;

public interface BoardDAO {

	public int BoardCount();
	
	public int selectMaxIdx();
	
	public BoardVO selectByIdx(int idx);
	
	public int searchCount(HashMap<String, String> map);
	
	public List<BoardVO> boardList(HashMap<String, String> map);
	
	public void boardInsert(BoardVO vo);

	public void boardUpdate(BoardVO vo);
	
	public void boardDelete(int idx);
}
