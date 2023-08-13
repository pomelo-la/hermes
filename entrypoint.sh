#/bin/sh

# Build config.hcl and credentials.json files from environment variable secrets
envsubst < config.hcl.tmp > config.hcl
envsubst < credentials.json.tmp > credentials.json

# Run the application
make run
