# Technical Documentation

## gel.pmtiles
`gel.pmtiles` is a large map tile file (182 GB) provided by Source Cooperative. It is used for rendering maps efficiently.

### Verification
The `verify` task in the Makefile uses `go-pmtiles` to check the integrity of `gel.pmtiles`. This ensures the file is complete and valid for serving.

### Downloading
The `download` task supports resuming interrupted downloads using the `-C -` option in `curl`. The Makefile automates this process.

### Storage
The file is stored in the `data/` folder. A `.gitkeep` file ensures the folder is tracked in version control.

### Cleanup
The `clean` task in the Makefile removes the file when no longer needed.

## Cloudflare Tunnel
Cloudflare Tunnel will be used to serve `gel.pmtiles` from a Raspberry Pi. This setup ensures fast and reliable access to map tiles.

### Setup Steps
1. Install `cloudflared` on Raspberry Pi OS.
2. Configure the tunnel to point to the local server hosting `gel.pmtiles`.
3. Test the setup to ensure accessibility.

### Installing Rustup and Martin

#### Rustup Installation
1. Run the following command to install Rustup:
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```
2. Restart your shell or run:
   ```bash
   source $HOME/.cargo/env
   ```

#### Martin Installation
1. Ensure Rust and Cargo are installed.
2. Install Martin using Cargo:
   ```bash
   cargo install martin
   ```

## Setting Up Cloudflare Tunnel

Follow these steps to set up a Cloudflare Tunnel for exposing the local Martin server:

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

## Recreating the Tunnel and Configuring Ingress Rules

If the credentials file is missing, follow these steps to recreate the tunnel and configure ingress rules:

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

## Notes
- Ensure the Raspberry Pi has sufficient resources for hosting the file.
- Monitor network bandwidth during file download and serving.

## Future Enhancements
- Automate Cloudflare Tunnel setup and management.
- Implement monitoring and alerting for tunnel status.