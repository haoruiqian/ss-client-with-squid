#!/bin/sh

cd /root

echo "Download IP addresses of China"
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > chnroute.txt

# Setup the ipset
ipset -N chnroute hash:net maxelem 65536;

for ip in $(cat '/root/chnroute.txt'); do
  ipset add chnroute $ip
done
echo "Setup iptables"
# Setup iptables
iptables -t nat -N SHADOWSOCKS

# Allow connection to the server
iptables -t nat -A SHADOWSOCKS -d $SERVER -j RETURN

# Allow connection to reserved networks
iptables -t nat -A SHADOWSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 240.0.0.0/4 -j RETURN

# Allow connection to chinese IPs
iptables -t nat -A SHADOWSOCKS -p tcp -m set --match-set chnroute dst -j RETURN

# Redirect to Shadowsocks
iptables -t nat -A SHADOWSOCKS -p tcp -j REDIRECT --to-port $LOCAL_PORT

# Redirect to SHADOWSOCKS
iptables -t nat -A OUTPUT -p tcp -j SHADOWSOCKS

exit 0