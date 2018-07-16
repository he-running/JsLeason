--新建存储过程
create or replace procedure PROC_STUDENT_TEST
(
  tname in tb_student_test.NAME %TYPE , --note,输入的参数,类型跟表声明类型一致
  tage in integer  --数据类型为自己声明的int
)
as
  --可在这添加说明或定义中间变量

begin
  update tb_student_test set age = age+tage where name = tname;
  --一般不在存储过程中添加commit
  commit;
end PROC_STUDENT_TEST;