package kr.co.work.dao;

import java.util.List;

import kr.co.work.vo.ScheduleVO;

public interface ScheduleDAO {

	List<ScheduleVO> select();
	void insert(ScheduleVO vo);
	void update(ScheduleVO vo);
	void delete(String id);
	
}
