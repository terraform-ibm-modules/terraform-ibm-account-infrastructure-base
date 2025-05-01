########################################################################################################################
# Base Account
########################################################################################################################

locals {
  target_service_details = {
    "apprapp" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "atracker" = {
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
    "codeengine-platform" = {
      enforcement_mode = var.cbr_enforcement_mode
      global_deny      = false
    }
    "codeengine-service-control-plane" = {
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
    "context-based-restrictions" = {
      enforcement_mode : var.cbr_enforcement_mode
      global_deny = false
    },
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
    "ghost-tags" = {
      enforcement_mode = var.cbr_enforcement_mode
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
    "IAM" = {
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
    "logs" = {
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
  }
}

module "account_infrastructure_base" {
  source = "../.."

  # resource groups
  single_resource_group_name                = try("${var.prefix}-${var.single_resource_group_name}", var.single_resource_group_name, null)
  use_existing_single_resource_group        = var.use_existing_single_resource_group
  audit_resource_group_name                 = try("${var.prefix}-${var.audit_resource_group_name}", var.audit_resource_group_name, null)
  use_existing_audit_resource_group         = var.use_existing_audit_resource_group
  devops_resource_group_name                = try("${var.prefix}-${var.devops_resource_group_name}", var.devops_resource_group_name, null)
  use_existing_devops_resource_group        = var.use_existing_devops_resource_group
  edge_resource_group_name                  = try("${var.prefix}-${var.edge_resource_group_name}", var.edge_resource_group_name, null)
  use_existing_edge_resource_group          = var.use_existing_edge_resource_group
  management_resource_group_name            = try("${var.prefix}-${var.management_resource_group_name}", var.management_resource_group_name, null)
  use_existing_management_resource_group    = var.use_existing_management_resource_group
  observability_resource_group_name         = try("${var.prefix}-${var.observability_resource_group_name}", var.observability_resource_group_name, null)
  use_existing_observability_resource_group = var.use_existing_observability_resource_group
  security_resource_group_name              = try("${var.prefix}-${var.security_resource_group_name}", var.security_resource_group_name, null)
  use_existing_security_resource_group      = var.use_existing_security_resource_group
  workload_resource_group_name              = try("${var.prefix}-${var.workload_resource_group_name}", var.workload_resource_group_name, null)
  use_existing_workload_resource_group      = var.use_existing_workload_resource_group

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
  trusted_profile_name               = var.trusted_profile_name == null ? try("${var.prefix}-trusted-profile", "projects-trusted-profile") : var.trusted_profile_name
  provision_trusted_profile_projects = var.provision_trusted_profile_projects
  trusted_profile_description        = var.trusted_profile_description
  trusted_profile_roles              = var.trusted_profile_roles

  # cbr
  provision_cbr                              = var.provision_cbr
  cbr_prefix                                 = coalesce(var.prefix, "aib-cbr")
  cbr_target_service_details                 = local.target_service_details
  cbr_kms_service_targeted_by_prewired_rules = var.cbr_kms_service_targeted_by_prewired_rules
}
