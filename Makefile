# Makefile for managing gel.pmtiles

# Variables
URL=https://data.source.coop/smartmaps/gel/gel.pmtiles
OUTPUT=data/gel.pmtiles

# Default target
.PHONY: all
all: download

# Task to download gel.pmtiles
.PHONY: download
download:
	@echo "Downloading gel.pmtiles..."
	curl -C - -o $(OUTPUT) --retry 5 $(URL)
	@echo "Download complete: $(OUTPUT)"

# Task to verify the integrity of gel.pmtiles
.PHONY: verify
verify:
	@echo "Verifying gel.pmtiles..."
	pmtiles verify $(OUTPUT)
	@echo "Verification complete."

# Task to clean up downloaded files
.PHONY: clean
clean:
	@echo "Cleaning up downloaded files..."
	rm -f $(OUTPUT)
	@echo "Cleanup complete."

# Task to host gel.pmtiles with Martin
.PHONY: host
host:
	@echo "Hosting gel.pmtiles with Martin..."
	martin $(OUTPUT)
	@echo "Hosting complete."

# Task to run Martin through Cloudflare Tunnel
.PHONY: tunnel
tunnel:
	@echo "Running Cloudflare Tunnel with Martin..."
	cloudflared tunnel run --url http://localhost:8080
