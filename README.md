# gel-tunnel

This project provides a solution for serving large map tile files (`gel.pmtiles`) locally using a Raspberry Pi and Cloudflare Tunnel. The approach improves map tile loading speed and reliability.

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
