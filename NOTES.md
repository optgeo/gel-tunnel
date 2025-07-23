# Technical Documentation

## gel.pmtiles
`gel.pmtiles` is a large map tile file (182 GB) provided by Source Cooperative. It is used for rendering maps efficiently.

### Downloading
The file is downloaded using `curl` with automatic retry enabled. The Makefile automates this process.

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

## Notes
- Ensure the Raspberry Pi has sufficient resources for hosting the file.
- Monitor network bandwidth during file download and serving.

## Future Enhancements
- Automate Cloudflare Tunnel setup.
- Optimize Raspberry Pi performance for serving large files.
