variable "rotate_backup" {
  description = "Regenerate only the backup password."
  type        = bool
  default     = false
}

variable "swap" {
  description = "Swap active and backup passwords."
  type        = bool
  default     = false
}

variable "state_file" {
  description = "Path to JSON file that stores persistent password state."
  type        = string
  default     = "password_state.json"
}