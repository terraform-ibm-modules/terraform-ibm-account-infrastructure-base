########################################################################################################################
# Account Variables
########################################################################################################################

variable "security_resource_group_name" {
  type        = string
  description = "The name of the security resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.security_resource_group_name, "null")) <= 40
    error_message = "`var.security_resource_group_name` must be 40 characters or less."
  }
}

variable "audit_resource_group_name" {
  type        = string
  description = "The name of the audit resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.audit_resource_group_name, "null")) <= 40
    error_message = "`var.audit_resource_group_name` must be 40 characters or less."
  }
}

variable "observability_resource_group_name" {
  type        = string
  description = "The name of the observability resource group to create. Required if `var.provision_atracker_cos` is true and `var.existing_cos_resource_group_name` is not provided."
  default     = null

  validation {
    condition     = length(coalesce(var.observability_resource_group_name, "null")) <= 40
    error_message = "`var.observability_resource_group_name` must be 40 characters or less."
  }
}

variable "management_resource_group_name" {
  type        = string
  description = "The name of the management resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.management_resource_group_name, "null")) <= 40
    error_message = "`var.management_resource_group_name` must be 40 characters or less."
  }
}

variable "workload_resource_group_name" {
  type        = string
  description = "The name of the workload resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.workload_resource_group_name, "null")) <= 40
    error_message = "`var.workload_resource_group_name` must be 40 characters or less."
  }
}

variable "edge_resource_group_name" {
  type        = string
  description = "The name of the edge resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.edge_resource_group_name, "null")) <= 40
    error_message = "`var.edge_resource_group_name` must be 40 characters or less."
  }
}

variable "devops_resource_group_name" {
  type        = string
  description = "The name of the devops resource group to create."
  default     = null

  validation {
    condition     = length(coalesce(var.devops_resource_group_name, "null")) <= 40
    error_message = "`var.devops_resource_group_name` must be 40 characters or less."
  }
}

variable "existing_cos_resource_group_name" {
  type        = string
  description = "The name of an existing resource group to use for the COS instance/bucket, required if `var.provision_artacker_cos` is true and `var.observability_resource_group_name` is not provided."
  default     = null
}

variable "access_token_expiration" {
  type        = string
  description = "Defines the access token expiration in seconds"
  default     = "3600"
}

variable "active_session_timeout" {
  type        = number
  description = "Specify how long (seconds) a user is allowed to work continuously in the account"
  default     = 3600
}

variable "allowed_ip_addresses" {
  type        = list(any)
  description = "List of the IP addresses and subnets from which IAM tokens can be created for the account."
  default     = []
}

variable "api_creation" {
  type        = string
  description = "When restriction is enabled, only users, including the account owner, assigned the User API key creator role on the IAM Identity Service can create API keys. Allowed values are 'RESTRICTED', 'NOT_RESTRICTED', or 'NOT_SET' (to 'unset' a previous set value)."
  default     = "RESTRICTED"
}

variable "enforce_allowed_ip_addresses" {
  type        = bool
  description = "If true IP address restriction will be enforced, If false, traffic originated outside specified allowed IP address set is monitored with audit events sent to SIEM and Activity Tracker. After running in monitored mode to test this variable, it should then explicitly be set to true to enforce IP allow listing."
  default     = true
}

variable "inactive_session_timeout" {
  type        = string
  description = "Specify how long (seconds) a user is allowed to stay logged in the account while being inactive/idle"
  default     = "900"
}

variable "max_sessions_per_identity" {
  type        = string
  description = "Defines the maximum allowed sessions per identity required by the account. Supports any whole number greater than '0', or 'NOT_SET' to unset account setting and use service default."
  default     = "NOT_SET"
}

variable "mfa" {
  type        = string
  description = "Specify Multi-Factor Authentication method in the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users)."
  default     = "TOTP4ALL"
}

variable "public_access_enabled" {
  type        = bool
  description = "Enable/Disable public access group in which resources are open anyone regardless if they are member of your account or not"
  default     = false
}

variable "refresh_token_expiration" {
  type        = string
  description = "Defines the refresh token expiration in seconds"
  default     = "259200"
}

variable "serviceid_creation" {
  type        = string
  description = "When restriction is enabled, only users, including the account owner, assigned the Service ID creator role on the IAM Identity Service can create service IDs. Allowed values are 'RESTRICTED', 'NOT_RESTRICTED', or 'NOT_SET' (to 'unset' a previous set value)."
  default     = "RESTRICTED"
}

variable "shell_settings_enabled" {
  type        = bool
  description = "Enable global shell settings to all users in the account"
  default     = false
}

variable "user_mfa" {
  type = set(object({
    iam_id = string
    mfa    = string
  }))
  description = "Specify Multi-Factor Authentication method for specific users the account. Supported valid values are 'NONE' (No MFA trait set), 'TOTP' (For all non-federated IBMId users), 'TOTP4ALL' (For all users), 'LEVEL1' (Email based MFA for all users), 'LEVEL2' (TOTP based MFA for all users), 'LEVEL3' (U2F MFA for all users). Example of format is available here > https://github.com/terraform-ibm-modules/terraform-ibm-iam-account-settings#usage"
  default     = []
}

variable "user_mfa_reset" {
  type        = bool
  description = "Set to true to delete all user MFA settings configured in the targeted account, and ignoring entries declared in var user_mfa"
  default     = false
}

########################################################################################################################
# COS Variables
########################################################################################################################

