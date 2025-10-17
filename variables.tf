########################################################################################################################
# Account Variables
########################################################################################################################

variable "single_resource_group_name" {
  type        = string
  description = "The name of the resource group to create. When this variable is provided, only one resource group is created and all other resource group name variables are ignored."
  default     = null

  validation {
    condition     = length(coalesce(var.single_resource_group_name, "null")) <= 40
    error_message = "`single_resource_group_name` must be 40 characters or less."
  }
}

variable "use_existing_single_resource_group" {
  type        = bool
  description = "Set to `true` to use an existing resource group that has the name provided in `single_resource_group_name`."
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
  description = "When set to `true`, only resource groups are created and IAM settings are not applied to the account."
  default     = false
}

variable "access_token_expiration" {
  type        = string
  description = "Defines the access token expiration in seconds. This variable is ignored when `skip_iam_account_settings` is set to `true`."
  default     = "3600"
}

variable "active_session_timeout" {
  type        = number
  description = "Specify how long, in seconds, a user is allowed to work continuously in the account. This variable is ignored when `skip_iam_account_settings` is set to `true`."
  default     = 86400
}

variable "allowed_ip_addresses" {
  type        = list(any)
  description = "List of the IP addresses and subnets that can create IAM tokens for the account. This variable is ignored when `skip_iam_account_settings` is set to `true`."
  default     = []
}

variable "api_creation" {
  type        = string
  description = "When this variable is set to `RESTRICTED`, only users who are assigned the User API key creator role on the IAM Identity Service can create API keys, including the account owner. When set to `NOT_SET`, the previous value for this variable is cleared. Allowed values are `RESTRICTED`, `NOT_RESTRICTED`, or `NOT_SET`. This variable is ignored when `skip_iam_account_settings` is set to `true`."
  default     = "RESTRICTED"
}

variable "enforce_allowed_ip_addresses" {
  type        = bool
  description = "Whether the IP address restriction is enforced. Set the value to `false` to test the impact of the restriction on your account. After the impact of the restriction is determined, set the value to `true`."
  default     = true
}

variable "inactive_session_timeout" {
  type        = string
  description = "Specify how long, in seconds, a user is allowed to stay logged in to the account while being inactive or idle. This variable is ignored when `skip_iam_account_settings` is set to `true`."
  default     = "7200"
}

variable "max_sessions_per_identity" {
  type        = string
  description = "Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than `0`, or `NOT_SET` to clear account settings and use the service default. This variable is ignored when `skip_iam_account_settings` is set to `true`."
  default     = "NOT_SET"
}

variable "mfa" {
  type        = string
  description = "Specify a multifactor authentication (MFA) method in the account. Supported valid values are `NONE` (no MFA method set), `TOTP` (for all non-federated IBMid users), `TOTP4ALL` (for all users), `LEVEL1` (email-based MFA for all users), `LEVEL2` (TOTP-based MFA for all users), `LEVEL3` (U2F MFA for all users). If `skip_iam_account_settings` is set to `true`, this variable is ignored."
  default     = "TOTP4ALL"
}

variable "public_access_enabled" {
  type        = bool
  description = "Specifies whether the public access group is available to anyone, regardless of whether they have access to your account or not. When enabled, assigned access policies can make resources accessible without authentication. If `skip_iam_account_settings` is set to true, this variable is ignored."
  default     = false
}

variable "refresh_token_expiration" {
  type        = string
  description = "Defines the refresh token expiration in seconds. If `skip_iam_account_settings` is set to `true`, this variable is ignored."
  default     = "259200"
}

variable "serviceid_creation" {
  type        = string
  description = "When this variable is set to `RESTRICTED`, only users who are assigned the Service ID creator role on the IAM Identity Service can create service IDs, including the account owner. When set to `NOT_SET`, the previous value for this variable is cleared. Allowed values are `RESTRICTED`, `NOT_RESTRICTED`, or `NOT_SET`. This variable is ignored when `skip_iam_account_settings` is set to `true`."
  default     = "RESTRICTED"
}

variable "shell_settings_enabled" {
  type        = bool
  description = "Whether global shell settings for all users in the account are enabled or disabled. This variable is ignored when `skip_iam_account_settings` is set to `true`."
  default     = false
}

variable "skip_cloud_shell_calls" {
  type        = bool
  description = "Skip Cloud Shell calls in the account. This variable is ignored when `skip_iam_account_settings` is set to `true`."
  default     = false
}

variable "user_mfa" {
  type = set(object({
    iam_id = string
    mfa    = string
  }))
  description = "Specify a multifactor authentication (MFA) method for specific users the account. Supported valid values are `NONE` (no MFA method set), `TOTP` (for all non-federated IBMid users), `TOTP4ALL` (for all users), `LEVEL1` (email-based MFA for all users), `LEVEL2` (TOTP-based MFA for all users), `LEVEL3` (U2F MFA for all users). Example format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage. If `skip_iam_account_settings` is set to `true`, this variable is ignored."
  default     = []
}

variable "user_mfa_reset" {
  type        = bool
  description = "Set to `true` to delete all user multifactor authentication (MFA) settings in the target account, and ignore entries declared in `var user_mfa`. If `skip_iam_account_settings` is set to `true`, this variable is ignored."
  default     = false
}

