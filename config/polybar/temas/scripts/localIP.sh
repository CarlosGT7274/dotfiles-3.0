#!/usr/bin/env bash

echo "$(/usr/sbin/ifconfig enp9s0 | grep "inet " | awk '{print $2}')"
