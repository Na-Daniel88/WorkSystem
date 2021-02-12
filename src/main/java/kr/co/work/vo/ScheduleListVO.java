package kr.co.work.vo;

import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@XmlRootElement
@Data
public class ScheduleListVO {

	private List<ScheduleVO> scheduleVO;
}
