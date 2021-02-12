package kr.co.work.service;

import kr.co.work.vo.NoticeBoardVO;
import kr.co.work.vo.PagingVO;

public interface NoticeBoardService {

	public int noticeBoardCount();
	
	public int searchCount(String search_field, String search_content);
	
	public int selectMaxIdx();
	
	public NoticeBoardVO selectByIdx(int idx);

	public PagingVO<NoticeBoardVO> noticeList(int currentPage, int pageSize, int blockSize, String search_field, String search_content);
	
	public void noticeInsert(NoticeBoardVO vo);

	public void noticeUpdate(NoticeBoardVO vo);
	
	public void noticeDelete(int idx);
}
