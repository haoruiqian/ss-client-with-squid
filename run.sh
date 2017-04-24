#!/bin/bash

/root/set-iptables.sh
/usr/sbin/squid -d WARN -f /root/squid.conf

cmd="/usr/bin/ss-redir -u -s $SERVER -p $SERVER_PORT -l $LOCAL_PORT -m $ENCRYPT_METHOD -k $PASSWORD -b 0.0.0.0";

exec $cmd;