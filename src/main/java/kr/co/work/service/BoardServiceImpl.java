package kr.co.work.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.work.dao.BoardDAO;
import kr.co.work.vo.BoardVO;
import kr.co.work.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO boardDAO;

	@Override
	public int BoardCount() {

		return boardDAO.BoardCount();
	}

	@Override
	public int selectMaxIdx() {

		return boardDAO.selectMaxIdx();
	}

	@Override
	public BoardVO selectByIdx(int idx) {

		return boardDAO.selectByIdx(idx);
	}


	@Override
	public PagingVO<BoardVO> boardList(int currentPage, int pageSize, int blockSize, String search_field, String search_content) {
		
		HashMap<String, String> map1 = new HashMap<>();
		map1.put("search_field", search_field);
		map1.put("search_content", search_content);
		int totalCount = boardDAO.searchCount(map1);
		
		PagingVO<BoardVO> pagingVO = new PagingVO<BoardVO>(totalCount, currentPage, pageSize, blockSize);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("startNo", pagingVO.getStartNo()+"");
		map.put("endNo", pagingVO.getEndNo()+"");
		map.put("search_field", search_field);
		map.put("search_content", search_content);
		pagingVO.setList(boardDAO.boardList(map));
		
		return pagingVO;
	}

	@Override
	public void boardInsert(BoardVO vo) {

		boardDAO.boardInsert(vo);

	}

	@Override
	public void boardUpdate(BoardVO vo) {

		boardDAO.boardUpdate(vo);

	}

	@Override
	public void boardDelete(int idx) {

		boardDAO.boardDelete(idx);

	}

	@Override
	public int searchCount(String search_field, String search_content) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("search_field", search_field);
		map.put("search_content", search_content);
		
		return boardDAO.searchCount(map);
	}

}
