package kr.co.work.service;

import kr.co.work.vo.BoardVO;
import kr.co.work.vo.PagingVO;

public interface BoardService {

	public int BoardCount();
	
	public int selectMaxIdx();
	
	public BoardVO selectByIdx(int idx);
	
	public int searchCount(String search_field, String search_content);
	
	public PagingVO<BoardVO> boardList(int currentPage, int pageSize, int blockSize, String search_field, String search_content);
	
	public void boardInsert(BoardVO vo);

	public void boardUpdate(BoardVO vo);
	
	public void boardDelete(int idx);
}