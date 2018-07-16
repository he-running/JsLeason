alter table tb_student_test
      add constraint pk_student_test primary key(id);

alter table tb_student_test add (address varchar2(50))
alter table tb_student_test add (updatetime DATE)

alter table tb_student_test add (lat number(9,6))