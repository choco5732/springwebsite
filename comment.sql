select * from board where bno=1085;
insert into board values(1085, 'hello', 'hello', 'choco5732', 0, 0, now(), now());

delete from board where bno=1085;

select * from comment;

select * from comment;
insert into comment(bno, comment, commenter)
values(1085, '덧글입니다', 'choco5732');
