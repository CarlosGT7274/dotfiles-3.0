#!/bin/bash

wifi_status=$(nmcli device status | grep wifi | awk '{print $3}')
ethernet_status=$(nmcli device status | grep ethernet | awk '{print $3}' | head -n1)

if [ "$wifi_status" == "conectado" ]; then
  interface=$(nmcli device status | grep wifi | awk '{print $1}'| head -n1 )
  icon="󰖩 "
elif [ "$ethernet_status" == "conectado" ]; then
  interface=$(nmcli device status | grep ethernet | awk '{print $1}' | head -n1 )
  icon="󰈁"
else
  interface="Disconnected"
  icon="󰌙 "
fi

echo "$icon$interface"
