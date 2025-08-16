########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API key that is used by the provider to authenticate with IBM Cloud to create the resources."
  sensitive   = true
}

variable "provider_visibility" {
  description = "Set the visibility value for the IBM terraform provider. Supported values are `public`, `private`, `public-and-private`. [Learn more](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/guides/custom-service-endpoints)."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["public", "private", "public-and-private"], var.provider_visibility)
    error_message = "Invalid visibility option. Allowed values are 'public', 'private', or 'public-and-private'."
  }
}

variable "prefix" {
  type        = string
  nullable    = true
  description = "The prefix to be added to all resources created by this solution. To skip using a prefix, set this value to null or an empty string. The prefix must begin with a lowercase letter and may contain only lowercase letters, digits, and hyphens '-'. It should not exceed 16 characters, must not end with a hyphen('-'), and can not contain consecutive hyphens ('--'). Example: prod-us-south. [Learn more](https://terraform-ibm-modules.github.io/documentation/#/prefix.md)."

  validation {
    # - null and empty string is allowed
    # - Must not contain consecutive hyphens (--): length(regexall("--", var.prefix)) == 0
    # - Starts with a lowercase letter: [a-z]
    # - Contains only lowercase letters (a–z), digits (0–9), and hyphens (-) and must not exceed 16 characters in length: [a-z0-9-]{0,14}
    # - Must not end with a hyphen (-): [a-z0-9]
    condition = (var.prefix == null || var.prefix == "" ? true :
      alltrue([
        can(regex("^[a-z][-a-z0-9]{0,14}[a-z0-9]$", var.prefix)),
        length(regexall("--", var.prefix)) == 0
      ])
    )
    error_message = "Prefix must begin with a lowercase letter and may contain only lowercase letters, digits, and hyphens '-'. It should not exceed 16 characters, must not end with a hyphen('-'), and cannot contain consecutive hyphens ('--')."
  }
}

variable "allowed_ip_addresses" {
  description = " A list of the IP addresses and subnets from which IAM tokens can be created for the account."
  type        = list(string)
  default     = []
}

variable "single_resource_group_name" {
  type        = string
  description = "Use a single resource group for all infrastructure, when this variable is provided only one resource group will be created and all other resource group name variables will be ignored. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<single_resource_group_name>`."
  default     = null
}

variable "use_existing_single_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `single_resource_group_name`."
  default     = true
}

variable "security_resource_group_name" {
  type        = string
  description = "The name of the security resource group to create. If `var.prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<security_resource_group_name>`."
  default     = "security-rg"
}

variable "use_existing_security_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `security_resource_group_name`."
  default     = false
}

variable "audit_resource_group_name" {
  type        = string
  description = "The name of the audit resource group to create. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<audit_resource_group_name>`."
  default     = "audit-rg"
}

variable "use_existing_audit_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `audit_resource_group_name`."
  default     = false
}

variable "observability_resource_group_name" {
  type        = string
  description = "The name of the observability resource group to create. Required if `provision_activity_tracker_cos` is true and `existing_cos_resource_group_name` is not provided. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<observability_resource_group_name>`."
  default     = "observability-rg"
}

variable "use_existing_observability_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `observability_resource_group_name`."
  default     = false
}

variable "management_resource_group_name" {
  type        = string
  description = "The name of the management resource group to create. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<management_resource_group_name>`."
  default     = "management-plane-rg"
}

variable "use_existing_management_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `management_resource_group_name`."
  default     = false
}

variable "workload_resource_group_name" {
  type        = string
  description = "The name of the workload resource group to create. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<workload_resource_group_name>`."
  default     = "workload-rg"
}

variable "use_existing_workload_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `workload_resource_group_name`."
  default     = false
}

variable "edge_resource_group_name" {
  type        = string
  description = "The name of the edge resource group to create. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<edge_resource_group_name>`."
  default     = "edge-rg"
}

variable "use_existing_edge_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `edge_resource_group_name`."
  default     = false
}

variable "devops_resource_group_name" {
  type        = string
  description = "The name of the devops resource group to create. If `prefix` is provided, it is prefixed on the name in the following format: `<prefix>-<devops_resource_group_name>`."
  default     = "devops-tools-rg"
}

variable "use_existing_devops_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `devops_resource_group_name`."
  default     = false
}

variable "skip_iam_account_settings" {
  type        = bool
  description = "Set to true to skip the IAM account settings being applied to the account"
  default     = false
}

variable "access_token_expiration" {
  type        = string
  description = "The access token expiration in seconds."
  default     = "3600"
}

variable "active_session_timeout" {
  type        = number
  description = "Specify how long in seconds a user is allowed to work continuously in the account."
  default     = 86400
}