########################################################################################################################
# Trusted Profile Variables
########################################################################################################################

variable "provision_trusted_profile_projects" {
  type        = bool
  description = "Whether the trusted profile that authorizes an IBM Cloud project to deploy to your target account is created."
  default     = true
}

variable "trusted_profile_name" {
  type        = string
  description = "Name of the trusted profile, required if `provision_trusted_profile_projects` is set to `true`."
  default     = null

  validation {
    condition     = !var.provision_trusted_profile_projects || var.trusted_profile_name != null
    error_message = "`trusted_profile_name` is required if `provision_trusted_profile_projects` is set to `true`."
  }
}

variable "trusted_profile_description" {
  type        = string
  description = "Description of the trusted profile."
  default     = "Trusted profile that authorizes the project to deploy to your target account."
}

variable "trusted_profile_roles" {
  type        = list(string)
  description = "List of roles given to the trusted profile."
  default     = ["Administrator"]
}

########################################################################################################################
# Context-Based Restriction Variables
########################################################################################################################

variable "provision_cbr" {
  type        = bool
  description = "Set to `true` to create context-based restriction rules and zones in the module. The default is 'false'."
  default     = false
}

variable "cbr_prefix" {
  type        = string
  description = "String to use as the prefix for all context-based restriction resources, default is `account-infra-base` if `provision_cbr` is set to `true`."
  default     = "acct-infra-base"
}

variable "cbr_allow_cos_to_kms" {
  type        = bool
  description = "Set to `true` to allow Object Storage access to the key management service. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_block_storage_to_kms" {
  type        = bool
  description = "Set to `true` to allow Block Storage for VPC access to the key management service. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_roks_to_kms" {
  type        = bool
  description = "Set to `true` to allow Red Hat OpenShift access to the key management service. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_icd_to_kms" {
  type        = bool
  description = "Set to `true` to allow IBM Cloud databases access to the key management service. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_event_streams_to_kms" {
  type        = bool
  description = "Set to `true` to allow Event Streams access to the key management service. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_vpcs_to_container_registry" {
  type        = bool
  description = "Set to `true` to allow Virtual Private Clouds access to the Container Registry. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_vpcs_to_cos" {
  type        = bool
  description = "Set to `true` to allows Virtual Private Clouds access to Object Storage. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_vpcs_to_iam_groups" {
  type        = bool
  description = "Set to `true` to allows Virtual Private Clouds access to IAM groups. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_vpcs_to_iam_access_management" {
  type        = bool
  description = "Set to `true` to allow Virtual Private Clouds access to IAM access management. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_at_to_cos" {
  type        = bool
  description = "Set to `true` to allow Activity Tracker Event Routing access to Object Storage. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_iks_to_is" {
  type        = bool
  description = "Set to `true` to allow the Kubernetes service access to Virtual Private Cloud Infrastructure Services. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_is_to_cos" {
  type        = bool
  description = "Set to `true` to allow Virtual Private Cloud Infrastructure Services access to Object Storage. Default is `true` if `provision_cbr` is set to `true`."
  default     = true
}

variable "cbr_allow_scc_to_cos" {
  type        = bool
  description = "Set to `true` to allow Security and Compliance Center access to Object Storage. Default is `true` if `provision_cbr` is `true`."
  default     = true
}

variable "cbr_kms_service_targeted_by_prewired_rules" {
  type        = list(string)
  description = "IBM Cloud offers two distinct key management services: Key Protect and Hyper Protect Crypto Services. This variable determines the specific key management service to which the pre-configured rules are applied. Use the value 'key-protect' to specify the Key Protect service, and 'hs-crypto' for Hyper Protect Crypto Services. Default is `[\"hs-crypto\"]` if `provision_cbr` is set to `true`."
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

variable "cbr_allow_scc_wp_to_appconfig" {
  description = "Set to `true` to allow Security and Compliance Center access to App Configuration. Default is `true` if `provision_cbr` is `true`."
  type        = bool
  default     = true
}

variable "cbr_allow_scc_wp_to_cloud_monitoring" {
  description = "Set to `true` to allow Security and Compliance Center access to Cloud Monitoring. Default is `true` if `provision_cbr` is `true`."
  type        = bool
  default     = true
}

variable "appconfig_aggregator_service_access" {
  description = "Set rule for App Configuration to a list of services supported by the configuration aggregator. The default is true. The full list of services can be found [here](https://cloud.ibm.com/docs/app-configuration?topic=app-configuration-ac-configuration-aggregator#ac-list-of-services-configaggregator). However, CBR rules will only be created for the CBR-supported services. Service references in the CBR zone are not supported for databases."
  type        = map(bool)
  default = {
    cloud-object-storage     = true
    is                       = true
    secrets-manager          = true
    IAM                      = true
    kms                      = true
    container-registry       = true
    codeengine               = true
    dns-svcs                 = true
    messagehub               = true
    transit                  = true
    schematics               = true
    sysdig-monitor           = true
    sysdig-secure            = true
    hs-crypto                = true
    apprapp                  = true
    globalcatalog-collection = true
    event-notifications      = true
    atracker                 = true
    logs                     = true
  }
}
