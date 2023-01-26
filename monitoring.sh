#!/bin/bash

wall "	#Architecture: $(uname -a)
		#CPU physical: $()
		#vCPU: $(lscpu -e=CPU | sed '/CPU/d' | wc -l)
    "
