#!/usr/bin/env bash

#echo "$(/usr/sbin/ifconfig enp9s0 | grep "inet " | awk '{print $2}')"

echo "%{T0}$(/usr/sbin/ip addr | grep /24 | awk '{print $2}' | sed 's/\/24$//')%{T-}"
