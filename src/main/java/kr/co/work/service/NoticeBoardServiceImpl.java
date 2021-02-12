package kr.co.work.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.work.dao.NoticeBoardDAO;
import kr.co.work.vo.NoticeBoardVO;
import kr.co.work.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("noticeService")
public class NoticeBoardServiceImpl implements NoticeBoardService {

	@Autowired
	private NoticeBoardDAO noticeBoardDAO;

	@Override
	public int noticeBoardCount() {

		return noticeBoardDAO.noticeBoardCount();
	}

	@Override
	public int selectMaxIdx() {

		return noticeBoardDAO.selectMaxIdx();
	}

	@Override
	public NoticeBoardVO selectByIdx(int idx) {

		return noticeBoardDAO.selectByIdx(idx);
	}

	
	@Override
	public PagingVO<NoticeBoardVO> noticeList(int currentPage, int pageSize, int blockSize, String search_field, String search_content) {
		
		HashMap<String, String> map1 = new HashMap<>();
		map1.put("search_field", search_field);
		map1.put("search_content", search_content);
		int totalCount = noticeBoardDAO.searchCount(map1);
		
		PagingVO<NoticeBoardVO> pagingVO = new PagingVO<NoticeBoardVO>(totalCount, currentPage, pageSize, blockSize);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("startNo", pagingVO.getStartNo()+"");
		map.put("endNo", pagingVO.getEndNo()+"");
		map.put("search_field", search_field);
		map.put("search_content", search_content);
		pagingVO.setList(noticeBoardDAO.noticeList(map));
		
		return pagingVO;
	}

	@Override
	public void noticeInsert(NoticeBoardVO vo) {

		noticeBoardDAO.noticeInsert(vo);

	}

	@Override
	public void noticeUpdate(NoticeBoardVO vo) {

		noticeBoardDAO.noticeUpdate(vo);

	}

	@Override
	public void noticeDelete(int idx) {

		noticeBoardDAO.noticeDelete(idx);

	}


	@Override
	public int searchCount(String search_field, String search_content) {

		HashMap<String, String> map = new HashMap<>();
		map.put("search_field", search_field);
		map.put("search_content", search_content);
		
		return noticeBoardDAO.searchCount(map);
		
	}

	

}
