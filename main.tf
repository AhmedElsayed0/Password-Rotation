module "passwords" {
  source = "./modules/password-manager"

  rotate_backup = var.rotate_backup
  swap          = var.swap
  state_file    = "password_state.json"
}