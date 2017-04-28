FROM ubuntu:16.10

RUN apt-get update && apt-get upgrade -y && apt-get install iptables ipset curl squid shadowsocks-libev -y

ADD run.sh /root/
ADD set-iptables.sh /root/
ADD squid.conf /root/
ADD chnroute.txt /root/

RUN chmod +x /root/run.sh
RUN chmod +x /root/set-iptables.sh

ENV LOCAL_PORT 55555
ENV UPDATE_IP_RANGE 0
EXPOSE 3128

ENTRYPOINT ["/root/run.sh"]