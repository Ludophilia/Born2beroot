#!/bin/bash

arc=$(uname -a)
pcpu=$(cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l)
vcpu=$(lscpu -e=CPU | sed '/CPU/d' | wc -l)
ram=$(free -m | awk '/^Mem/ { printf "%s/%sMB (%.2f%%)", $3, $2, $3*100/$2 }')
disk=$(df -Bm | grep -v /boot$ | awk '/^\/dev/ { ut+=$3 ; tt+=$2 } \
	END { printf "%s/%iGb (%.0f%%)", ut, tt/1024, ut*100/tt }')
cpul=$(top -bn1 | awk -F ',' '/^%Cpu/ { printf "%.1f%%", 100-$4 }')
lb=$(who -b | awk '{ print $3, $4 }')
lvm=$(/usr/sbin/lvs -o active | awk '/active/ { ac += 1 } END { if (ac == 7) \
	{ print "yes" } else { print "no"} }')
tcp=$(ss -tp | grep ESTAB | wc -l | xargs -I. echo . ESTABLISHED)
usrs=$(who -u | wc -l)
ip=$(ip -o -4 addr | awk '/^2/ { print "IP", $4 }')
mac=$(ip link | awk '/ether/ { printf "(%s)", $2 }')
sudo=$(grep -c "COMMAND" /var/log/sudo/sudo.log | xargs -I. echo . cmd)

wall "	#Architecture: $arc
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $ram
	#Disk Usage: $disk
	#CPU Load: $cpul
	#Last boot: $lb
	#LVM use: $lvm
	#Connections TCP: $tcp
	#User log: $usrs
	#Network: ${ip%/*} $mac
	#Sudo: $sudo 
    "
