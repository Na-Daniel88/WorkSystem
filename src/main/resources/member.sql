DROP TABLE MEMBER;

CREATE TABLE MEMBER (
	userid varchar2(50) PRIMARY KEY NOT NULL,
	password varchar2(100) NOT NULL,
	name varchar2(50) NOT NULL,
	phone varchar2(30) NOT NULL,
	birth DATE, 
	gender char(1) DEFAULT 'M',
	dept varchar2(20),
	lvl varchar2(20) NOT NULL,
	postCode varchar2(10) NOT NULL,
	addr1 varchar2(100) NOT NULL,
	addr2 varchar2(100),
	exAddr varchar2(100),
	regDate date,
	enabled number
);



SELECT * FROM MEMBER;
SELECT birth FROM MEMBER WHERE name LIKE '% 사원 %';
select * from member where name LIKE '%'||'사원'||'%';
UPDATE MEMBER SET BIRTH = TO_char(BIRTH, 'yyyy-mm-dd');
select * from member where name = 'admin' and phone = 'admin';
select userid as username, password, ENABLED AS enabled from MEMBER;

INSERT INTO MEMBER (userid, PASSWORD , NAME , PHONE , BIRTH , GENDER , LVL , postCode, ADDR1 ,ADDR2 , REGDATE, ENABLED ) VALUES ('admin', 'admin123', 'admin', '010-1123-3456', '2020-09-14', 'M', '관리자', '14780', 'admin', 'admin', sysdate, 1);
INSERT INTO MEMBER (userid, PASSWORD , NAME , PHONE , BIRTH , GENDER , DEPT , LVL , ADDR1 ,ADDR2 , REGDATE, ENABLED ) VALUES ('1104', '123', 'john', '010-1243-7556', '2020-09-18', 'M', '기술부', '대리', 'john', 'john', sysdate, 1);
INSERT INTO MEMBER (userid, PASSWORD , NAME , PHONE , BIRTH , GENDER , LVL , ADDR1 ,ADDR2 , REGDATE, ENABLED ) VALUES ('1user1', '123', 'kim', '010-1243-7556', '2020-09-18', 'm', '대리', 'kim', 'john', '2001-09-18', 1);

DELETE FROM MEMBER WHERE userid = 'user';


iNSERT INTO MEMBER_ROLES (role_idx,userid,role) VALUES 
(member_role_idx_seq.nextval,'admin','ROLE_ADMIN');

iNSERT INTO MEMBER_ROLES (role_idx,userid,role) VALUES 
(member_role_idx_seq.nextval,'user','ROLE_USER');

SELECT * FROM MEMBER_ROLES;
select * from member_roles

select userid as username, password, 1 AS enabled from member where userid='admin';

DROP SEQUENCE member_role_idx_seq;
CREATE SEQUENCE member_role_idx_seq;

DROP TABLE MEMBER_ROLES; 

CREATE TABLE member_roles (
  role_idx NUMBER(11)  PRIMARY KEY,
  userid varchar2(45) NOT NULL,
  role varchar2(45) NOT NULL
);
DROP view viewmember;
CREATE VIEW viewmember AS SELECT userid, PASSWORD , NAME , PHONE , TO_char(BIRTH, 'yyyy-mm-dd') AS BIRTH , GENDER , DEPT, LVL ,postCode, ADDR1 ,ADDR2, exAddr , TO_char(REGDATE , 'yyyy-mm-dd') AS REGDATE , ENABLED FROM MEMBER;

SELECT * FROM viewmember;

CREATE VIEW allMember AS SELECT m.*, r.ROLE FROM MEMBER m, MEMBER_ROLES r where m.USERID = r.USERID;

SELECT * FROM allmember;

select * from member order by userid ASC;
SELECT rownum rnum, r.* FROM (select * from member order by userid asc) r WHERE rownum <= 3;

SELECT q.*	FROM (SELECT rownum rnum, r.* FROM (select * from member order by userid asc) r WHERE rownum <= 12 ) q where rnum >= 5;
select * from MEMBER WHERE name LIKE '%'||'사원'||'%' order by userid asc

