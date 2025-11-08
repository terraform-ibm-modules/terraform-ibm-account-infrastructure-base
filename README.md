# IBM Cloud Account infrastructure base module

[![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-base-account-enterprise?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-base-account-enterprise/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

<!-- Add a description of module(s) in this repo -->
This module is a general base layer module for setting up a newly provisioned account with a default provision of:

- Base Resource Group
- IAM Account Settings
- Trusted Profile + Access Group for Projects
- CBR Rules + Zones

![account-infrastructure-base](https://raw.githubusercontent.com/terraform-ibm-modules/terraform-ibm-account-infrastructure-base/main/reference-architectures/base-account-enterprise.svg)


<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-account-infrastructure-base](#terraform-ibm-account-infrastructure-base)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->

<!-- This heading should always match the name of the root level module (aka the repo name) -->
## terraform-ibm-account-infrastructure-base

### Current limitations:
The module currently does not support setting the following FSCloud requirements:
- Check whether user list visibility restrictions are configured in IAM settings for the account owner
  - Follow these [steps](https://cloud.ibm.com/docs/account?topic=account-iam-user-setting) as a workaround to set this manually in the UI
- Check whether the Financial Services Validated setting is enabled in account settings
  - Follow these [steps](https://cloud.ibm.com/docs/account?topic=account-enabling-fs-validated) as a workaround to set this manually in the UI

Tracking issue with IBM provider -> https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4204

### Pre-wired CBR configuration for FS Cloud

This module creates pre-wired rules for CBR from our [FS Cloud submodule for CBR](https://github.com/terraform-ibm-modules/terraform-ibm-cbr), see [this README](https://github.com/terraform-ibm-modules/terraform-ibm-cbr/tree/main/modules/fscloud#pre-wired-cbr-configuration-for-fs-cloud) for more details on this configuration.

### Usage

<!--
Add an example of the use of the module in the following code block.

Use real values instead of "var.<var_name>" or other placeholder values
unless real values don't help users know what to change.
-->
```hcl
module "account_configuration" {
    source  = "terraform-ibm-modules/account-infrastructure-base/ibm"
    version = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
    resource_group_name               = "account-base-resource-group"
    trusted_profile_name              = "account-base-trusted-profile"
}
```

### Required IAM access policies

<!-- PERMISSIONS REQUIRED TO RUN MODULE
If this module requires permissions, uncomment the following block and update
the sample permissions, following the format.
Replace the sample Account and IBM Cloud service names and roles with the
information in the console at
Manage > Access (IAM) > Access groups > Access policies.
-->

You need the following permissions to run this module.

- Account Management
    - **All Account Management** services (For creation of resource group)
        - `Administrator` platform access
    - **All Identity and Access enabled** services (For provisioning of CBR rules)
        - `Administrator` platform access

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.79.0, < 2.0.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_account_settings"></a> [account\_settings](#module\_account\_settings) | terraform-ibm-modules/iam-account-settings/ibm | 2.12.8 |
| <a name="module_cbr_fscloud"></a> [cbr\_fscloud](#module\_cbr\_fscloud) | terraform-ibm-modules/cbr/ibm//modules/fscloud | 1.33.8 |
| <a name="module_existing_resource_group"></a> [existing\_resource\_group](#module\_existing\_resource\_group) | terraform-ibm-modules/resource-group/ibm | 1.4.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-ibm-modules/resource-group/ibm | 1.4.0 |
| <a name="module_trusted_profile_projects"></a> [trusted\_profile\_projects](#module\_trusted\_profile\_projects) | terraform-ibm-modules/trusted-profile/ibm | 3.1.1 |

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_token_expiration"></a> [access\_token\_expiration](#input\_access\_token\_expiration) | Defines the access token expiration in seconds. This variable is ignored when `skip_iam_account_settings` is set to `true`. | `string` | `"3600"` | no |
| <a name="input_active_session_timeout"></a> [active\_session\_timeout](#input\_active\_session\_timeout) | Specify how long, in seconds, a user is allowed to work continuously in the account. This variable is ignored when `skip_iam_account_settings` is set to `true`. | `number` | `86400` | no |
| <a name="input_allowed_ip_addresses"></a> [allowed\_ip\_addresses](#input\_allowed\_ip\_addresses) | List of the IP addresses and subnets that can create IAM tokens for the account. This variable is ignored when `skip_iam_account_settings` is set to `true`. | `list(any)` | `[]` | no |
| <a name="input_api_creation"></a> [api\_creation](#input\_api\_creation) | When this variable is set to `RESTRICTED`, only users who are assigned the User API key creator role on the IAM Identity Service can create API keys, including the account owner. When set to `NOT_SET`, the previous value for this variable is cleared. Allowed values are `RESTRICTED`, `NOT_RESTRICTED`, or `NOT_SET`. This variable is ignored when `skip_iam_account_settings` is set to `true`. | `string` | `"RESTRICTED"` | no |
| <a name="input_appconfig_aggregator_service_access"></a> [appconfig\_aggregator\_service\_access](#input\_appconfig\_aggregator\_service\_access) | Set rule for App Configuration to a list of services supported by the configuration aggregator. The default is true. The full list of services can be found [here](https://cloud.ibm.com/docs/app-configuration?topic=app-configuration-ac-configuration-aggregator#ac-list-of-services-configaggregator). However, CBR rules will only be created for the CBR-supported services. Service references in the CBR zone are not supported for databases. | `map(bool)` | <pre>{<br/>  "IAM": true,<br/>  "apprapp": true,<br/>  "atracker": true,<br/>  "cloud-object-storage": true,<br/>  "codeengine": true,<br/>  "container-registry": true,<br/>  "dns-svcs": true,<br/>  "event-notifications": true,<br/>  "globalcatalog-collection": true,<br/>  "hs-crypto": true,<br/>  "is": true,<br/>  "kms": true,<br/>  "logs": true,<br/>  "messagehub": true,<br/>  "schematics": true,<br/>  "secrets-manager": true,<br/>  "sysdig-monitor": true,<br/>  "sysdig-secure": true,<br/>  "transit": true<br/>}</pre> | no |
| <a name="input_audit_resource_group_name"></a> [audit\_resource\_group\_name](#input\_audit\_resource\_group\_name) | The name of the audit resource group to create. | `string` | `"audit-rg"` | no |
| <a name="input_cbr_allow_at_to_cos"></a> [cbr\_allow\_at\_to\_cos](#input\_cbr\_allow\_at\_to\_cos) | Set to `true` to allow Activity Tracker Event Routing access to Object Storage. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_block_storage_to_kms"></a> [cbr\_allow\_block\_storage\_to\_kms](#input\_cbr\_allow\_block\_storage\_to\_kms) | Set to `true` to allow Block Storage for VPC access to the key management service. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_cos_to_kms"></a> [cbr\_allow\_cos\_to\_kms](#input\_cbr\_allow\_cos\_to\_kms) | Set to `true` to allow Object Storage access to the key management service. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_event_streams_to_kms"></a> [cbr\_allow\_event\_streams\_to\_kms](#input\_cbr\_allow\_event\_streams\_to\_kms) | Set to `true` to allow Event Streams access to the key management service. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_icd_to_kms"></a> [cbr\_allow\_icd\_to\_kms](#input\_cbr\_allow\_icd\_to\_kms) | Set to `true` to allow IBM Cloud databases access to the key management service. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_iks_to_is"></a> [cbr\_allow\_iks\_to\_is](#input\_cbr\_allow\_iks\_to\_is) | Set to `true` to allow the Kubernetes service access to Virtual Private Cloud Infrastructure Services. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_is_to_cos"></a> [cbr\_allow\_is\_to\_cos](#input\_cbr\_allow\_is\_to\_cos) | Set to `true` to allow Virtual Private Cloud Infrastructure Services access to Object Storage. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_roks_to_kms"></a> [cbr\_allow\_roks\_to\_kms](#input\_cbr\_allow\_roks\_to\_kms) | Set to `true` to allow Red Hat OpenShift access to the key management service. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_scc_to_cos"></a> [cbr\_allow\_scc\_to\_cos](#input\_cbr\_allow\_scc\_to\_cos) | Set to `true` to allow Security and Compliance Center access to Object Storage. Default is `true` if `provision_cbr` is `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_scc_wp_to_appconfig"></a> [cbr\_allow\_scc\_wp\_to\_appconfig](#input\_cbr\_allow\_scc\_wp\_to\_appconfig) | Set to `true` to allow Security and Compliance Center access to App Configuration. Default is `true` if `provision_cbr` is `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_scc_wp_to_cloud_monitoring"></a> [cbr\_allow\_scc\_wp\_to\_cloud\_monitoring](#input\_cbr\_allow\_scc\_wp\_to\_cloud\_monitoring) | Set to `true` to allow Security and Compliance Center access to Cloud Monitoring. Default is `true` if `provision_cbr` is `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_vpcs_to_container_registry"></a> [cbr\_allow\_vpcs\_to\_container\_registry](#input\_cbr\_allow\_vpcs\_to\_container\_registry) | Set to `true` to allow Virtual Private Clouds access to the Container Registry. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_vpcs_to_cos"></a> [cbr\_allow\_vpcs\_to\_cos](#input\_cbr\_allow\_vpcs\_to\_cos) | Set to `true` to allows Virtual Private Clouds access to Object Storage. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_vpcs_to_iam_access_management"></a> [cbr\_allow\_vpcs\_to\_iam\_access\_management](#input\_cbr\_allow\_vpcs\_to\_iam\_access\_management) | Set to `true` to allow Virtual Private Clouds access to IAM access management. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_allow_vpcs_to_iam_groups"></a> [cbr\_allow\_vpcs\_to\_iam\_groups](#input\_cbr\_allow\_vpcs\_to\_iam\_groups) | Set to `true` to allows Virtual Private Clouds access to IAM groups. Default is `true` if `provision_cbr` is set to `true`. | `bool` | `true` | no |
| <a name="input_cbr_kms_service_targeted_by_prewired_rules"></a> [cbr\_kms\_service\_targeted\_by\_prewired\_rules](#input\_cbr\_kms\_service\_targeted\_by\_prewired\_rules) | IBM Cloud offers two distinct key management services: Key Protect and Hyper Protect Crypto Services. This variable determines the specific key management service to which the pre-configured rules are applied. Use the value 'key-protect' to specify the Key Protect service, and 'hs-crypto' for Hyper Protect Crypto Services. Default is `["hs-crypto"]` if `provision_cbr` is set to `true`. | `list(string)` | <pre>[<br/>  "hs-crypto"<br/>]</pre> | no |
| <a name="input_cbr_prefix"></a> [cbr\_prefix](#input\_cbr\_prefix) | String to use as the prefix for all context-based restriction resources, default is `account-infra-base` if `provision_cbr` is set to `true`. | `string` | `"acct-infra-base"` | no |
| <a name="input_cbr_target_service_details"></a> [cbr\_target\_service\_details](#input\_cbr\_target\_service\_details) | Details of the target service for which a rule is created. The key is the service name. | <pre>map(object({<br/>    description      = optional(string)<br/>    target_rg        = optional(string)<br/>    instance_id      = optional(string)<br/>    enforcement_mode = string<br/>    tags             = optional(list(string))<br/>    region           = optional(string)<br/>    geography        = optional(string)<br/>    global_deny      = optional(bool, true)<br/>  }))</pre> | `{}` | no |
| <a name="input_devops_resource_group_name"></a> [devops\_resource\_group\_name](#input\_devops\_resource\_group\_name) | The name of the devops resource group to create. | `string` | `"devops-tools-rg"` | no |
| <a name="input_edge_resource_group_name"></a> [edge\_resource\_group\_name](#input\_edge\_resource\_group\_name) | The name of the edge resource group to create. | `string` | `"edge-rg"` | no |
| <a name="input_enforce_allowed_ip_addresses"></a> [enforce\_allowed\_ip\_addresses](#input\_enforce\_allowed\_ip\_addresses) | Whether the IP address restriction is enforced. Set the value to `false` to test the impact of the restriction on your account. After the impact of the restriction is determined, set the value to `true`. | `bool` | `true` | no |
| <a name="input_inactive_session_timeout"></a> [inactive\_session\_timeout](#input\_inactive\_session\_timeout) | Specify how long, in seconds, a user is allowed to stay logged in to the account while being inactive or idle. This variable is ignored when `skip_iam_account_settings` is set to `true`. | `string` | `"7200"` | no |
| <a name="input_management_resource_group_name"></a> [management\_resource\_group\_name](#input\_management\_resource\_group\_name) | The name of the management resource group to create. | `string` | `"management-plane-rg"` | no |
| <a name="input_max_sessions_per_identity"></a> [max\_sessions\_per\_identity](#input\_max\_sessions\_per\_identity) | Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than `0`, or `NOT_SET` to clear account settings and use the service default. This variable is ignored when `skip_iam_account_settings` is set to `true`. | `string` | `"NOT_SET"` | no |
| <a name="input_mfa"></a> [mfa](#input\_mfa) | Specify a multifactor authentication (MFA) method in the account. Supported valid values are `NONE` (no MFA method set), `TOTP` (for all non-federated IBMid users), `TOTP4ALL` (for all users), `LEVEL1` (email-based MFA for all users), `LEVEL2` (TOTP-based MFA for all users), `LEVEL3` (U2F MFA for all users). If `skip_iam_account_settings` is set to `true`, this variable is ignored. | `string` | `"TOTP4ALL"` | no |
| <a name="input_observability_resource_group_name"></a> [observability\_resource\_group\_name](#input\_observability\_resource\_group\_name) | The name of the observability resource group to create. | `string` | `"observability-rg"` | no |
| <a name="input_provision_cbr"></a> [provision\_cbr](#input\_provision\_cbr) | Set to `true` to create context-based restriction rules and zones in the module. The default is 'false'. | `bool` | `false` | no |
| <a name="input_provision_trusted_profile_projects"></a> [provision\_trusted\_profile\_projects](#input\_provision\_trusted\_profile\_projects) | Whether the trusted profile that authorizes an IBM Cloud project to deploy to your target account is created. | `bool` | `true` | no |
| <a name="input_public_access_enabled"></a> [public\_access\_enabled](#input\_public\_access\_enabled) | Specifies whether the public access group is available to anyone, regardless of whether they have access to your account or not. When enabled, assigned access policies can make resources accessible without authentication. If `skip_iam_account_settings` is set to true, this variable is ignored. | `bool` | `false` | no |
| <a name="input_refresh_token_expiration"></a> [refresh\_token\_expiration](#input\_refresh\_token\_expiration) | Defines the refresh token expiration in seconds. If `skip_iam_account_settings` is set to `true`, this variable is ignored. | `string` | `"259200"` | no |
| <a name="input_security_resource_group_name"></a> [security\_resource\_group\_name](#input\_security\_resource\_group\_name) | The name of the security resource group to create. | `string` | `"security-rg"` | no |
| <a name="input_serviceid_creation"></a> [serviceid\_creation](#input\_serviceid\_creation) | When this variable is set to `RESTRICTED`, only users who are assigned the Service ID creator role on the IAM Identity Service can create service IDs, including the account owner. When set to `NOT_SET`, the previous value for this variable is cleared. Allowed values are `RESTRICTED`, `NOT_RESTRICTED`, or `NOT_SET`. This variable is ignored when `skip_iam_account_settings` is set to `true`. | `string` | `"RESTRICTED"` | no |
| <a name="input_shell_settings_enabled"></a> [shell\_settings\_enabled](#input\_shell\_settings\_enabled) | Whether global shell settings for all users in the account are enabled or disabled. This variable is ignored when `skip_iam_account_settings` is set to `true`. | `bool` | `false` | no |
| <a name="input_single_resource_group_name"></a> [single\_resource\_group\_name](#input\_single\_resource\_group\_name) | The name of the resource group to create. When this variable is provided, only one resource group is created and all other resource group name variables are ignored. | `string` | `null` | no |
| <a name="input_skip_cloud_shell_calls"></a> [skip\_cloud\_shell\_calls](#input\_skip\_cloud\_shell\_calls) | Skip Cloud Shell calls in the account. This variable is ignored when `skip_iam_account_settings` is set to `true`. | `bool` | `false` | no |
| <a name="input_skip_iam_account_settings"></a> [skip\_iam\_account\_settings](#input\_skip\_iam\_account\_settings) | When set to `true`, only resource groups are created and IAM settings are not applied to the account. | `bool` | `false` | no |
| <a name="input_trusted_profile_description"></a> [trusted\_profile\_description](#input\_trusted\_profile\_description) | Description of the trusted profile. | `string` | `"Trusted profile that authorizes the project to deploy to your target account."` | no |
| <a name="input_trusted_profile_name"></a> [trusted\_profile\_name](#input\_trusted\_profile\_name) | Name of the trusted profile, required if `provision_trusted_profile_projects` is set to `true`. | `string` | `null` | no |
| <a name="input_trusted_profile_roles"></a> [trusted\_profile\_roles](#input\_trusted\_profile\_roles) | List of roles given to the trusted profile. | `list(string)` | <pre>[<br/>  "Administrator"<br/>]</pre> | no |
| <a name="input_use_existing_audit_resource_group"></a> [use\_existing\_audit\_resource\_group](#input\_use\_existing\_audit\_resource\_group) | Set to `true` to use an existing resource group that has the name provided in `audit_resource_group_name`. | `bool` | `false` | no |
| <a name="input_use_existing_devops_resource_group"></a> [use\_existing\_devops\_resource\_group](#input\_use\_existing\_devops\_resource\_group) | Set to `true` to use an existing resource group that has the name provided in `devops_resource_group_name`. | `bool` | `false` | no |
| <a name="input_use_existing_edge_resource_group"></a> [use\_existing\_edge\_resource\_group](#input\_use\_existing\_edge\_resource\_group) | Set to `true` to use an existing resource group that has the name provided in `edge_resource_group_name`. | `bool` | `false` | no |
| <a name="input_use_existing_management_resource_group"></a> [use\_existing\_management\_resource\_group](#input\_use\_existing\_management\_resource\_group) | Set to `true` to use an existing resource group that has the name provided in `management_resource_group_name`. | `bool` | `false` | no |
| <a name="input_use_existing_observability_resource_group"></a> [use\_existing\_observability\_resource\_group](#input\_use\_existing\_observability\_resource\_group) | Set to `true`to use an existing resource group that has the name provided in `observability_resource_group_name`. | `bool` | `false` | no |
| <a name="input_use_existing_security_resource_group"></a> [use\_existing\_security\_resource\_group](#input\_use\_existing\_security\_resource\_group) | Set to `true` to use an existing resource group that has the name provided in `security_resource_group_name`. | `bool` | `false` | no |
| <a name="input_use_existing_single_resource_group"></a> [use\_existing\_single\_resource\_group](#input\_use\_existing\_single\_resource\_group) | Set to `true` to use an existing resource group that has the name provided in `single_resource_group_name`. | `bool` | `false` | no |
| <a name="input_use_existing_workload_resource_group"></a> [use\_existing\_workload\_resource\_group](#input\_use\_existing\_workload\_resource\_group) | Set to `true` to use an existing resource group that has the name provided in `workload_resource_group_name`. | `bool` | `false` | no |
| <a name="input_user_mfa"></a> [user\_mfa](#input\_user\_mfa) | Specify a multifactor authentication (MFA) method for specific users the account. Supported valid values are `NONE` (no MFA method set), `TOTP` (for all non-federated IBMid users), `TOTP4ALL` (for all users), `LEVEL1` (email-based MFA for all users), `LEVEL2` (TOTP-based MFA for all users), `LEVEL3` (U2F MFA for all users). Example format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage. If `skip_iam_account_settings` is set to `true`, this variable is ignored. | <pre>set(object({<br/>    iam_id = string<br/>    mfa    = string<br/>  }))</pre> | `[]` | no |
| <a name="input_user_mfa_reset"></a> [user\_mfa\_reset](#input\_user\_mfa\_reset) | Set to `true` to delete all user multifactor authentication (MFA) settings in the target account, and ignore entries declared in `var user_mfa`. If `skip_iam_account_settings` is set to `true`, this variable is ignored. | `bool` | `false` | no |
| <a name="input_workload_resource_group_name"></a> [workload\_resource\_group\_name](#input\_workload\_resource\_group\_name) | The name of the workload resource group to create. | `string` | `"workload-rg"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_allowed_ip_addresses"></a> [account\_allowed\_ip\_addresses](#output\_account\_allowed\_ip\_addresses) | Account settings allowed IP addresses |
| <a name="output_account_allowed_ip_addresses_control_mode"></a> [account\_allowed\_ip\_addresses\_control\_mode](#output\_account\_allowed\_ip\_addresses\_control\_mode) | Account settings allowed IP addresses control mode |
| <a name="output_account_allowed_ip_addresses_enforced"></a> [account\_allowed\_ip\_addresses\_enforced](#output\_account\_allowed\_ip\_addresses\_enforced) | Account settings allowed IP addresses enforced |
| <a name="output_account_iam_access_token_expiration"></a> [account\_iam\_access\_token\_expiration](#output\_account\_iam\_access\_token\_expiration) | Account eettings IAM access token expiration |
| <a name="output_account_iam_active_session_timeout"></a> [account\_iam\_active\_session\_timeout](#output\_account\_iam\_active\_session\_timeout) | Account settings IAM active session timeout |
| <a name="output_account_iam_apikey_creation"></a> [account\_iam\_apikey\_creation](#output\_account\_iam\_apikey\_creation) | Account settings IAM API key creation |
| <a name="output_account_iam_inactive_session_timeout"></a> [account\_iam\_inactive\_session\_timeout](#output\_account\_iam\_inactive\_session\_timeout) | Account settings IAM inactive session timeout |
| <a name="output_account_iam_mfa"></a> [account\_iam\_mfa](#output\_account\_iam\_mfa) | Account settings IAM MFA |
| <a name="output_account_iam_refresh_token_expiration"></a> [account\_iam\_refresh\_token\_expiration](#output\_account\_iam\_refresh\_token\_expiration) | Account settings IAM refresh token expiration |
| <a name="output_account_iam_serviceid_creation"></a> [account\_iam\_serviceid\_creation](#output\_account\_iam\_serviceid\_creation) | Account settings IAM service ID creation |
| <a name="output_account_iam_user_mfa_list"></a> [account\_iam\_user\_mfa\_list](#output\_account\_iam\_user\_mfa\_list) | Account settings IAM user MFA list |
| <a name="output_account_public_access"></a> [account\_public\_access](#output\_account\_public\_access) | Account settings public access |
| <a name="output_account_shell_settings_status"></a> [account\_shell\_settings\_status](#output\_account\_shell\_settings\_status) | Account settings shell settings status |
| <a name="output_audit_resource_group_id"></a> [audit\_resource\_group\_id](#output\_audit\_resource\_group\_id) | ID of the resource group created for audit-related resources. |
| <a name="output_audit_resource_group_name"></a> [audit\_resource\_group\_name](#output\_audit\_resource\_group\_name) | Name of the resource group created for audit-related resources. |
| <a name="output_cbr_map_service_ref_name_zoneid"></a> [cbr\_map\_service\_ref\_name\_zoneid](#output\_cbr\_map\_service\_ref\_name\_zoneid) | Map of service references and zone IDs |
| <a name="output_cbr_map_target_service_rule_ids"></a> [cbr\_map\_target\_service\_rule\_ids](#output\_cbr\_map\_target\_service\_rule\_ids) | Map of target services and rule IDs |
| <a name="output_cbr_map_vpc_zoneid"></a> [cbr\_map\_vpc\_zoneid](#output\_cbr\_map\_vpc\_zoneid) | Map of VPC and zone ID |
| <a name="output_devops_resource_group_id"></a> [devops\_resource\_group\_id](#output\_devops\_resource\_group\_id) | ID of the resource group created for devops-related resources. |
| <a name="output_devops_resource_group_name"></a> [devops\_resource\_group\_name](#output\_devops\_resource\_group\_name) | Name of the resource group created for devops-related resources. |
| <a name="output_edge_resource_group_id"></a> [edge\_resource\_group\_id](#output\_edge\_resource\_group\_id) | ID of the resource group created for edge network-related resources. |
| <a name="output_edge_resource_group_name"></a> [edge\_resource\_group\_name](#output\_edge\_resource\_group\_name) | Name of the resource group created for edge network-related resources. |
| <a name="output_management_resource_group_id"></a> [management\_resource\_group\_id](#output\_management\_resource\_group\_id) | ID of the resource group created for management-related resources. |
| <a name="output_management_resource_group_name"></a> [management\_resource\_group\_name](#output\_management\_resource\_group\_name) | Name of the resource group created for management-related resources. |
| <a name="output_observability_resource_group_id"></a> [observability\_resource\_group\_id](#output\_observability\_resource\_group\_id) | ID of the resource group created for observability-related resources. |
| <a name="output_observability_resource_group_name"></a> [observability\_resource\_group\_name](#output\_observability\_resource\_group\_name) | Name of the resource group created for observability-related resources. |
| <a name="output_security_resource_group_id"></a> [security\_resource\_group\_id](#output\_security\_resource\_group\_id) | ID of the resource group created for security-related resources. |
| <a name="output_security_resource_group_name"></a> [security\_resource\_group\_name](#output\_security\_resource\_group\_name) | Name of the resource group created for security-related resources. |
| <a name="output_single_resource_group_id"></a> [single\_resource\_group\_id](#output\_single\_resource\_group\_id) | ID of the resource group created by the module. |
| <a name="output_single_resource_group_name"></a> [single\_resource\_group\_name](#output\_single\_resource\_group\_name) | Name of the resource group created by the module. |
| <a name="output_trusted_profile_projects"></a> [trusted\_profile\_projects](#output\_trusted\_profile\_projects) | Trusted profile for IBM Cloud projects |
| <a name="output_trusted_profile_projects_claim_rules"></a> [trusted\_profile\_projects\_claim\_rules](#output\_trusted\_profile\_projects\_claim\_rules) | Trusted profile IBM Cloud projects profile claim rules |
| <a name="output_trusted_profile_projects_links"></a> [trusted\_profile\_projects\_links](#output\_trusted\_profile\_projects\_links) | Trusted profile IBM Cloud projects profile links |
| <a name="output_trusted_profile_projects_policies"></a> [trusted\_profile\_projects\_policies](#output\_trusted\_profile\_projects\_policies) | Policies for the trusted profile for IBM Cloud projects |
| <a name="output_workload_resource_group_id"></a> [workload\_resource\_group\_id](#output\_workload\_resource\_group\_id) | ID of the resource group created for workload-related resources. |
| <a name="output_workload_resource_group_name"></a> [workload\_resource\_group\_name](#output\_workload\_resource\_group\_name) | Name of the resource group created for workload-related resources. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
