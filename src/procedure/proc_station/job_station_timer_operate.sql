--job_station_timer的操作,选中某段执行即可,不要全部执行

--修改定时任务,传入参数格式跟创建时一致,如要修改id,只能先删除再新建
declare 
  jobid number :=258;
begin 
  dbms_job.change(jobid,'proc_student_test_update;',sysdate,'TRUNC(sysdate,''mi'')+1/(24*60)');
  commit;
end;


--停止和运行job,用broken方法,第一个参数是jobid,第二个参数boolean,true关闭,false开启
begin
  dbms_job.broken(258,true);
  commit;
end;


--或者直接运行,run方法,传入jobid
begin
  dbms_job.run(258);
  commit;
end;


--查看定时任务
  select * from dba_jobs;
  
  
--删除定时任务,传入iobid
begin 
  dbms_job.remove(258);
  commit;
end;
