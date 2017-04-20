FROM ubuntu:16.10

RUN apt-get update && apt-get upgrade -y && apt-get install iptables iproute2 ipset curl squid shadowsocks-libev -y

ADD run.sh /
ADD set-iptables.sh /

RUN chmod +x /run.sh
RUN chmod +x /set-iptables.sh

ENV LOCAL_PORT 55555
EXPOSE 3128

ENTRYPOINT ["/run.sh"]