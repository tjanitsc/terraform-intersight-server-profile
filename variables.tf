variable "target_platform" {
  type        = string
  description = "Target platform used for Server Profiles and Policies"
  default     = "FIAttached"
}

# Server and Organization names
variable "server_list" {
  type        = list(map(string))
  description = "Servers (identified by name, object_type, and target_platform) to assign to configured server profiles"
}

variable "organization" {
  type        = string
  description = "The name of the Organization this resource is assigned to"
  default     = "default"
}

variable "server_profile_action" {
  type        = string
  description = "Desired Action for the server profile (e.g., Deploy, Unassign)"
  default     = "No-op"
}

variable "imc_access_policy" {
  type        = string
  description = "Name of IMC Access Policy to associate with the server profile"
  default     = null
}

variable "imc_access_vlan" {
  type        = number
  description = "VLAN ID used by IMC Access Policy"
  default     = null
}

variable "ip_pool" {
  type        = string
  description = "Name of IP Pool used by IMC Access Policy"
  default     = null
}

variable "local_user_policy" {
  type        = string
  description = "Name of Local User Policy to associate with the server profile"
  default     = null
}

variable "local_username" {
  type        = string
  description = "Local username used by Local User Policy"
  default     = null
}

variable "local_username_password" {
  type        = string
  description = "Local username password used by Local User Policy"
  default     = null
}

variable "boot_order_policy" {
  type        = string
  description = "Name of Boot Order Policy to associate with the server profile"
  default     = null
}

variable "boot_mode" {
  type        = string
  description = "Configured Boot Mode for the Boot Order Policy"
  default     = "Legacy"
}

variable "lan_connectivity_policy" {
  type        = string
  description = "Name of LAN Connectivity Policy to associate with the server profile"
  default     = null
}

variable "mac_pool" {
  type        = string
  description = "MAC Address Pool used by VNIC Ethernet Interfaces and LAN Connectivity Policy"
  default     = null
}

variable "ethernet_network_group" {
  type        = string
  description = "Ethernet Network Group Policy used by VNIC Ethernet Interfaces and LAN Connectivity Policy"
  default     = null
}

variable "mtu" {
  type        = number
  description = "MTU used by Ethernet QoS Policy"
  default     = 1500
}

variable "cluster_vlan" {
  type        = number
  description = "VLAN ID used by Ethernet Network Group Policy"
  default     = null
}

variable "vnic_name" {
  type        = string
  description = "VNIC Ethernet Interface name"
  default     = "eth0"
}
