create table tb_student_test (
    id integer not null,
    name varchar2(30) not null,
    sex varchar2(10) not null,
    age integer
)

insert into tb_student_test values (1,'he','男',20);
insert into tb_student_test values (2,'hehe','女',21);
insert into tb_student_test values (3,'haha','男',22);

--批量插入
insert all into tb_student_test values (4,'gaga','男',23)
       into tb_student_test values (5,'wawa','女',24)
       select * from tb_student_test;

commit;