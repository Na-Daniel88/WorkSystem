package kr.co.work.vo;

import java.util.Date;

import lombok.Data;

/*
 * idx number(11) PRIMARY KEY,
	title varchar2(50),
	content varchar2(500),
	writer varchar2(20),
	noticeDate timestamp
 */

@Data
public class BoardVO {

	private int idx;
	private String title;
	private String content;
	private String userid;
	private String writer;
	private Date boardDate;
	
}
