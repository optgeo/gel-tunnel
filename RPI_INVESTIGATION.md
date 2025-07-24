# Raspberry Pi OS Investigation

## Problem
The Raspberry Pi OS is experiencing instability. Possible causes include:
- Power supply issues.
- Storage access problems.

## Investigation Steps
1. Check system logs:
   ```bash
   sudo journalctl -xe
   ```
2. Monitor power supply voltage and current.
3. Test storage access speed and reliability.
4. Use `dmesg` to check kernel messages for undervoltage and other system events.

## Findings
- Martin successfully hosted the test PMTiles file `data/a.pmtiles`.
- The server was accessible locally at `http://0.0.0.0:3000`.
- The catalog endpoint (`/catalog`) listed available sources.

## Recommendations
- Use Martin for hosting PMTiles files locally.
- Proceed with Cloudflare Tunnel setup to expose the server to the internet.
