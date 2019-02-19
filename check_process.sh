#!/bin/sh

ConfFile="./conf/process.conf"
LogFile="./log/monitor_process.log"
i=0	
ProcessNums=`cat $ConfFile |grep processcount |cut -d "=" -f2`
while [ $i -le "$ProcessNums" ]
do
    ProcessName=`grep "^process$i=[Y,N]|" "$ConfFile" | cut -d'=' -f2 |cut -d'|' -f2`
    if [ "$ProcessName" != "" ]
    then
        echo "-------- $ProcessName ---------"
        ProcessState=`ps -e | grep "$ProcessName" |grep -v grep`
        if [ "$ProcessState" == "" ]
        then
            ProcessOpt=`grep "^process$i=[Y,N]|" "$ConfFile" | cut -d'=' -f2 |cut -d'|' -f1`
            if [ "$ProcessOpt" = "Y" ]
            then
                echo "WARNING ................................"
            fi
            echo "$ProcessName is not run ... (config set is $ProcessOpt)"
        else
            echo "`ps -ef | grep $ProcessName|grep -v grep`"
        fi
		echo "-------------------------------"
    fi
    i=$(($i+1))
done

