# process-monitor
进程监控

#启动
sh run.sh

#停止
sh kill.sh

#检查进程启动状况
sh check_process.sh

#添加监控进程
配置文件conf/process.conf
监控进程数量
processcount=2
进程编号=Y监控N不监控|进程名|启动进程
process1=Y|test1|./test1&
process2=Y|test2|./test2&
