package kr.co.work.vo;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

/*
	id varchar2(100) NOT NULL,
	allDay char(10) NOT null,
	title varchar2(100) NOT NULL,
	startDate varchar2(50) NOT NULL,
	endDate varchar2(50) NOT NULL,
	type varchar2(50) NOT NULL,
	color varchar2(30) NOT NULL,
	description varchar2(100) NOT NULL
 */
@XmlRootElement
@Data
public class ScheduleVO {

	private String id; 
	private String allDay;
	private String title;
	private String startDate;
	private String endDate;
	private String type;
	private String color;
	private String description;
}
