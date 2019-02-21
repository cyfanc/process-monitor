#!/bin/sh

ConfFile="./conf/process.conf"
LogFile="./log/monitor_process.log"

while true
do
	ProcessNums=`cat $ConfFile |grep processcount |cut -d "=" -f2`
	i=1
	while [ $i -le "$ProcessNums" ]
	do
	    ProcessName=`grep "^process$i=Y|" "$ConfFile" | cut -d'=' -f2 |cut -d'|' -f2`
	   	if [ -n "$ProcessName" ]
	   	then
	   		ProcessState=`ps| grep "$ProcessName" |grep -v grep`
	   		if [ -z "$ProcessState" ]
	   		then
	   			ProcessRun=`grep "^process$i=Y|" "$ConfFile" | cut -d'|' -f3`
	   			echo $ProcessRun run ...
	   			echo "`date +%x%X`:$ProcessRun run ..." >>  $LogFile
	   			eval $ProcessRun &
	   		fi
	   	fi
	   	i=$(($i+1))
	done
	sleep 5
done
