# Bettercap Docker Container

This project provides a Dockerized version of [Bettercap](https://www.bettercap.org/), the powerful, modular and portable MITM framework.

## Prerequisites

- Docker installed
- Docker Compose installed
- Linux host (for full functionality)
- Root/sudo privileges (for network operations)

## Quick Start

1. Clone this repository or create the `docker-compose.yml` file
2. Create a directory for scripts and configs:
   ```bash
   mkdir -p bettercap-scripts
   ```
3. Start the container:
   ```bash
   docker-compose up -d
   ```
4. Attach to the running container:
   ```bash
   docker attach bettercap
   ```

## Configuration

### Volumes
- `./bettercap-scripts` is mounted to `/app/bettercap-scripts` inside the container for persistent storage

### Environment Variables
- `TZ` sets the timezone (default: UTC)

## Usage Examples

### Interactive Session
```bash
docker-compose run bettercap
```

### Running Specific Commands
```bash
docker-compose run bettercap -eval "net.recon on"
```

### Viewing Logs
```bash
docker-compose logs -f bettercap
```

## Security Considerations

⚠️ **Important Warning** ⚠️

- This container runs with elevated privileges (`NET_ADMIN`, `NET_RAW`)
- Bettercap is a powerful tool that can intercept network traffic
- Only use on networks you own or have permission to test
- Be aware of local laws regarding network monitoring

## Customization

To add your own scripts:
1. Place them in the `bettercap-scripts` directory
2. Access them at `/app/bettercap-scripts` in the container

## Troubleshooting

### Network Issues
- Use `network_mode: host` on Linux for full functionality
- macOS/Windows may have limited features

### Permission Issues
- Ensure Docker permissions
- May need `sudo` on Linux

## License

Provided as-is. Bettercap is licensed under GPL-3.0.

## Resources

- [Bettercap Docs](https://www.bettercap.org/)
- [GitHub Repo](https://github.com/bettercap/bettercap)
- [Docker Networking](https://docs.docker.com/network/)