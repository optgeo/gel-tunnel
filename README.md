# gel-tunnel

This project provides a solution for serving large map tile files (`gel.pmtiles`) locally using a Raspberry Pi and Cloudflare Tunnel. The approach improves map tile loading speed and reliability.

## Purpose
This project aims to serve large map tile files (`gel.pmtiles`) locally using a Raspberry Pi and Cloudflare Tunnel. The approach improves map tile loading speed and reliability.

## Security Considerations
- Ensure sensitive keys (e.g., Cloudflare Tunnel credentials) are not stored in the repository.
- Use environment variables or secure storage for keys.

### Enabling Cloudflare Tunnel
1. Install `cloudflared`:
   ```bash
   curl -fsSL https://pkg.cloudflare.com/cloudflared.asc | sudo tee /etc/apt/trusted.gpg.d/cloudflared.asc
   echo "deb [signed-by=/etc/apt/trusted.gpg.d/cloudflared.asc] https://pkg.cloudflare.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflared.list
   sudo apt update
   sudo apt install cloudflared
   ```
2. Authenticate and configure the tunnel:
   ```bash
   cloudflared tunnel login
cloudflared tunnel create gel-tunnel
cloudflared tunnel route dns gel-tunnel tunnel.optgeo.org
   ```
3. Run the tunnel:
   ```bash
   cloudflared tunnel run gel-tunnel
   ```

## Features
- Downloads `gel.pmtiles` from Source Cooperative.
- Serves `gel.pmtiles` locally via Cloudflare Tunnel.
- Includes Makefile tasks for managing the file.

## Usage

### Prerequisites
- Ensure sufficient disk space (at least 182 GB).
- Install `curl` for downloading files.

### Makefile Tasks
- `make download`: Downloads `gel.pmtiles` to the `data` folder, with support for resuming interrupted downloads.
- `make verify`: Verifies the integrity of `gel.pmtiles` using `go-pmtiles`.
- `make clean`: Removes the downloaded `gel.pmtiles` file.

### Future Plans
- Set up Cloudflare Tunnel on Raspberry Pi OS.
- Serve `gel.pmtiles` locally.

## Folder Structure
- `data/`: Contains the downloaded `gel.pmtiles` file.
- `.gitignore`: Ensures only necessary files are tracked.
- `Makefile`: Automates download and cleanup tasks.

## License
This project is licensed under the CC0 1.0 Universal (Public Domain Dedication).

## Hosting with Martin

Martin can host PMTiles files locally. To host a file, use the following command:

```bash
martin <path-to-pmtiles>
```

For example:

```bash
martin data/a.pmtiles
```

This will start Martin on `http://0.0.0.0:3000`. You can access the catalog at `http://0.0.0.0:3000/catalog`.

## Cloudflare Tunnel Setup

To expose the local Martin server to the internet, use Cloudflare Tunnel:

```bash
cloudflared tunnel run --url http://localhost:3000
```

This will create a secure tunnel to your local server.
