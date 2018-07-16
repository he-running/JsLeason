------创建存储过程proc_station_timer_job定时任务
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
  dbms_job.isubmit(jobid,'proc_station_timer_job;',sysdate,'TRUNC(sysdate,''mi'')+5/(24*60)');
  commit;
end;
