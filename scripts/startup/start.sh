#!/bin/bash
# Startup script

dbus-monitor --session "type='signal',interface='org.freedesktop.ScreenSaver'" | \
while read x; do
  case "$x" in 
    *"boolean true"*) systemctl --user stop active_miner.service; systemctl --user start idle_miner.service ;;
    *"boolean false"*) systemctl --user stop idle_miner.service; systemctl --user start active_miner.service ;;
  esac
done
