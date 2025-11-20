# Password Manager Module

This module manages two persistent passwords:

- `active` password
- `backup` password

Features:
- Generates both passwords on first creation.
- Rotates only the backup password (`rotate_backup = true`).
- Swaps active and backup passwords (`swap = true`).
- Completely idempotent — no changes unless rotate or swap are requested.
- Uses a local JSON file to store persistent values.

## Inputs
- `rotate_backup` — rotate the backup password only
- `swap` — swap active and backup passwords
- `state_file` — local json file to store values

## Outputs
- `active_password`

- `backup_password`

## Terraform module with two random passwords (active + backup) with:

1. Rotation only for backup
2. Optional swapping of roles
3. Idempotent runs (no regeneration unless triggered externally)
4. Substrate-agnostic
5. Max 2 terraform apply cycles
6. Terraform as the core tool (with optional external helper if needed)
