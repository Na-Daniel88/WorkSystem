DROP TABLE notice_board;
DROP SEQUENCE notice_board_idx_seq;

CREATE SEQUENCE notice_board_idx_seq;

CREATE TABLE notice_board(
	idx number(11) PRIMARY KEY,
	title varchar2(50),
	content varchar2(500),
	writer varchar2(20),
	noticeDate timestamp
);

SELECT * FROM notice_board;

INSERT INTO notice_board (idx, title, content, writer, noticeDate) VALUES (NOTICE_BOARD_idx_seq.nextval, '테스트1', '테스트내용1', '관리자', SYSDATE)

DELETE FROM NOTICE_BOARD WHERE idx = 2;

SELECT q.*	FROM (SELECT rownum rnum, r.* FROM (select * from notice_board  where title like '%테스%' order by idx desc) r WHERE rownum <= 23 ) q where rnum >= 1;