variable "provision_atracker_cos" {
  type        = bool
  description = "Enable to create an Atracker route and COS instance + bucket."
  default     = false
}

variable "region" {
  type        = string
  description = "Region to provision the COS resources created by this solution."
  default     = "us-south"
}

variable "cos_plan" {
  type        = string
  description = "Plan of the COS instance created by the module"
  default     = "standard"
}

variable "cos_instance_name" {
  type        = string
  description = "The name to give the cloud object storage instance that will be provisioned by this module, required if 'var.provision_atracker_cos' is true."
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "A list of tags applied to the COS resources created by the module."
  default     = []
}

variable "cos_instance_access_tags" {
  type        = list(string)
  description = "A list of Access Tags applied to the created COS instance."
  default     = []
}

variable "cos_bucket_name" {
  type        = string
  description = "The name to give the newly provisioned COS bucket which will be used for Activity Tracker logs, required if 'var.provision_atracker_cos' is true."
  default     = null
}

variable "cos_bucket_access_tags" {
  type        = list(string)
  description = "A list of Access Tags applied to the created bucket."
  default     = []
}

variable "cos_bucket_expire_enabled" {
  type        = bool
  description = "A flag to control expiry rule on the bucket."
  default     = false
}

variable "cos_bucket_expire_days" {
  type        = number
  description = "Number of days before expiry."
  default     = 365
}

variable "cos_bucket_object_versioning_enabled" {
  type        = bool
  description = "A flag to control object versioning on the bucket."
  default     = false
}

variable "kms_key_crn" {
  type        = string
  description = "CRN of the KMS key to use to encrypt the data in the COS bucket, required if 'var.provision_atracker_cos' is true."
  default     = null
}

variable "cos_bucket_management_endpoint_type" {
  description = "The type of endpoint for the IBM terraform provider to use to manage the bucket. (public, private or direct)"
  type        = string
  default     = "public"
  validation {
    condition     = contains(["public", "private", "direct"], var.cos_bucket_management_endpoint_type)
    error_message = "The specified management_endpoint_type_for_bucket is not a valid selection!"
  }
}

variable "cos_bucket_storage_class" {
  type        = string
  description = "COS Bucket storage class type"
  default     = null
}

variable "cos_bucket_archive_enabled" {
  type        = bool
  description = "Set as true to enable archiving on the COS bucket."
  default     = false
}

variable "cos_bucket_archive_days" {
  type        = number
  description = "Number of days to archive objects in the bucket."
  default     = 20
}

variable "cos_bucket_archive_type" {
  type        = string
  description = "Type of archiving to use on bucket."
  default     = "Glacier"
}

variable "cos_bucket_retention_enabled" {
  type        = bool
  description = "Retention enabled for COS bucket."
  default     = false
}

variable "cos_bucket_retention_default" {
  description = "Specifies default duration of time an object that can be kept unmodified for COS bucket."
  type        = number
  default     = 90
}

variable "cos_bucket_retention_maximum" {
  description = "Specifies maximum duration of time an object that can be kept unmodified for COS bucket."
  type        = number
  default     = 350
}

variable "cos_bucket_retention_minimum" {
  description = "Specifies minimum duration of time an object must be kept unmodified for COS bucket."
  type        = number
  default     = 90
}

variable "cos_bucket_retention_permanent" {
  description = "Specifies a permanent retention status either enable or disable for COS bucket."
  type        = bool
  default     = false
}

variable "cos_bucket_cbr_rules" {
  type = list(object({
    description = string
    account_id  = string
    rule_contexts = list(object({
      attributes = optional(list(object({
        name  = string
        value = string
      })))
    }))
    enforcement_mode = string
    tags = optional(list(object({
      name  = string
      value = string
    })), [])
    operations = optional(list(object({
      api_types = list(object({
        api_type_id = string
      }))
    })))
  }))
  description = "COS Bucket CBR Rules"
  default     = []
}

variable "cos_instance_cbr_rules" {
  type = list(object({
    description = string
    account_id  = string
    rule_contexts = list(object({
      attributes = optional(list(object({
        name  = string
        value = string
      })))
    }))
    enforcement_mode = string
    tags = optional(list(object({
      name  = string
      value = string
    })), [])
    operations = optional(list(object({
      api_types = list(object({
        api_type_id = string
      }))
    })))
  }))
  description = "CBR Rules for the COS instance."
  default     = []
}

########################################################################################################################
# ATracker Variables
########################################################################################################################

variable "skip_atracker_cos_iam_auth_policy" {
  type        = bool
  description = "Set to true to skip the creation of an IAM authorization policy that permits the Activity Tracker service Object Writer access to the Cloud Object Storage instance provisioned by this module. NOTE: If skipping, you must ensure the auth policy exists on the account before running the module."
  default     = false
}

variable "cos_target_name" {
  type        = string
  description = "Name of the COS Target for Activity Tracker, required if 'var.provision_atracker_cos' is true."
  default     = null
}

variable "activity_tracker_route_name" {
  type        = string
  description = "Name of the route for the Activity Tracker, required if 'var.provision_atracker_cos' is true."
  default     = null
}

variable "activity_tracker_locations" {
  type        = list(string)
  description = "Location of the route for the Activity Tracker, logs from these locations will be sent to the specified target. Supports passing individual regions, as well as `global` and `*`."
  default     = ["*", "global"]
}

########################################################################################################################
# Trusted Profile Variables
########################################################################################################################

variable "trusted_profile_name" {
  type        = string
  description = "Name of the trusted profile."
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
