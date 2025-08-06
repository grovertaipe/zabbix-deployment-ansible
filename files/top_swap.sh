#!/bin/bash
# Name: monitor_swap_usage.sh
#echo -e "PID\tNombre\tSwap (MB)"
for pid in $(ls /proc | grep '^[0-9]' | head -n 10000); do
  if [ -r /proc/$pid/status ]; then
    swap=$(grep VmSwap /proc/$pid/status | awk '{print $2}')
    name=$(grep Name /proc/$pid/status | awk '{print $2}')
    if [ ! -z "$swap" ] && [ "$swap" -gt 0 ]; then
      echo -e "$pid\t$name\t$((swap / 1024))"
    fi
  fi
done | sort -k3 -nr | head -n 5
