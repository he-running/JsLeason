--job_station_timer�Ĳ���,ѡ��ĳ��ִ�м���,��Ҫȫ��ִ��

--�޸Ķ�ʱ����,���������ʽ������ʱһ��,��Ҫ�޸�id,ֻ����ɾ�����½�
declare 
  jobid number :=258;
begin 
  dbms_job.change(jobid,'proc_student_test_update;',sysdate,'TRUNC(sysdate,''mi'')+1/(24*60)');
  commit;
end;


--ֹͣ������job,��broken����,��һ��������jobid,�ڶ�������boolean,true�ر�,false����
begin
  dbms_job.broken(258,true);
  commit;
end;


--����ֱ������,run����,����jobid
begin
  dbms_job.run(258);
  commit;
end;


--�鿴��ʱ����
  select * from dba_jobs;
  
  
--ɾ����ʱ����,����iobid
begin 
  dbms_job.remove(258);
  commit;
end;
