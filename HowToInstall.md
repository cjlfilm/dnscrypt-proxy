# Rootless DNS setup with Podman (port 53)

## 1. Allow rootless binding to port 53
```bash
echo "net.ipv4.ip_unprivileged_port_start=53" | sudo tee /etc/sysctl.d/99-rootless-ports.conf
sudo sysctl --system
```

## 2. Disable systemd-resolved DNS stub
```bash
sudo mkdir -p /etc/systemd/resolved.conf.d
sudo vi /etc/systemd/resolved.conf.d/dns.conf
```

Add:
```ini
[Resolve]
DNSStubListener=no
```

## 3. Restart DNS service
```bash
sudo systemctl daemon-reload
sudo systemctl restart systemd-resolved
```

## 4. Build container
```bash
podman build -t dnscrypt-proxy .
```

## 5. Run container on port 53
```bash
podman run -d --rm -p 53:53/tcp -p 53:53/udp localhost/dnscrypt-proxy
```

## 6. Test DNS
```bash
dig @127.0.0.1 -p 53 www.google.com
```

## 7. Run as a service
Put the service file in the users systemd directory
```bash
~/.config/systemd/user/container-dnscrypt-proxy.service
```
Then reload the user systemd daemon
```bash
systemctl --user daemon-reload
```
Enable linger so it can run without login session
```bash
loginctl enable-linger $USER
```
