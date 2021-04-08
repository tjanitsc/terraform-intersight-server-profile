# Organization and other required Managed Object IDs (moids)
data "intersight_organization_organization" "organization_moid" {
  name = var.organization
}

# Server moids
data "intersight_compute_physical_summary" "server_moid" {
  name  = var.server_list[count.index].name
  count = length(var.server_list)
}

# Server profiles
resource "intersight_server_profile" "profile" {
  name        = "SP-${var.server_list[count.index].name}"
  description = "Updated Profile for server name ${var.server_list[count.index].name}"
  tags {
    key   = "Terraform"
    value = "Module"
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.id
  }
  target_platform = var.server_list[count.index].target_platform
  assigned_server {
    moid        = data.intersight_compute_physical_summary.server_moid[count.index].id
    object_type = var.server_list[count.index].object_type
  }
  action = var.server_profile_action
  count  = length(var.server_list)
}

# IMC access and other management policies
resource "intersight_access_policy" "imm_access" {
  # skip this resource if the name isn't defined
  count       = var.imc_access_policy == null ? 0 : 1
  name        = var.imc_access_policy
  inband_vlan = var.imc_access_vlan
  inband_ip_pool {
    object_type = "ippool.Pool"
    selector    = "Name eq '${var.ip_pool}'"
    /*
    moid        = "5fa9ad8a6962752d315d37ef"
      */
  }
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.id
  }

  dynamic "profiles" {
    for_each = intersight_server_profile.profile
    content {
      moid        = profiles.value["moid"]
      object_type = "server.Profile"
    }
  }
}

# Boot order and other compute policies
resource "intersight_boot_precision_policy" "disk_vmedia" {
  # skip this resource if the name isn't defined
  count = var.boot_order_policy == null ? 0 : 1
  name  = var.boot_order_policy
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.id
  }
  description              = "Terraform Module Boot Policy"
  configured_boot_mode     = var.boot_mode
  enforce_uefi_secure_boot = false
  boot_devices {
    enabled     = true
    name        = "disk"
    object_type = "boot.LocalDisk"
    additional_properties = jsonencode({
      Slot = "MRAID"
    })
  }
  boot_devices {
    enabled     = true
    name        = "vmedia"
    object_type = "boot.VirtualMedia"
  }

  dynamic "profiles" {
    for_each = intersight_server_profile.profile
    content {
      moid        = profiles.value["moid"]
      object_type = "server.Profile"
    }
  }
}

resource "intersight_vmedia_policy" "http_cdd" {
  name    = var.server_list[count.index].vmedia_policy
  enabled = true
  mappings = [{
    additional_properties   = ""
    authentication_protocol = "none"
    class_id                = "vmedia.Mapping"
    device_type             = "cdd"
    file_location           = "http://${var.server_list[count.index].boot_iso_file_location}"
    host_name               = ""
    is_password_set         = false
    mount_options           = ""
    mount_protocol          = "http"
    object_type             = "vmedia.Mapping"
    password                = ""
    remote_file             = ""
    remote_path             = ""
    sanitized_file_location = var.server_list[count.index].boot_iso_file_location
    username                = ""
    volume_name             = "http-cdd"
  }]
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.id
  }

  profiles {
    moid        = intersight_server_profile.profile[count.index].id
    object_type = "server.Profile"
  }

  count = length(var.server_list)
}

# LAN Connectivity and other network policies
resource "intersight_vnic_lan_connectivity_policy" "lan" {
  # skip this resource if the name isn't defined
  count           = var.lan_connectivity_policy == null ? 0 : 1
  name            = var.lan_connectivity_policy
  description     = "Terraform Module LAN Connectivity Policy"
  placement_mode  = "auto"
  target_platform = var.target_platform
  # iqn_allocation_type = "none"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.id
  }

  dynamic "profiles" {
    for_each = intersight_server_profile.profile
    content {
      moid        = profiles.value["moid"]
      object_type = "server.Profile"
    }
  }
}

# Required Ethernet policies with default values
resource "intersight_fabric_eth_network_control_policy" "network_control" {
  # skip this resource if the name isn't defined
  count       = var.lan_connectivity_policy == null ? 0 : 1
  name        = "tf-module-ethernet-network-control-policy"
  description = "Terraform Module Fabric Ethernet Network Control Policy"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.id
  }
}

resource "intersight_vnic_eth_adapter_policy" "ethernet_adapter" {
  # skip this resource if the name isn't defined
  count        = var.lan_connectivity_policy == null ? 0 : 1
  name         = "tf-module-ethernet-adapter-policy"
  description  = "Terraform Module Ethernet Adapter Policy"
  rss_settings = true
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.id
  }
  /*
  vxlan_settings {
    enabled = false
  }

  nvgre_settings {
    enabled = false
  }

  arfs_settings {
    enabled = false
  }
  */
}

resource "intersight_vnic_eth_qos_policy" "ethernet_qos" {
  # skip this resource if the name isn't defined
  count       = var.lan_connectivity_policy == null ? 0 : 1
  name        = "tf-module-ethernet-qos-policy"
  description = "Terraform Module Ethernet Quality of Service"
  mtu         = var.mtu
  # rate_limit     = 0
  # cos            = 0
  # trust_host_cos = false
  # burst          = 1
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.id
  }
}

resource "intersight_fabric_eth_network_group_policy" "network_group" {
  # skip this resource if the name isn't defined
  count       = var.ethernet_network_group == null ? 0 : 1
  name        = var.ethernet_network_group
  description = "Terraform Module Cluster Network"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.organization_moid.id
  }
  vlan_settings {
    allowed_vlans = var.cluster_vlan
    native_vlan   = var.cluster_vlan
  }
}

resource "intersight_vnic_eth_if" "eth0" {
  # skip this resource if the name isn't defined
  count = var.lan_connectivity_policy == null ? 0 : 1
  name  = var.vnic_name
  order = 0
  placement {
    id        = "MLOM"
    pci_link  = 0
    uplink    = 0
    switch_id = "A"
  }
  failover_enabled = true
  mac_pool {
    /*
    moid        = "5f35631f6962752d3125234c"
    */
    object_type = "macpool.Pool"
    selector    = "Name eq '${var.mac_pool}'"
  }
  lan_connectivity_policy {
    moid        = intersight_vnic_lan_connectivity_policy.lan[count.index].id
    object_type = "vnic.LanConnectivityPolicy"
  }
  fabric_eth_network_group_policy {
    moid = intersight_fabric_eth_network_group_policy.network_group[count.index].id
  }
  fabric_eth_network_control_policy {
    moid = intersight_fabric_eth_network_control_policy.network_control[count.index].id
  }
  eth_adapter_policy {
    moid = intersight_vnic_eth_adapter_policy.ethernet_adapter[count.index].id
  }
  eth_qos_policy {
    moid = intersight_vnic_eth_qos_policy.ethernet_qos[count.index].id
  }
}
