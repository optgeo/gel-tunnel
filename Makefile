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
	curl -o $(OUTPUT) --retry 5 $(URL)
	@echo "Download complete: $(OUTPUT)"

# Task to clean up downloaded files
.PHONY: clean
clean:
	@echo "Cleaning up downloaded files..."
	rm -f $(OUTPUT)
	@echo "Cleanup complete."
