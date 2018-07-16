--储存过程,本质上是对业务复杂的SQL语句的封装
--写好后,可供java等语言像调用普通SQL语句一样调用该过程

------------------------------ 存储过程的声明 ---------------------------
--创建一个存储过程
create or replace procedure proc_test
(
   p1 in out number,p2 in number,r1 out number,r2 out number
)
as
  --in:输入参数,out:输出参数,in out:输入输出参数,顺序为先取输入值再赋值输出;
begin
   r1 := p1+p2;
   r2 := p1-p2;
   p1 :=888;
end proc_test;


--调用存储过程,利用PL/SQL匿名块调用该过程
declare
 a number(5) := 100;
 b number(5) :=1000;
 c number(5) :=100;
 d number(5) :=100;

begin
  proc_test(a,b,c,d);
  dbms_output.put_line('a+b ='||c);
  dbms_output.put_line('a-b='||d);
  dbms_output.put_line('a的值为:'||' b的值为: '||b);
end;


--demo1,实际的数据库操作
create or replace procedure PROC_STUDENT_TEST
(
  tname in tb_student_test.name%type --note,输入的参数
)
as
  --可在这添加说明或定义中间变量
  tsex varchar2(50);
begin
  --update tb_student_test set age = age+tage where name = tname;
  --select sex into tsex from tb_student_test where name = tname;
  select count(*) into tsex from tb_student_test where id =2;

  dbms_output.put_line(tsex);

end PROC_STUDENT_TEST;

--demo2,测试in,out类型
create or replace procedure proc_test
(
   p1 in out number,p2 in number,r1 out number,r2 out number
)
as

begin
   r1 := p1+p2;
   r2 := p1-p2;
   p1 :=888;
end proc_test;

--demo3,测试if..then语句
create or replace procedure proc_test
(
x in out number
)
as
  time varchar(100);
begin
  if x < 0 then
    begin
      dbms_output.put_line('输入为负数: '||x);
      x :=0-x;
    end;
  elsif x > 0 then
    begin
      dbms_output.put_line('输入为正数: '||x);
      x :=x;
    end;
  else
    x :=0;
  end if;
  time := to_char(sysdate,'yyyy/mm/dd hh24:mi:ss');
  dbms_output.put_line('x的值为: '||x);
  dbms_output.put_line('时间: '||time);
end proc_test;

--demo4,测试for in..loop语句
declare
   num number :=100;
begin
  for i in 1..10 loop
    if MOD(i,2) = 0 then
      dbms_output.put_line('偶数: '||i);
    else
      dbms_output.put_line('奇数: '||i);
    end if;
    num :=num+100;
    dbms_output.put_line('x的值: '||num);
  end loop;
end;

--demo5,测试while循环
declare
  num number := 10;
  time varchar(50) :=to_char(sysdate,'yyyy/mm/dd hh24:mi:ss');
begin
  while num>0 loop
    begin
        num := num-1;
        dbms_output.put_line('num的值为: '||num);
    end;
   end loop;
  dbms_output.put_line('时间: '||time);
end;

--demo6,测试case多重选择
declare
   num number;
   let varchar2(10):='C';
begin
  case let
  when 'A' then num :=1;
  when 'B' then num :=2;
  when 'C' then num :=3;
  when 'D' then num :=4;
  else
    num :=-1;
   end case;
  dbms_output.put_line('值为: '||num);
end;

-----------------demo7,job定时任务测试,定时更新---------------
create or replace procedure proc_student_test_update
is
begin
  update tb_student_test set updatetime = sysdate;
  dbms_output.put_line('定时到,执行更新');
end proc_student_test_update;

------创建job定时任务
declare
  --由系统自动生成,起始值一般是21;
  --如果需要手动指定一个任务编号,则只需要给jobid赋值,
  --然后调用'issubmit()'方法来替代'submit()'方法创建任务即可
  --jobid number;
  jobid number :=258;
begin
  --4个参数,jobid:第一个指定定时任务的id,必须为number;
  --what:第二个参数,指定要执行的存储过程,结尾要加分号
  --next_date:第三个参数,指定下一个执行的时间,格式为date
  --interval:第四个参数,指定执行的频率,也就是计算下一次执行时间的公式,字符串格式
  --dbms_job.submit(jobid,'proc_student_test_update;',sysdate,'TRUNC(sysdate,''mi'')+5/(24*60)');
  dbms_job.isubmit(jobid,'proc_student_test_update;',sysdate,'TRUNC(sysdate,''mi'')+5/(24*60)');
  commit;
end;

--修改定时任务,传入参数格式跟创建时一致
declare
  jobid number :=258;
begin
  dbms_job.change(jobid,'proc_student_test_update;',sysdate,'TRUNC(sysdate,''mi'')+1/(24*60)');
  commit;
end;

--停止和运行job,用broken方法,第一个参数是jobid,第二个参数boolean,true关闭,false开启
begin
  dbms_job.broken(21,true);
  commit;
end;
--或者直接运行,run方法,传入jobid
begin
  dbms_job.run(21);
  commit;
end;
--查看定时任务
  select * from dba_jobs;
--删除定时任务,传入iobid
begin
  dbms_job.remove(24);
  commit;
end;

--------------------存储过程的调用-------------------------
--1.匿名块调用
--demo1的调用,需要tb_student_test.sql的配合,有些CURD操作没写出来
declare
    tname tb_student_test.NAME %TYPE :='he';
begin
    proc_student_test(tname);
end;

--demo2的调用
declare
 a number(5) := 100;
 b number(5) :=1000;
 c number(5) :=100;
 d number(5) :=100;

begin
  proc_test(a,b,c,d);
  dbms_output.put_line('a+b ='||c);
  dbms_output.put_line('a-b='||d);
  dbms_output.put_line('a的值为:'||' b的值为: '||b);
end;

--demo3的调用
declare
    myNum1 number := -1;
    myNum2 number := 0;
    myNum3 number := 1;

begin
  proc_test(myNum1);
  proc_test(myNum2);
  proc_test(myNum3);
end;


--2.在pl/sql developer中调用
--demo1的调用
call proc_student_test('hehe');


--3.java代码中调用存储过程,大概如下
String sql = "{call proc_student_test(?,?)}";
Connection conn = ...;
CallableStatement call = conn.prepareCall(sql);
//in 参数,赋值
call.setString("hehe");
call.setInt(2);
//最后执行
call.execute();
//有out参数的,则需要另外处理