variable "api_creation" {
  type        = string
  description = "When restriction is enabled, only users that are assigned the User API key creator role on the IAM Identity Service can create API keys, including the account owner. Allowed values are `restricted`, `not_restricted`, or `not_set` (to clear a previous value)."
  default     = "RESTRICTED"
}

variable "enforce_allowed_ip_addresses" {
  type        = bool
  description = "Whether the IP address restriction is enforced. If you want to test the impact of this setting, set to `false`. Traffic originating outside of the specified allowed IP addresses is monitored with audit events sent to Activity Tracker, after running in monitoring mode to test the impact of the restriction, you must set to `true` to enforce the IP allowlist."
  default     = true
}

variable "inactive_session_timeout" {
  type        = string
  description = "The maximum time in seconds before an inactive user is signed out and their credentials are required again. The maximum duration a user can be inactive is 2 hours."
  default     = "7200"
}

variable "max_sessions_per_identity" {
  type        = string
  description = "The number of login sessions that an account user can have active. Supports any whole number greater than `0`, or `NOT_SET` to unset account setting and use service default."
  default     = "NOT_SET"
}

variable "mfa" {
  type        = string
  description = "The Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users)."
  default     = "TOTP4ALL"
}

variable "enable_public_access" {
  type        = bool
  description = "Whether to enable or disable the public access group. Assigning an access policy to the access group opens access to that resource to anyone whether they're a member of your account or not because authentication is no longer required. When set to false, the public access group is disabled."
  default     = false
}

variable "refresh_token_expiration" {
  type        = string
  description = "The duration for how long refresh tokens are valid. The maximum duration you can set for a refresh token is 72 hours."
  default     = "259200"
}

variable "serviceid_creation" {
  type        = string
  description = "When restriction is enabled, only users that are assigned the Service ID creator role on the IAM Identity Service can create service IDs, including the account owner. Allowed values are `restricted`, `not_restricted`, or `not_set` (to clear a previous value)."
  default     = "RESTRICTED"
}

variable "enable_shell_settings" {
  type        = bool
  description = "Whether to allow CLI logins with only a password. Set to false for a higher level of security."
  default     = false
}

variable "skip_cloud_shell_calls" {
  type        = bool
  description = "Skip Cloud Shell calls in the account."
  default     = true
}

variable "user_mfa" {
  type = set(object({
    iam_id = string
    mfa    = string
  }))
  description = "Multi-Factor Authentication method for specific users the account. Supported valid values are `NONE` (No MFA trait set), `TOTP` (For all non-federated IBMId users), `TOTP4ALL` (For all users), `LEVEL1` (Email based MFA for all users), `LEVEL2` (TOTP based MFA for all users), `LEVEL3` (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage"
  default     = []
}

variable "user_mfa_reset" {
  type        = bool
  description = "Whether to delete all user MFA settings configured in the targeted account. Set to true to ignore entries declared in variable `user_mfa`."
  default     = false
}

variable "provision_trusted_profile_projects" {
  type        = bool
  description = "Whether the trusted profile for Projects is provisioned."
  default     = true
}

variable "trusted_profile_name" {
  type        = string
  description = "The name of the trusted profile. Required if `provision_trusted_profile_projects` is true."
  default     = null
}

variable "trusted_profile_description" {
  type        = string
  description = "The description of the trusted profile."
  default     = "Trusted Profile for Projects access"
}

variable "trusted_profile_roles" {
  type        = list(string)
  description = "A list of roles given to the trusted profile."
  default     = ["Administrator"]
}

variable "provision_cbr" {
  type        = bool
  description = "Whether to enable the creation of context-based restriction rules and zones in the solution. Default is false. [Learn more](https://github.com/terraform-ibm-modules/terraform-ibm-cbr/blob/main/modules/fscloud/README.md)."
  default     = false
}

variable "cbr_enforcement_mode" {
  type        = string
  description = "Enforcement mode of the CBR rules. Valid values are `enabled`, `disabled`, or `report`. When set to `enabled`, traffic will be restricted according to [defined rules](https://github.com/terraform-ibm-modules/terraform-ibm-cbr/tree/main/modules/fscloud), allowing only permitted connections while blocking all others. `report` mode monitors CBR rules and logged in activity tracker without blocking traffic which is useful for testing. Default is report. [Learn more](https://cloud.ibm.com/docs/account?topic=account-context-restrictions-whatis#rule-enforcement)."
  default     = "report"
}

variable "cbr_kms_service_targeted_by_prewired_rules" {
  type        = list(string)
  description = "IBM Cloud offers two distinct Key Management Services (KMS): Key Protect and Hyper Protect Crypto Services (HPCS). This variable determines the specific KMS service to which the pre-configured rules are applied. Use the value 'key-protect' to specify the Key Protect service, and 'hs-crypto' for the Hyper Protect Crypto Services (HPCS). Default is `[\"hs-crypto\"]` if `provision_cbr` is true."
  default     = ["hs-crypto"]
}
