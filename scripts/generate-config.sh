#!/usr/bin/env bash
# Generates config.yaml from template by substituting environment variables.
# Usage: ./scripts/generate-config.sh [output_path]
set -euo pipefail

TEMPLATE="$(dirname "$0")/../config/config.template.yaml"
OUTPUT="${1:-/tmp/tech-digest-config.yaml}"

required_vars=(
  AICLIENT2API_URL
  AICLIENT2API_KEY
  MONGODB_URI
  GMAIL_APP_PASSWORD
  PRODUCTHUNT_TOKEN
  RUANYF_GITHUB_TOKEN
)

for var in "${required_vars[@]}"; do
  if [[ -z "${!var:-}" ]]; then
    echo "ERROR: required secret '$var' is not set" >&2
    exit 1
  fi
done

envsubst < "$TEMPLATE" > "$OUTPUT"
echo "Config written to $OUTPUT"
