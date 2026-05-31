# dnscrypt-proxy Docker Image

A lightweight Docker image for running **dnscrypt-proxy**, a flexible DNS proxy that supports DNSCrypt, DNS-over-HTTPS (DoH), DNS-over-TLS (DoT), and anonymized DNS.

## Features

- Lightweight container image
- Secure encrypted DNS resolution
- Custom `dnscrypt-proxy.toml` configuration support
- Persistent configuration via Docker volumes
- Compatible with Docker and Docker Compose
- Suitable for home labs, servers, and self-hosted environments

## Requirements

- Docker 20.10 or newer
- Docker Compose (optional)

## Quick Start

### Docker

```bash
docker run -d \
  --name dnscrypt-proxy \
  -p 53:53/tcp \
  -p 53:53/udp \
  -v $(pwd)/config:/config \
  --restart unless-stopped \
  yourusername/dnscrypt-proxy:latest
```

### Docker Compose

```yaml
services:
  dnscrypt-proxy:
    image: yourusername/dnscrypt-proxy:latest
    container_name: dnscrypt-proxy
    restart: unless-stopped
    ports:
      - "53:53/tcp"
      - "53:53/udp"
    volumes:
      - ./config:/config
```

## Configuration

Mount a custom `dnscrypt-proxy.toml` configuration file into the container.

Example configuration:

```toml
server_names = ['cloudflare']
listen_addresses = ['0.0.0.0:53']
```

## Volumes

| Path | Description |
|------|-------------|
| `/config` | dnscrypt-proxy configuration files |
| `/var/log/dnscrypt-proxy` | Optional log storage |

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `TZ` | UTC | Container timezone |

## Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 53 | TCP | DNS queries |
| 53 | UDP | DNS queries |

## Updating

Pull the latest image and recreate the container:

```bash
docker pull yourusername/dnscrypt-proxy:latest
docker compose up -d
```

## Testing

Verify DNS resolution:

```bash
dig @127.0.0.1 example.com
```

Or:

```bash
nslookup example.com 127.0.0.1
```

## Security Notes

- Restrict access to trusted networks.
- Keep dnscrypt-proxy updated to the latest version.
- Review your resolver and privacy settings regularly.
- Consider running behind a firewall for additional protection.

## Troubleshooting

View container logs:

```bash
docker logs dnscrypt-proxy
```

Open a shell inside the container:

```bash
docker exec -it dnscrypt-proxy sh
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.