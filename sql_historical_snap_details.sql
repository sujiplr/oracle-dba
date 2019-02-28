	   select b.sql_id, b.plan_hash_value,begin_interval_time, sum(executions_delta) execs, 
	  sum(elapsed_time_delta)/sum(executions_delta)/1000000 elaps_per_exec,
	  sum(cpu_time_delta)/sum(executions_delta)/1000000 cpu_per_exec, 
	  sum(rows_processed_delta)/sum(executions_delta) rows_per_exec,
	  sum(disk_reads_delta)/sum(executions_delta) reads_per_exec, 
	  sum(buffer_gets_delta)/sum(executions_delta) gets_per_exec,
	  sum(IOWAIT_DELTA)/sum(executions_delta)/1000000 iowaits_per_Exec
	 from dba_hist_snapshot a, dba_hist_sqlstat b 
	 where a.snap_id=b.snap_id and b.sql_id='&sqlid'
	 and executions_delta>0 and a.instance_number=b.instance_number
	 group by b.snap_id, b.sql_id, b.plan_hash_value,begin_interval_time,OPTIMIZER_MODE,b.INSTANCE_NUMBER order by 3;
