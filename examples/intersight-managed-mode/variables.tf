# API key info
variable "secretkey" {
  type        = string
  description = "Filename (absolute path) or string of PEM formatted private key data to be used for Intersight API authentication."
}

variable "apikey" {
  type        = string
  description = "Public API Key ID"
}

variable "endpoint" {
  type        = string
  description = "URI used to access the Intersight API"
  default     = "https://www.intersight.com"
}

variable "server_profile_action" {
  type        = string
  description = "Desired Action for the server profile (e.g., Deploy, Unassign)"
  default     = "No-op"
}

variable "vnic_name" {
  type        = string
  description = "VNIC Ethernet Interface name"
  default     = "eth0"
}
