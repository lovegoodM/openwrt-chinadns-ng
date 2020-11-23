#!/bin/sh
. /etc/chinadns-ng/para.ini

killall chinadns-ng 2>/dev/null

ipset -F chnroute 2>/dev/null
ipset -F chnroute6 2>/dev/null
ipset -R -exist <chnroute.ipset
ipset -R -exist <chnroute6.ipset

/usr/bin/chinadns-ng $PARA &