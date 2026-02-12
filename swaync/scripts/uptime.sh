#!/usr/bin/env bash

uptime_str=$(uptime -p | sed 's/up //')
echo "󱘖 Uptime $uptime_str"
