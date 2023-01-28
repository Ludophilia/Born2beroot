#!/bin/bash

arc=$(uname -a)
pcpu=$(cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l)
vcpu=$(lscpu -e=CPU | sed '/CPU/d' | wc -l)
ram=$(free -m | awk '/^Mem/ { printf "%s/%sMB (%.2f%%)", $3, $2, $3*100/$2 }')
disk=$(df -Bm | grep -v /boot$ | awk '/^\/dev/ { ut+=$3 ; tt+=$2 } \
	END { printf "%s/%dGb (%.0f%%)", ut, tt/1024, ut*100/tt }')

wall "	#Architecture: $arc
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $ram
	#Disk Usage: $disk
     "
