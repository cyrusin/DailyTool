#!/bin/bash

cd /proc

for pid in [0-9]*;do
    command=$(cat /proc/$pid/cmdline)
    if [ ${#command} -gt 100 ];then
        command=${command:0:99}
    fi
    swap=$(
        awk '
            BEGIN {total=0}
            /Swap/ {total+=$2}
            END {print total}
        ' /proc/$pid/smaps
    )

    if [ $swap -gt 0 ];then
        if [ "${head}" != "yes" ];then
            echo -e "PID\tCOMMAND\tSwap"
        head="yes"
        fi
        echo -e "$pid\t$command\t$swap"
    fi
done

