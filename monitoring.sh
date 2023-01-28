#!/bin/bash

arc=$(uname -a)
pcpu=$(cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l)
vcpu=$(lscpu -e=CPU | sed '/CPU/d' | wc -l)
uram=$(free -m | sed -n '2p' | awk '{ print $3 }')
tram=$(free -m | awk '$1 == "Mem:" { print $2 }')

wall "	#Architecture: $arc
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $uram/${tram}MB
	"
