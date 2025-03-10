########################################################################################################################
# Base Account
########################################################################################################################

locals {
  prefix = var.provision_activity_tracker_cos ? (var.prefix != null && var.prefix != "" ? lower(var.prefix) : null) : var.prefix
  target_service_details = {
    "IAM" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "apprapp" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "cloud-object-storage" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "codeengine" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "compliance" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "container-registry" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "containers-kubernetes" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "containers-kubernetes-cluster" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "containers-kubernetes-management" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "databases-for-cassandra" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "databases-for-elasticsearch" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "databases-for-enterprisedb" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "databases-for-etcd" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "databases-for-mongodb" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "databases-for-mysql" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "databases-for-postgresql" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "databases-for-redis" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "directlink" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "dns-svcs" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "event-notifications" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "globalcatalog-collection" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "hs-crypto" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "iam-access-management" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "iam-groups" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "iam-identity" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "is" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "kms" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "logdna" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "logdnaat" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "messagehub" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "messages-for-rabbitmq" = {
      enforcement_mode = var.cbr_enforcement_mode == "report" ? "disabled" : var.cbr_enforcement_mode
      global_deny      = false
    }
    "schematics" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "secrets-manager" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "sysdig-monitor" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "sysdig-secure" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "transit" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "user-management" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "logs" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
  }
}

module "account_infrastructure_base" {
  source = "../.."
  region = var.region

  # resource groups
  audit_resource_group_name                  = try("${local.prefix}-${var.audit_resource_group_name}", var.audit_resource_group_name, null)
  existing_audit_resource_group_name         = var.existing_audit_resource_group_name
  devops_resource_group_name                 = try("${local.prefix}-${var.devops_resource_group_name}", var.devops_resource_group_name, null)
  existing_devops_resource_group_name        = var.existing_devops_resource_group_name
  edge_resource_group_name                   = try("${local.prefix}-${var.edge_resource_group_name}", var.edge_resource_group_name, null)
  existing_edge_resource_group_name          = var.existing_edge_resource_group_name
  management_resource_group_name             = try("${local.prefix}-${var.management_resource_group_name}", var.management_resource_group_name, null)
  existing_management_resource_group_name    = var.existing_management_resource_group_name
  observability_resource_group_name          = try("${local.prefix}-${var.observability_resource_group_name}", var.observability_resource_group_name, null)
  existing_observability_resource_group_name = var.existing_observability_resource_group_name
  security_resource_group_name               = try("${local.prefix}-${var.security_resource_group_name}", var.security_resource_group_name, null)
  existing_security_resource_group_name      = var.existing_security_resource_group_name
  workload_resource_group_name               = try("${local.prefix}-${var.workload_resource_group_name}", var.workload_resource_group_name, null)
  existing_workload_resource_group_name      = var.existing_workload_resource_group_name

  # atracker + cos
  provision_atracker_cos               = var.provision_activity_tracker_cos
  skip_cos_kms_auth_policy             = var.skip_cos_kms_iam_auth_policy
  cos_instance_name                    = !var.provision_activity_tracker_cos ? null : (var.cos_instance_name == null ? try("${local.prefix}-cos-instance", "cos-instance") : var.cos_instance_name)
  cos_bucket_name                      = !var.provision_activity_tracker_cos ? null : (var.cos_bucket_name == null ? try("${local.prefix}-cos-bucket", "cos-bucket") : lower(var.cos_bucket_name))
  cos_target_name                      = !var.provision_activity_tracker_cos ? null : (var.cos_target_name == null ? try("${local.prefix}-cos-target", "cos-target") : var.cos_target_name)
  activity_tracker_route_name          = var.activity_tracker_route_name == null ? try("${local.prefix}-cos-route", "cos-route") : var.activity_tracker_route_name
  cos_bucket_management_endpoint_type  = var.cos_bucket_management_endpoint_type
  kms_key_crn                          = var.kms_key_crn
  resource_tags                        = var.cos_instance_tags
  cos_plan                             = var.cos_plan
  cos_instance_access_tags             = var.cos_instance_access_tags
  cos_bucket_access_tags               = var.cos_bucket_access_tags
  cos_bucket_expire_enabled            = var.enable_bucket_expiry
  cos_bucket_expire_days               = var.cos_bucket_expire_days
  cos_bucket_object_versioning_enabled = var.enable_cos_bucket_object_versioning
  cos_bucket_storage_class             = var.cos_bucket_storage_class
  cos_bucket_archive_enabled           = var.enable_cos_bucket_archival
  cos_bucket_archive_days              = var.cos_bucket_archive_days
  cos_bucket_archive_type              = var.cos_bucket_archive_type
  cos_bucket_retention_enabled         = var.enable_cos_bucket_retention
  cos_bucket_retention_default         = var.cos_bucket_default_retention_days
  cos_bucket_retention_maximum         = var.cos_bucket_maximum_retention_days
  cos_bucket_retention_minimum         = var.cos_bucket_minimum_retention_days
  cos_bucket_retention_permanent       = var.enable_cos_bucket_permanent_retention
  skip_atracker_cos_iam_auth_policy    = var.skip_activity_tracker_cos_iam_auth_policy
  activity_tracker_locations           = var.activity_tracker_locations

  # iam account settings
  skip_iam_account_settings    = var.skip_iam_account_settings
  allowed_ip_addresses         = var.allowed_ip_addresses
  access_token_expiration      = var.access_token_expiration
  active_session_timeout       = var.active_session_timeout
  api_creation                 = var.api_creation
  enforce_allowed_ip_addresses = var.enforce_allowed_ip_addresses
  inactive_session_timeout     = var.inactive_session_timeout
  max_sessions_per_identity    = var.max_sessions_per_identity
  mfa                          = var.mfa
  public_access_enabled        = var.enable_public_access
  refresh_token_expiration     = var.refresh_token_expiration
  serviceid_creation           = var.serviceid_creation
  shell_settings_enabled       = var.enable_shell_settings
  skip_cloud_shell_calls       = var.skip_cloud_shell_calls
  user_mfa                     = var.user_mfa
  user_mfa_reset               = var.user_mfa_reset

  # trusted profile
  trusted_profile_name               = var.trusted_profile_name == null ? try("${local.prefix}-trusted-profile", "projects-trusted-profile") : var.trusted_profile_name
  provision_trusted_profile_projects = var.provision_trusted_profile_projects
  trusted_profile_description        = var.trusted_profile_description
  trusted_profile_roles              = var.trusted_profile_roles

  # cbr
  provision_cbr                              = var.provision_cbr
  cbr_prefix                                 = coalesce(var.prefix, "aib-cbr")
  cbr_target_service_details                 = local.target_service_details
  cbr_kms_service_targeted_by_prewired_rules = var.cbr_kms_service_targeted_by_prewired_rules
}
