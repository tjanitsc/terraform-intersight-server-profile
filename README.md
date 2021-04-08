# terraform-intersight-server-profile
Terraform module to configure Intersight Server Profiles.

Currently limited to the following policies and pool configurations which are required for Intersight Managed Mode:
* IMC Access Policy with vKVM IP Pool configured outside of Terraform (IP Pool must already exist in Intersight)
* Boot Order Policy with MRAID and Virtual Media boot options
* Virtual Media Policy with CDD device and HTTP remote fileshare
* LAN Connectivity Policy with 1 MLOM VNIC configured on the A side fabric interconnect.  VNIC MAC pool must already exist in Intersight.

## Examples

* [Profiles and required Policies for Intersight Managed Mode](https://github.com/terraform-cisco-modules/terraform-intersight-server-profile/tree/main/examples/intersight-managed-mode)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >= 1.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >= 1.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [intersight_access_policy.imm_access](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/resources/access_policy) | resource |
| [intersight_boot_precision_policy.disk_vmedia](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/resources/boot_precision_policy) | resource |
| [intersight_fabric_eth_network_control_policy.network_control](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/resources/fabric_eth_network_control_policy) | resource |
| [intersight_fabric_eth_network_group_policy.network_group](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/resources/fabric_eth_network_group_policy) | resource |
| [intersight_server_profile.profile](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/resources/server_profile) | resource |
| [intersight_vmedia_policy.http_cdd](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/resources/vmedia_policy) | resource |
| [intersight_vnic_eth_adapter_policy.ethernet_adapter](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/resources/vnic_eth_adapter_policy) | resource |
| [intersight_vnic_eth_if.eth0](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/resources/vnic_eth_if) | resource |
| [intersight_vnic_eth_qos_policy.ethernet_qos](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/resources/vnic_eth_qos_policy) | resource |
| [intersight_vnic_lan_connectivity_policy.lan](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/resources/vnic_lan_connectivity_policy) | resource |
| [intersight_compute_physical_summary.server_moid](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/data-sources/compute_physical_summary) | data source |
| [intersight_organization_organization.organization_moid](https://registry.terraform.io/providers/ciscodevnet/intersight/latest/docs/data-sources/organization_organization) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_boot_mode"></a> [boot\_mode](#input\_boot\_mode) | Configured Boot Mode for the Boot Order Policy | `string` | `"Legacy"` | no |
| <a name="input_boot_order_policy"></a> [boot\_order\_policy](#input\_boot\_order\_policy) | Name of Boot Order Policy to associate with the server profile | `string` | `null` | no |
| <a name="input_cluster_vlan"></a> [cluster\_vlan](#input\_cluster\_vlan) | VLAN ID used by Ethernet Network Group Policy | `number` | `null` | no |
| <a name="input_ethernet_network_group"></a> [ethernet\_network\_group](#input\_ethernet\_network\_group) | Ethernet Network Group Policy used by VNIC Ethernet Interfaces and LAN Connectivity Policy | `string` | `null` | no |
| <a name="input_imc_access_policy"></a> [imc\_access\_policy](#input\_imc\_access\_policy) | Name of IMC Access Policy to associate with the server profile | `string` | `null` | no |
| <a name="input_imc_access_vlan"></a> [imc\_access\_vlan](#input\_imc\_access\_vlan) | VLAN ID used by IMC Access Policy | `number` | `null` | no |
| <a name="input_ip_pool"></a> [ip\_pool](#input\_ip\_pool) | Name of IP Pool used by IMC Access Policy | `string` | `null` | no |
| <a name="input_lan_connectivity_policy"></a> [lan\_connectivity\_policy](#input\_lan\_connectivity\_policy) | Name of LAN Connectivity Policy to associate with the server profile | `string` | `null` | no |
| <a name="input_local_user_policy"></a> [local\_user\_policy](#input\_local\_user\_policy) | Name of Local User Policy to associate with the server profile | `string` | `null` | no |
| <a name="input_local_username"></a> [local\_username](#input\_local\_username) | Local username used by Local User Policy | `string` | `null` | no |
| <a name="input_local_username_password"></a> [local\_username\_password](#input\_local\_username\_password) | Local username password used by Local User Policy | `string` | `null` | no |
| <a name="input_mac_pool"></a> [mac\_pool](#input\_mac\_pool) | MAC Address Pool used by VNIC Ethernet Interfaces and LAN Connectivity Policy | `string` | `null` | no |
| <a name="input_mtu"></a> [mtu](#input\_mtu) | MTU used by Ethernet QoS Policy | `number` | `1500` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | The name of the Organization this resource is assigned to | `string` | `"default"` | no |
| <a name="input_server_list"></a> [server\_list](#input\_server\_list) | Servers (identified by name, object\_type, and target\_platform) to assign to configured server profiles | `list(map(string))` | n/a | yes |
| <a name="input_server_profile_action"></a> [server\_profile\_action](#input\_server\_profile\_action) | Desired Action for the server profile (e.g., Deploy, Unassign) | `string` | `"No-op"` | no |
| <a name="input_target_platform"></a> [target\_platform](#input\_target\_platform) | Target platform used for Server Profiles and Policies | `string` | `"FIAttached"` | no |
| <a name="input_vnic_name"></a> [vnic\_name](#input\_vnic\_name) | VNIC Ethernet Interface name | `string` | `"eth0"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


