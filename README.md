# terraform-intersight-server-profile
Terraform module to configure Intersight Server Profiles.

Currently limited to the following policies and pool configurations which are required for Intersight Managed Mode:
* IMC Access Policy with vKVM IP Pool configured outside of Terraform (IP Pool must already exist in Intersight)
* Boot Order Policy with MRAID and Virtual Media boot options
* Virtual Media Policy with CDD device and HTTP remote fileshare
* LAN Connectivity Policy with 1 MLOM VNIC configured on the A side fabric interconnect.  VNIC MAC pool must already exist in Intersight.

## Examples




