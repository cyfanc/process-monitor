#!/bin/sh
EXEC_NAME=monitor_process.sh

killall -9 $EXEC_NAME

ConfFile="./conf/process.conf"
LogFile="./log/monitor_process.log"

ProcessNums=`cat $ConfFile |grep processcount |cut -d "=" -f2`
i=0
while [ $i -lt "$ProcessNums" ]
do
	ProcessName=`grep "^proc$ProcessNums=Y|" "$ConfFile" | cut -d'=' -f2 |cut -d'|' -f2`
	if [ -n "$ProcessName" ]
	then
	    	echo "killall -9 "$ProcessName
	    echo "`date +%x%X`:kill $ProcessName" >>  $LogFile	
		killall -9 "$ProcessName"
	fi
	ProcessNums=$(($ProcessNums-1))
done
