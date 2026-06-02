FROM fedora:42

RUN dnf -y install dnscrypt-proxy && \
    mkdir -p /var/cache/dnscrypt-proxy && \
    dnf clean all

COPY dnscrypt-proxy.toml /etc/dnscrypt-proxy/dnscrypt-proxy.toml

EXPOSE 53/tcp
EXPOSE 53/udp

ENTRYPOINT ["dnscrypt-proxy"]
CMD ["-config", "/etc/dnscrypt-proxy/dnscrypt-proxy.toml", "-loglevel", "verbose"]