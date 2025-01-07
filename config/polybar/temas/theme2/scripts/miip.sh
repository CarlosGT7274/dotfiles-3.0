#!/bin/sh

echo "%{T2}%{F#2495e7}%{F#2495e7}%{T-} $(/usr/sbin/ifconfig enp9s0 | grep "inet " | awk '{print $2}')%{F-}"
#
