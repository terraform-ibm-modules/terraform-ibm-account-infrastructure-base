########################################################################################################################
# Account Variables
########################################################################################################################

variable "global_resource_group_name" {
  type        = string
  description = "The name of the global resource group to create, takes precedence over all other resource group name variables."
  default     = null

  validation {
    condition     = length(coalesce(var.global_resource_group_name, "null")) <= 40
    error_message = "`global_resource_group_name` must be 40 characters or less."
  }
}

variable "use_existing_global_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `global_resource_group_name`."
  default     = false
}

variable "security_resource_group_name" {
  type        = string
  description = "The name of the security resource group to create."
  default     = "security-rg"

  validation {
    condition     = length(coalesce(var.security_resource_group_name, "null")) <= 40
    error_message = "`security_resource_group_name` must be 40 characters or less."
  }
}

variable "use_existing_security_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `security_resource_group_name`."
  default     = false
}

variable "audit_resource_group_name" {
  type        = string
  description = "The name of the audit resource group to create."
  default     = "audit-rg"

  validation {
    condition     = length(coalesce(var.audit_resource_group_name, "null")) <= 40
    error_message = "`audit_resource_group_name` must be 40 characters or less."
  }
}

variable "use_existing_audit_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `audit_resource_group_name`."
  default     = false
}

variable "observability_resource_group_name" {
  type        = string
  description = "The name of the observability resource group to create."
  default     = "observability-rg"

  validation {
    condition     = length(coalesce(var.observability_resource_group_name, "null")) <= 40
    error_message = "`observability_resource_group_name` must be 40 characters or less."
  }
}

variable "use_existing_observability_resource_group" {
  type        = bool
  description = "Set to `true`to use an existing resource group that has the name provided in `observability_resource_group_name`."
  default     = false
}

variable "management_resource_group_name" {
  type        = string
  description = "The name of the management resource group to create."
  default     = "management-plane-rg"

  validation {
    condition     = length(coalesce(var.management_resource_group_name, "null")) <= 40
    error_message = "`management_resource_group_name` must be 40 characters or less."
  }
}

variable "use_existing_management_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `management_resource_group_name`."
  default     = false
}

variable "workload_resource_group_name" {
  type        = string
  description = "The name of the workload resource group to create."
  default     = "workload-rg"

  validation {
    condition     = length(coalesce(var.workload_resource_group_name, "null")) <= 40
    error_message = "`workload_resource_group_name` must be 40 characters or less."
  }
}

variable "use_existing_workload_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `workload_resource_group_name`."
  default     = false
}

variable "edge_resource_group_name" {
  type        = string
  description = "The name of the edge resource group to create."
  default     = "edge-rg"

  validation {
    condition     = length(coalesce(var.edge_resource_group_name, "null")) <= 40
    error_message = "`edge_resource_group_name` must be 40 characters or less."
  }
}

variable "use_existing_edge_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `edge_resource_group_name`."
  default     = false
}

variable "devops_resource_group_name" {
  type        = string
  description = "The name of the devops resource group to create."
  default     = "devops-tools-rg"

  validation {
    condition     = length(coalesce(var.devops_resource_group_name, "null")) <= 40
    error_message = "`devops_resource_group_name` must be 40 characters or less."
  }
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
  description = "Defines the access token expiration in seconds, has no effect when `skip_iam_account_settings` is true."
  default     = "3600"
}

variable "active_session_timeout" {
  type        = number
  description = "Specify how long (seconds) a user is allowed to work continuously in the account, has no effect when `skip_iam_account_settings` is true."
  default     = 86400
}

variable "allowed_ip_addresses" {
  type        = list(any)
  description = "List of the IP addresses and subnets from which IAM tokens can be created for the account, has no effect when `skip_iam_account_settings` is true."
  default     = []
}

variable "api_creation" {
  type        = string
  description = "When restriction is enabled, only users, including the account owner, assigned the User API key creator role on the IAM Identity Service can create API keys. Allowed values are 'RESTRICTED', 'NOT_RESTRICTED', or 'NOT_SET' (to 'unset' a previous set value), has no effect when `skip_iam_account_settings` is true."
  default     = "RESTRICTED"
}

variable "enforce_allowed_ip_addresses" {
  type        = bool
  description = "Whether the IP address restriction is enforced. Set the value to `false` to test the impact of the restriction on your account, once the impact of the restriction has been observed set the value to `true`."
  default     = true
}

variable "inactive_session_timeout" {
  type        = string
  description = "Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle, has no effect when `skip_iam_account_settings` is true."
  default     = "7200"
}

variable "max_sessions_per_identity" {
  type        = string
  description = "Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than '0', or 'NOT_SET' to unset account setting and use service default, has no effect when `skip_iam_account_settings` is true."
  default     = "NOT_SET"
}

variable "mfa" {
  type        = string
  description = "Specify Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users), has no effect when `skip_iam_account_settings` is true."
  default     = "TOTP4ALL"
}

variable "public_access_enabled" {
  type        = bool
  description = "Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not, has no effect when `skip_iam_account_settings` is true."
  default     = false
}

variable "refresh_token_expiration" {
  type        = string
  description = "Defines the refresh token expiration in seconds, has no effect when `skip_iam_account_settings` is true."
  default     = "259200"
}

