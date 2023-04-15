ARG PIHOLE_VERSION=latest
FROM pihole/pihole:${PIHOLE_VERSION}
RUN apt update && apt upgrade -y && apt install -y unbound

COPY etc/lighttpd/external.conf /etc/lighttpd/external.conf
COPY etc/unbound/unbound.conf.d/pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY etc/dnsmasq.d/99-edns.conf /etc/dnsmasq.d/99-edns.conf

RUN mkdir -p /etc/services.d/unbound
COPY config/unbound/run /etc/services.d/unbound/run
RUN chmod a+xwr /etc/services.d/unbound/run

ENTRYPOINT ./s6-init
