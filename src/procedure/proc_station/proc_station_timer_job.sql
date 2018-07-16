create or replace procedure proc_station_timer_job is
   --自定义的版本信息,固定
   tver_name tb_runstatus.w_ver_name%type :='vHZ127.0.1';
   tcalccount tb_equipcalc.calccount%type;
begin
  --自定义的版本信息,固定
  --根据上号量,定时更新网络连接状态
  select count(*) into tcalccount from tb_equipcalc;
  
  if tcalccount > 0 then
     --更新
     update tb_runstatus set onlinestatus =1 where w_ver_name = tver_name;
     dbms_output.put_line('定时任务: 上号量不为0,上线');
  else
    update tb_runstatus set onlinestatus =0 where w_ver_name = tver_name;
    dbms_output.put_line('定时任务: 上号量为0,离线');
  end if;
  commit;
end proc_station_timer_job;
