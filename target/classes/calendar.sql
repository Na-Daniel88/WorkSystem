DROP TABLE schedule;

CREATE table schedule(
	id varchar2(100) NOT NULL,
	allDay char(10) NOT null,
	title varchar2(100) NOT NULL,
	startDate varchar2(50) NOT NULL,
	endDate varchar2(50) NOT NULL,
	type varchar2(50) NOT NULL,
	color varchar2(30) NOT NULL,
	description varchar2(100) NOT NULL
); 

SELECT * FROM SCHEDULE s ;

insert into schedule (id, allDay, title, startDate, ENDDATE , type, color, DESCRIPTION ) values ('1', 'true', 'test', '2020-08-20', '2020-08-22', '출장', '출장', 'test');
update schedule SET "type"='업무', "desc"='test123' where id=1


SELECT TO_char("end"-1, 'YYYYMMDD') FROM SCHEDULE;

SELECT * FROM SCHEDULE;