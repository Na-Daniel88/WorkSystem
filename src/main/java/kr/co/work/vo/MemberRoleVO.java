package kr.co.work.vo;

import javax.xml.bind.annotation.XmlRootElement;

import lombok.Data;

@XmlRootElement
@Data
public class MemberRoleVO {

	private int role_idx;
	private String userid;
	private String role;
}
