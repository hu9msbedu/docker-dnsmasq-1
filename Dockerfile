FROM ubuntu:12.04

RUN apt-get update
RUN apt-get install -q -y language-pack-en
RUN update-locale LANG=en_US.UTF-8

# Install dnsmasq
RUN apt-get install -q -y dnsmasq

# Pre-configure dnsmasq
RUN echo 'listen-address=__LOCAL_IP__' >> /etc/dnsmasq.conf
RUN echo 'resolv-file=/etc/resolv.dnsmasq.conf' >> /etc/dnsmasq.conf
RUN echo 'conf-dir=/etc/dnsmasq.d'  >> /etc/dnsmasq.conf
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf

# This directory will usually be provided with the -v option.
# RUN echo 'address=/example.com/xx.xx.xx.xx' >> /etc/dnsmasq.d/0hosts

# On the other hand the above directory isn't reloaded with a SIGHUP. Instead
# we can use an --addn-hosts file.

RUN touch /etc/addn-hosts
ADD run.sh /root/run.sh
ADD reload.sh /root/reload.sh

EXPOSE 22
EXPOSE 53

CMD /root/run.sh
