package kr.co.work.service;

import java.util.List;

import kr.co.work.vo.ScheduleVO;

public interface ScheduleService {

	List<ScheduleVO> select();
	void insert(ScheduleVO vo);
	void update(ScheduleVO vo);
	void delete(String id);
}
