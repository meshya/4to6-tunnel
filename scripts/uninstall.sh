#!/bin/bash

if [ "$UID" -ne 0 ]; then
    echo "Use sudo bro"
    exit 0
fi

systemctl disable --now 4to6tunnel
rm -f /usr/bin/4to6tunnelstart
rm -f /usr/bin/4to6tunnelstop
rm -f /etc/systemd/system/4to6tunnel.service
rm -f /etc/4to6tunnel/conf.sh
systemctl daemon-reload