create or replace procedure proc_station_timer_job is
   --�Զ���İ汾��Ϣ,�̶�
   tver_name tb_runstatus.w_ver_name%type :='vHZ127.0.1';
   tcalccount tb_equipcalc.calccount%type;
begin
  --�Զ���İ汾��Ϣ,�̶�
  --�����Ϻ���,��ʱ������������״̬
  select count(*) into tcalccount from tb_equipcalc;
  
  if tcalccount > 0 then
     --����
     update tb_runstatus set onlinestatus =1 where w_ver_name = tver_name;
     dbms_output.put_line('��ʱ����: �Ϻ�����Ϊ0,����');
  else
    update tb_runstatus set onlinestatus =0 where w_ver_name = tver_name;
    dbms_output.put_line('��ʱ����: �Ϻ���Ϊ0,����');
  end if;
  commit;
end proc_station_timer_job;
