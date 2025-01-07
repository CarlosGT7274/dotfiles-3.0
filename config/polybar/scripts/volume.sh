#!/bin/bash

volume=$(pamixer --get-volume-human | tr -d '%')
#[[ $volume == 'muted' ]] && echo "0" || echo "${volume}"

bars=10
bar_length=$((volume * bars / 100))

fill_char="#"
empty_char="."

progress_bar=$(printf "%${bar_length}s" | tr ' ' "$fill_char")
empty_bar=$(printf "%$((bars - bar_length))s" | tr ' ' "$empty_char")

#echo "${progress_bar}${empty_bar}"
echo $progress_bar
