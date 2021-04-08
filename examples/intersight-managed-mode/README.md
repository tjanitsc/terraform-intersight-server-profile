# Multiple Intersight Managed Mode Profiles

Configures multiple Server Profiles using a Terraform Module

## Usage

This example will configure Server Profiles with policies needed Intersight Management Mode (IMM).  You will need to edit the main.tf configuration file based on the IMM servers and desired policy settings for your Intersight account.  Once your configuration file is edited, run the following to configure profiles:

```
terraform init
terraform apply
```

Note that with the current Intersight Provider, dependencies from policies to profiles prevent a profile deploy prior to initial configuration.  To deploy profiles that are configured by the above commands, run the following additional apply with a Deploy action:

```
terraform apply --var server_profile_action=Deploy
```

To destory resources from the command line, run `terraform destroy` (with the current provider, this command may need to be run repeatedly if errors like the following are seen):

```
Error: error occurred while deleting FabricEthNetworkGroupPolicy object: 400 Bad Request Response from endpoint: {"code":"InvalidRequest","message":"Cannot delete policy 'tf-module-sjc07-248-net-group' associated with vNICs.","messageId":"gobi_fabric_delete_associated_policy","messageParams":{"1":"tf-module-sjc07-248-net-group"},"traceId":"NB7719a2dfd3b693eb476167cb6994219a"}



Error: error occurred while deleting ServerProfile object: 403 Forbidden Response from endpoint: {"code":"InvalidRequest","message":"Cannot delete the server profile while there is a server associated with it","messageId":"gershwin_cannot_delete_server_profile","messageParams":{},"traceId":"NBadbe2c8eb1c8ae4b5908ba8d97a1a020"}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >= 1.0.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_imm_profile"></a> [imm\_profile](#module\_imm\_profile) | ../.. |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Public API Key ID | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | URI used to access the Intersight API | `string` | `"https://www.intersight.com"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Filename (absolute path) or string of PEM formatted private key data to be used for Intersight API authentication. | `string` | n/a | yes |
| <a name="input_server_profile_action"></a> [server\_profile\_action](#input\_server\_profile\_action) | Desired Action for the server profile (e.g., Deploy, Unassign) | `string` | `"No-op"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
