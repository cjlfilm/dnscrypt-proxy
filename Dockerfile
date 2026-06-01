FROM fedora:42
RUN dnf update && dnf install dnscrypt-proxy -y && dnf clean all
COPY dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml
EXPOSE 53/udp
EXPOSE 53/tcp
CMD ["/usr/bin/dnscrypt-proxy", "-config", "/etc/dnscrypt-proxy/dnscrypt-proxy.toml", "-loglevel", "verbose", "&"]