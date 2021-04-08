provider "intersight" {
  secretkey = var.secretkey
  apikey    = var.apikey
  endpoint  = var.endpoint
}

module "imm_profile" {
  source = "../.."

  # Server names and platform
  server_list = [
    {
      name                   = "SJC07-R14-FI-1-1-4",
      object_type            = "compute.Blade",
      target_platform        = "FIAttached",
      vmedia_policy          = "tf-esxi67u3-248-230",
      boot_iso_file_location = "172.28.224.72/kubam/imm-esx-172-22-248-230.iso"
    },
    {
      name                   = "SJC07-R14-FI-1-1-5",
      object_type            = "compute.Blade",
      target_platform        = "FIAttached",
      vmedia_policy          = "tf-esxi67u3-248-231",
      boot_iso_file_location = "172.28.224.72/kubam/imm-esx-172-22-248-231.iso"
    },
    {
      name                   = "SJC07-R14-FI-1-1-6",
      object_type            = "compute.Blade",
      target_platform        = "FIAttached",
      vmedia_policy          = "tf-esxi67u3-248-232",
      boot_iso_file_location = "172.28.224.72/kubam/imm-esx-172-22-248-232.iso"
    }
  ]

  # Server Profile actions
  server_profile_action = var.server_profile_action

  # Comment out any policies you do not want configured
  imc_access_policy = "tf-module-SJC07-R14-15-access"
  imc_access_vlan   = 248
  ip_pool           = "SJC07-R14-15-IP"

  boot_order_policy = "tf-module-boot-policy"

  lan_connectivity_policy = "tf-module-lan-connectivity-policy"
  mac_pool                = "sjc02-de30-mac"
  ethernet_network_group  = "tf-module-sjc07-248-net-group"
  cluster_vlan            = 248
  vnic_name               = var.vnic_name
}
