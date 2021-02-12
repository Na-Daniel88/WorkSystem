package kr.co.work.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.work.dao.ScheduleDAO;
import kr.co.work.vo.ScheduleVO;

@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleDAO scheduleDAO;
	
	@Override
	public List<ScheduleVO> select() {
		
		return scheduleDAO.select();
	}

	@Override
	public void insert(ScheduleVO vo) {

		scheduleDAO.insert(vo);
	}

	@Override
	public void update(ScheduleVO vo) {

		scheduleDAO.update(vo);
	}

	@Override
	public void delete(String id) {

		scheduleDAO.delete(id);
	}

}
