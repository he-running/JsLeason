------�����洢����proc_station_timer_job��ʱ����
declare 
  --��ϵͳ�Զ�����,��ʼֵһ����21;
  --�����Ҫ�ֶ�ָ��һ��������,��ֻ��Ҫ��jobid��ֵ,
  --Ȼ�����'issubmit()'���������'submit()'�����������񼴿�
  --jobid number;
  jobid number :=258;
begin
  --4������,jobid:��һ��ָ����ʱ�����id,����Ϊnumber;
  --what:�ڶ�������,ָ��Ҫִ�еĴ洢����,��βҪ�ӷֺ�
  --next_date:����������,ָ����һ��ִ�е�ʱ��,��ʽΪdate
  --interval:���ĸ�����,ָ��ִ�е�Ƶ��,Ҳ���Ǽ�����һ��ִ��ʱ��Ĺ�ʽ,�ַ�����ʽ
  --dbms_job.submit(jobid,'proc_student_test_update;',sysdate,'TRUNC(sysdate,''mi'')+5/(24*60)');
  dbms_job.isubmit(jobid,'proc_station_timer_job;',sysdate,'TRUNC(sysdate,''mi'')+5/(24*60)');
  commit;
end;
