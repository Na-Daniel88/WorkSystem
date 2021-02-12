DROP TABLE board;
DROP SEQUENCE board_idx_seq;

CREATE SEQUENCE board_idx_seq;

CREATE TABLE board(
	idx number(11) PRIMARY KEY,
	title varchar2(50),
	content varchar2(500),
	userid varchar2(20),
	writer varchar2(20),
	boardDate timestamp
);

SELECT * FROM board;

INSERT INTO board (idx, title, content, writer, boardDate) VALUES (BOARD_idx_seq.nextval, '테스트1', '테스트내용1', '관리자', SYSDATE)

SELECT rownum rnum, r.* FROM (select * from board order by idx desc) r;

DELETE FROM board WHERE idx = 24;