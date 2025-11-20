#!/bin/bash
set -e

STATE_FILE=$(jq -r '.state_file' <<< "$1")
ROTATE=$(jq -r '.rotate_backup' <<< "$1")
SWAP=$(jq -r '.swap' <<< "$1")

# Generate a random password
generate_password() {
  openssl rand -base64 32
}

# Initialize state if missing
init_state() {
  ACTIVE=$(generate_password)
  BACKUP=$(generate_password)

  echo "{\"active\": \"$ACTIVE\", \"backup\": \"$BACKUP\"}" > "$STATE_FILE"
}

# Load state
load_state() {
  ACTIVE=$(jq -r '.active' "$STATE_FILE")
  BACKUP=$(jq -r '.backup' "$STATE_FILE")
}

# Rotate backup password only
rotate_backup() {
  BACKUP=$(generate_password)
}

# Swap active and backup
swap_passwords() {
  TEMP="$ACTIVE"
  ACTIVE="$BACKUP"
  BACKUP="$TEMP"
}

# MAIN LOGIC
if [ ! -f "$STATE_FILE" ]; then
  init_state
else
  load_state

  if [ "$ROTATE" = "true" ]; then
    rotate_backup
  fi

  if [ "$SWAP" = "true" ]; then
    swap_passwords
  fi
fi

# Save final state
echo "{\"active\": \"$ACTIVE\", \"backup\": \"$BACKUP\"}" > "$STATE_FILE"

# Return values to Terraform
jq -n --arg active "$ACTIVE" --arg backup "$BACKUP" \
  '{active: $active, backup: $backup}'