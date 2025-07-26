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

## Updated Makefile Tasks

The Makefile now includes tasks for managing both `gel.pmtiles` and `optimal_bvmap-v1.pmtiles`. Below are the updated tasks:

### Managing gel.pmtiles
- **Download**: `make download`
- **Verify**: `make verify`
- **Clean**: `make clean`

### Managing optimal_bvmap-v1.pmtiles
- **Download**: `make download-optimal`
- **Verify**: `make verify-optimal`
- **Clean**: `make clean-optimal`

These tasks allow for easy management of both PMTiles files.

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

### Setting Up Cloudflare Tunnel

To set up a Cloudflare Tunnel for exposing the local Martin server:

1. Authenticate with Cloudflare:
   ```bash
   cloudflared tunnel login
   ```
   This will open a browser window for authentication.

2. Create the Tunnel:
   ```bash
   cloudflared tunnel create gel-tunnel
   ```

3. Route DNS to the Tunnel:
   ```bash
   cloudflared tunnel route dns gel-tunnel tunnel.optgeo.org
   ```

4. Run the Tunnel:
   ```bash
   cloudflared tunnel run gel-tunnel
   ```

Once the tunnel is running, it will securely expose your local Martin server to the internet.

### Recreating the Tunnel and Configuring Ingress Rules

If the credentials file is missing, recreate the tunnel and configure ingress rules:

1. Recreate the Tunnel:
   ```bash
   cloudflared tunnel create gel-tunnel
   ```
   This will generate the credentials file at `~/.cloudflared/gel-tunnel.json`.

2. Verify the Credentials File:
   ```bash
   ls ~/.cloudflared/gel-tunnel.json
   ```

3. Create a Configuration File:
   Save the following content as `~/.cloudflared/config.yml`:
   ```yaml
   tunnel: gel-tunnel
   credentials-file: ~/.cloudflared/gel-tunnel.json
   ingress:
     - hostname: tunnel.optgeo.org
       service: http://localhost:8080
     - service: http_status:404
   ```

4. Run the Tunnel:
   ```bash
   cloudflared tunnel run gel-tunnel
   ```

This setup ensures proper routing of incoming requests to your local Martin server.

## Managing optimal_bvmap-v1.pmtiles

### Download
To download `optimal_bvmap-v1.pmtiles`, run:
```bash
make download-optimal
```

### Verify
To verify the integrity of `optimal_bvmap-v1.pmtiles`, run:
```bash
make verify-optimal
```

### Clean
To remove `optimal_bvmap-v1.pmtiles`, run:
```bash
make clean-optimal
```

These tasks are included in the Makefile for easy management of the file.
