--վ����Ϣ��ʼ���洢����,�������Ϊ�豸id

create or replace procedure proc_station_init
(
    tEquipid in tb_equipment.equipid%type
)
is
--�����м����
    tstamp integer :=(sysdate - to_date('1970-1-1 8','YYYY-MM-DD HH24'))*86400;
    tequcatalog tb_equipment.equcatalog%type;
    tsystem tb_equipment.system%type;
    tmnc    tb_equConf.mnc%type;
  
    t_count number(2);
    tequstatus1 tb_runstatus.equstatus%type :=tstamp||','||tstamp||',5,1,1,1,-1,23,-7,1.3,40,0,0,0,0,0,0'; 
    
begin
  --1.���������equId,��ѯtb_equipment,��spcode,system
  --1���ȵ㡢2������վ��3�����ڡ�4������վ�㡢5������ͷ��6����ȫ�š�7��A-WIFI��8��WIFI
  select equcatalog into tequcatalog from tb_equipment where equipid = tEquipid;
  --system��1��GSM��2��WCDMA��3��TDCDMA��4��CDMA��5��TD-LTE��6��FDD-LTE��7��΢�ȵ�WIFIģ�飻8��������;9:ȫ��ʽ��
  select system into tsystem from tb_equipment where equipid = tEquipid;
  
  --2.����tb_equipment��ʱ��
  update tb_equipment set lauchtime = sysdate where equipid = tEquipid;
  update tb_equipment set updatetime = sysdate where equipid = tEquipid;
  
  --3.�ȸ���equcatalog�ж��豸����,����wifi�ٸ�����Ӫ�̺���ʽ,�ж��豸����,�����豸��������(update),��ʼ������״̬(insert)
  if tequcatalog = 1 then
     --�ȵ�
   if tsystem = 1 then
       --GSM
       --mnc,0:�ƶ�,1:��ͨ
    select mnc into tmnc from tb_equconf where equid = tEquipid;
      if tmnc = 0 then
          --�ƶ�
          --��ʼ���豸����
          update tb_equConf set updatetime=sysdate,power=4,code=10,lac=225,lacinctime=120,freqstatus=1,
          acstatus=1,runstate=1,listmode=0,frequency=35,insertdate=sysdate where equid =tEquipid;
          
          --��ʼ���豸����״̬
          select count(*) into t_count from tb_runstatus where equipid = tEquipid;
          if t_count >0 then
              --����
              update tb_runstatus set updatetime=sysdate,cpurate=10,ramrate=12,sdrate=8,temperature=40,powerstatus=1,
              simstatus=0,wifistatus=0,freqstatus=1,acstatus=1,att=1,acvalue=23,gpstime=sysdate,gpsstatus='A',
              longitude=0,latitude=0,ipaddr=null,commodip=null,lac=225,armver=null,fpgver=null,picochipver=null,
              onlinestatus=1,c_workmode=0,c_capturestat=0,c_activemode=0,c_frequency=null,c_equtime=sysdate,
              csub_txpower=0,csub_txpowerlose=0,csub_cpurate=0,csub_ramrate=0,csub_devstat=0,csub_workmode=0,csub_pn=0,
              c_alternativepn=null,c_alternativepntime=null,w_ac_tempr=0,w_sw_status=0,w_ap_connect=0,w_ac_input=0,
              w_nand=0,w_alarm='0|0|0|0',w_ver_name='vHZ127.0.1',w_wdcb_type=null,w_board_type=null,
              l_ant_state=1,l_enb_link_state=1,l_enb_tempr=40,l_enb_power_state=1,l_cell_state=null,l_base_info=null,
              equstatus=tequstatus1,l_four_sync_info=null,g_six_power=null,
              g_six_freqstatus=null,sz_plmn=null,sz_ccapture_stat=null where equipid = tEquipid;
              
              dbms_output.put_line('success: ����GSM�ƶ�');
          else
            --����
            insert into tb_runstatus
            values(tEquipid,sysdate,10,12,8,40,1,
            0,0,1,1,1,23,sysdate,'A',
            0,0,null,null,225,null,null,null,
            1,0,0,0,null,sysdate,
            0,0,0,0,0,0,0,
            null,null,0,0,0,0,
            0,'0|0|0|0','vHZ127.0.1',null,null,
            1,1,40,1,null,null,
            tequstatus1,null,null,
            null,null,null);
            
            dbms_output.put_line('success: ����GSM�ƶ�');
          end if;
      elsif tmnc = 1 then
          --��ͨ
          update tb_equConf set updatetime=sysdate,power=4,code=10,lac=301,lacinctime=120,freqstatus=1,
          acstatus=1,runstate=1,listmode=0,frequency=111,insertdate=sysdate where equid =tEquipid;
          
          select count(*) into t_count from tb_runstatus where equipid = tEquipid;
          if t_count >0 then
              --����
              update tb_runstatus set updatetime=sysdate,cpurate=10,ramrate=12,sdrate=8,temperature=40,powerstatus=1,
              simstatus=0,wifistatus=0,freqstatus=1,acstatus=1,att=1,acvalue=23,gpstime=sysdate,gpsstatus='A',
              longitude=0,latitude=0,ipaddr=null,commodip=null,lac=301,armver=null,fpgver=null,picochipver=null,
              onlinestatus=1,c_workmode=0,c_capturestat=0,c_activemode=0,c_frequency=null,c_equtime=sysdate,
              csub_txpower=0,csub_txpowerlose=0,csub_cpurate=0,csub_ramrate=0,csub_devstat=0,csub_workmode=0,csub_pn=0,
              c_alternativepn=null,c_alternativepntime=null,w_ac_tempr=0,w_sw_status=0,w_ap_connect=0,w_ac_input=0,
              w_nand=0,w_alarm='0|0|0|0',w_ver_name='vHZ127.0.1',w_wdcb_type=null,w_board_type=null,
              l_ant_state=1,l_enb_link_state=1,l_enb_tempr=40,l_enb_power_state=1,l_cell_state=null,l_base_info=null,
              equstatus=tequstatus1,l_four_sync_info=null,g_six_power=null,
              g_six_freqstatus=null,sz_plmn=null,sz_ccapture_stat=null where equipid = tEquipid;
              
              dbms_output.put_line('success: ����GSM��ͨ');
          else
            --����
            insert into tb_runstatus
            values(tEquipid,sysdate,10,12,8,40,1,
            0,0,1,1,1,23,sysdate,'A',
            0,0,null,null,301,null,null,null,
            1,0,0,0,null,sysdate,
            0,0,0,0,0,0,0,
            null,null,0,0,0,0,
            0,'0|0|0|0','vHZ127.0.1',null,null,
            1,1,40,1,null,null,
            tequstatus1,null,null,
            null,null,null);
            
            dbms_output.put_line('success: ����GSM��ͨ');
          end if;
      else
          --error
          dbms_output.put_line('error: GSM��������');
      end if;
  elsif tsystem = 9 then
  --4G
      update tb_equConf set updatetime=sysdate,power=4,code=10,lac=null,lacinctime=null,freqstatus=1,
          acstatus=1,runstate=1,sonenable=0,insertdate=sysdate,
          l_cellinfo='0|39292|55|1050|1800|40|0|4|10|460;1|575|110|555|1800|1|1|4|10|460;2|575|110|555|1800|3|11|4|10|460',
          sz_lcellinfo='1,0|2|0|0?599?1;600?1199?2;1200?1949?3;2750?3449?7;37750?38249?38;38250?38649?39;38650?39649?40;39650?41589?41|40|1,
          1|2|1|0?599?1;600?1199?2;1200?1949?3;2750?3449?7;37750?38249?38;38250?38649?39;38650?39649?40;39650?41589?41|1|0,
          2|2|1|0?599?1;600?1199?2;1200?1949?3;2750?3449?7;37750?38249?38;38250?38649?39;38650?39649?40;39650?41589?41|3|0'
           where equid =tEquipid;
           
      --��������״̬
      select count(*) into t_count from tb_runstatus where equipid = tEquipid;
          if t_count >0 then
              --����
              update tb_runstatus set updatetime=sysdate,cpurate=10,ramrate=12,sdrate=8,temperature=40,powerstatus=1,
              simstatus=1,wifistatus=0,freqstatus=0,acstatus=0,att=0,acvalue=0,gpstime=sysdate,gpsstatus='A',
              longitude=0,latitude=0,ipaddr=null,commodip=null,lac=555,armver=null,fpgver=null,picochipver=null,
              onlinestatus=1,c_workmode=0,c_capturestat=1,c_activemode=0,c_frequency=null,c_equtime=sysdate,
              csub_txpower=0,csub_txpowerlose=0,csub_cpurate=0,csub_ramrate=0,csub_devstat=0,csub_workmode=0,csub_pn=0,
              c_alternativepn=null,c_alternativepntime=null,w_ac_tempr=0,w_sw_status=0,w_ap_connect=0,w_ac_input=0,
              w_nand=0,w_alarm='0|0|0|0',w_ver_name='vHZ127.0.1',w_wdcb_type=null,w_board_type=null,
              l_ant_state=1,l_enb_link_state=1,l_enb_tempr=40,l_enb_power_state=1,
              l_cell_state='0|1|1|0|43|45|18-0|1|1;1|1|1|0|-100|45|-100-0|1|1;2|1|1|0|-100|45|-100-0|1|1',
              l_base_info='3,0|2300|2400|1|0;1|2110|2170|4|1;2|1805|1880|3|1',
              equstatus=null,l_four_sync_info=null,g_six_power=null,g_six_freqstatus=null,
              sz_plmn='0|0;1|0;2|0',sz_ccapture_stat='0|1;1|1;2|1' where equipid = tEquipid;
              
              dbms_output.put_line('success: ����4Gȫ��ʽ');
          else
            --����
            insert into tb_runstatus
            values(tEquipid,sysdate,10,12,8,40,1,
            1,0,0,0,0,0,sysdate,'A',
            0,0,null,null,555,null,null,null,
            1,0,1,0,null,sysdate,
            0,0,0,0,0,0,0,
            null,null,0,0,0,0,
            0,'0|0|0|0','vHZ127.0.1',null,null,
            1,1,40,1,
            '0|1|1|0|43|45|18-0|1|1;1|1|1|0|-100|45|-100-0|1|1;2|1|1|0|-100|45|-100-0|1|1',
            '3,0|2300|2400|1|0;1|2110|2170|4|1;2|1805|1880|3|1',
            null,null,null,null,
            '0|0;1|0;2|0','0|1;1|1;2|1');
            
            dbms_output.put_line('success: ����4Gȫ��ʽ');
          end if;     
  else
    --error
    dbms_output.put_line('error: ���systemδ֪: '||tsystem);
  end if;    
  elsif tequcatalog = 8 then
     --wifi
     --�����豸����,wifiû��������Ϣ
      --update tb_equConf set updatetime=sysdate,power=4,freqstatus=1,
      --    acstatus=1,runstate=1,insertdate=sysdate where equid =tEquipid;
      
      --��������״̬
      select count(*) into t_count from tb_runstatus where equipid = tEquipid;
          if t_count >0 then
              --����
              update tb_runstatus set updatetime=sysdate,cpurate=10,ramrate=12,sdrate=8,temperature=40,powerstatus=1,
              simstatus=0,wifistatus=0,freqstatus=0,acstatus=0,att=0,acvalue=0,gpstime=sysdate,gpsstatus='A',
              longitude=0,latitude=0,ipaddr=null,commodip=null,lac=null,armver=null,fpgver=null,picochipver=null,
              onlinestatus=1,c_workmode=0,c_capturestat=0,c_activemode=0,c_frequency=null,c_equtime=sysdate,
              csub_txpower=0,csub_txpowerlose=0,csub_cpurate=0,csub_ramrate=0,csub_devstat=0,csub_workmode=0,csub_pn=0,
              c_alternativepn=null,c_alternativepntime=null,w_ac_tempr=0,w_sw_status=0,w_ap_connect=0,w_ac_input=0,
              w_nand=0,w_alarm='0|0|0|0',w_ver_name='vHZ127.0.1',w_wdcb_type=null,w_board_type=null,
              l_ant_state=1,l_enb_link_state=1,l_enb_tempr=40,l_enb_power_state=1,l_cell_state=null,l_base_info=null,
              equstatus=null,l_four_sync_info=null,g_six_power=null,
              g_six_freqstatus=null,sz_plmn=null,sz_ccapture_stat=null where equipid = tEquipid;
              
              dbms_output.put_line('success: ����WiFi');
          else
            --����
            insert into tb_runstatus
            values(tEquipid,sysdate,10,12,8,40,1,
            0,0,0,0,0,0,sysdate,'A',
            0,0,null,null,null,null,null,null,
            1,0,0,0,null,sysdate,
            0,0,0,0,0,0,0,
            null,null,0,0,0,0,
            0,'0|0|0|0','vHZ127.0.1',null,null,
            1,1,40,1,null,null,
            null,null,null,
            null,null,null);
            
            dbms_output.put_line('success: ����WiFi');
          end if;
  else
    --error
    dbms_output.put_line('error: ���equcatalogδ֪: '||tequcatalog);
  end if;
  commit;
end proc_station_init;
