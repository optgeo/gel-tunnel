# Makefile for managing gel.pmtiles and optimal_bvmap-v1.pmtiles

# Variables
URL=https://data.source.coop/smartmaps/gel/gel.pmtiles
PMTILES_DIR=data
OUTPUT=$(PMTILES_DIR)/gel.pmtiles

# Variables for optimal_bvmap-v1.pmtiles
OPTIMAL_URL=https://cyberjapandata.gsi.go.jp/xyz/optimal_bvmap-v1/optimal_bvmap-v1.pmtiles
OPTIMAL_OUTPUT=$(PMTILES_DIR)/optimal_bvmap-v1.pmtiles

# Default target
.PHONY: all
all: download download-optimal

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
	martin --webui enable-for-all $(PMTILES_DIR)
	@echo "Hosting complete."

# Task to run Martin through Cloudflare Tunnel
.PHONY: tunnel
tunnel:
	@echo "Running Cloudflare Tunnel with Martin..."
	cloudflared tunnel run --url http://localhost:8080

# Task to download optimal_bvmap-v1.pmtiles
.PHONY: download-optimal
download-optimal:
	@echo "Downloading optimal_bvmap-v1.pmtiles..."
	curl -C - -o $(OPTIMAL_OUTPUT) --retry 5 $(OPTIMAL_URL)
	@echo "Download complete: $(OPTIMAL_OUTPUT)"

# Task to verify the integrity of optimal_bvmap-v1.pmtiles
.PHONY: verify-optimal
verify-optimal:
	@echo "Verifying optimal_bvmap-v1.pmtiles..."
	pmtiles verify $(OPTIMAL_OUTPUT)
	@echo "Verification complete."

# Task to clean up optimal_bvmap-v1.pmtiles
.PHONY: clean-optimal
clean-optimal:
	@echo "Cleaning up optimal_bvmap-v1.pmtiles..."
	rm -f $(OPTIMAL_OUTPUT)
	@echo "Cleanup complete."