variable "serviceid_creation" {
  type        = string
  description = "When restriction is enabled, only users, including the account owner, assigned the Service ID creator role on the IAM Identity Service can create service IDs, has no effect when `skip_iam_account_settings` is true. Allowed values are 'RESTRICTED', 'NOT_RESTRICTED', or 'NOT_SET' (to 'unset' a previous set value)."
  default     = "RESTRICTED"
}

variable "shell_settings_enabled" {
  type        = bool
  description = "Enable global shell settings to all users in the account, has no effect when `skip_iam_account_settings` is true."
  default     = false
}

variable "skip_cloud_shell_calls" {
  type        = bool
  description = "Skip Cloud Shell calls in the account, has no effect when `skip_iam_account_settings` is true."
  default     = false
}

variable "user_mfa" {
  type = set(object({
    iam_id = string
    mfa    = string
  }))
  description = "Specify Multi-Factor Authentication method for specific users the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage, has no effect when `skip_iam_account_settings` is true."
  default     = []
}

variable "user_mfa_reset" {
  type        = bool
  description = "Set to true to delete all user MFA settings configured in the targeted account, and ignoring entries declared in var user_mfa, has no effect when `skip_iam_account_settings` is true."
  default     = false
}

########################################################################################################################
# Trusted Profile Variables
########################################################################################################################

variable "provision_trusted_profile_projects" {
  type        = bool
  description = "Controls whether the Trusted Profile for Projects is provisioned."
  default     = true
}

variable "trusted_profile_name" {
  type        = string
  description = "Name of the trusted profile, required if `provision_trusted_profile_projects` is true."
  default     = null

  validation {
    condition     = !var.provision_trusted_profile_projects || var.trusted_profile_name != null
    error_message = "`trusted_profile_name` is required if `provision_trusted_profile_projects` is true."
  }
}

variable "trusted_profile_description" {
  type        = string
  description = "Description of the trusted profile."
  default     = "Trusted Profile for Projects access"
}

variable "trusted_profile_roles" {
  type        = list(string)
  description = "List of roles given to the trusted profile."
  default     = ["Administrator"]
}

########################################################################################################################
# CBR Variables
########################################################################################################################

variable "provision_cbr" {
  type        = bool
  description = "Whether to enable the creation of context-based restriction rules and zones in the module. Default is false."
  default     = false
}

variable "cbr_prefix" {
  type        = string
  description = "String to use as the prefix for all context-based restriction resources, default is `account-infra-base` if `provision_cbr` is set to true."
  default     = "acct-infra-base"
}

variable "cbr_allow_cos_to_kms" {
  type        = bool
  description = "Whether to enable the rule that allows Object Storage to access the key management service. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_block_storage_to_kms" {
  type        = bool
  description = "Whether to enable the rule that allows Block Storage for VPC to access the key management service. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_roks_to_kms" {
  type        = bool
  description = "Whether to enable the rule that allows Red Hat OpenShift to access the key management service. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_icd_to_kms" {
  type        = bool
  description = "Whether to enable the rule that allows IBM cloud databases to access the key management service. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_event_streams_to_kms" {
  type        = bool
  description = "Whether to enable the rule that allows Event Streams to access the key management service. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_vpcs_to_container_registry" {
  type        = bool
  description = "Whether to enable the rule that allows Virtual Private Clouds to access Container Registry. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_vpcs_to_cos" {
  type        = bool
  description = "Whether to enable the rule that allows Virtual Private Clouds to access Object Storage. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_vpcs_to_iam_groups" {
  type        = bool
  description = "Whether to enable the rule that allows Virtual Private Clouds to access IAM groups. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_vpcs_to_iam_access_management" {
  type        = bool
  description = "Whether to enable the rule that allows Virtual Private Clouds to IAM access management. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_at_to_cos" {
  type        = bool
  description = "Whether to enable the rule that allows Activity Tracker to access Object Storage. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_iks_to_is" {
  type        = bool
  description = "Whether to enable the rule that allows the Kubernetes Service to access VPC Infrastructure Services. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_is_to_cos" {
  type        = bool
  description = "Whether to enable the rule that allows VPC Infrastructure Services to access Object Storage. Default is true if `provision_cbr` is set to true."
  default     = true
}

variable "cbr_allow_scc_to_cos" {
  type        = bool
  description = "Set rule for SCC (Security and Compliance Center) to COS. Default is true if `provision_cbr` is true."
  default     = true
}

variable "cbr_kms_service_targeted_by_prewired_rules" {
  type        = list(string)
  description = "IBM Cloud offers two distinct Key Management Services (KMS): Key Protect and Hyper Protect Crypto Services (HPCS). This variable determines the specific KMS service to which the pre-configured rules are applied. Use the value 'key-protect' to specify the Key Protect service, and 'hs-crypto' for the Hyper Protect Crypto Services (HPCS). Default is `[\"hs-crypto\"]` if `provision_cbr` is set to true."
  default     = ["hs-crypto"]
}

variable "cbr_target_service_details" {
  type = map(object({
    description      = optional(string)
    target_rg        = optional(string)
    instance_id      = optional(string)
    enforcement_mode = string
    tags             = optional(list(string))
    region           = optional(string)
    geography        = optional(string)
    global_deny      = optional(bool, true)
  }))
  description = "Details of the target service for which a rule is created. The key is the service name."
  default     = {}
}
