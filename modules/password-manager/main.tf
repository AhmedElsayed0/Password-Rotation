locals {
  script_path = "${path.module}/scripts/manage_passwords.sh"
}

data "external" "passwords" {
  program = [
    "/bin/bash",
    local.script_path
  ]

  query = {
    state_file    = var.state_file
    rotate_backup = var.rotate_backup
    swap          = var.swap
  }
}

# Expose values to the module outputs
locals {
  active_password = data.external.passwords.result["active"]
  backup_password = data.external.passwords.result["backup"]
}