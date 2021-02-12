package kr.co.work.vo;

import lombok.Data;

@Data
public class MemberVO {

	private String userid;
	private String password;
	private String name;
	private String phone;
	private String birth;
	private String gender;
	private String dept;
	private String lvl;
	private String postCode;
	private String addr1;
	private String addr2;
	private String exAddr;
	private String regDate;
	private int enabled;

}
