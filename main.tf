##############################################################################
# Account infrastructure base module
##############################################################################

locals {
  # resource group logic
  rg_vars = {
    single_resource_group        = !var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : null,
    security_resource_group      = !var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : !var.use_existing_security_resource_group ? var.security_resource_group_name : null,
    audit_resource_group         = !var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : !var.use_existing_audit_resource_group ? var.audit_resource_group_name : null,
    observability_resource_group = !var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : !var.use_existing_observability_resource_group ? var.observability_resource_group_name : null,
    management_resource_group    = !var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : !var.use_existing_management_resource_group ? var.management_resource_group_name : null,
    workload_resource_group      = !var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : !var.use_existing_workload_resource_group ? var.workload_resource_group_name : null,
    edge_resource_group          = !var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : !var.use_existing_edge_resource_group ? var.edge_resource_group_name : null,
    devops_resource_group        = !var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : !var.use_existing_devops_resource_group ? var.devops_resource_group_name : null
  }
  rg_list = distinct(compact(values(local.rg_vars)))

  rg_map = { for name in local.rg_list :
    name => [for k, v in local.rg_vars : k if name == v]
  }

  #existing resource group logic
  existing_rg_vars = {
    existing_single_resource_group        = var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : null,
    existing_security_resource_group      = var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : var.use_existing_security_resource_group ? var.security_resource_group_name : null,
    existing_audit_resource_group         = var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : var.use_existing_audit_resource_group ? var.audit_resource_group_name : null,
    existing_observability_resource_group = var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : var.use_existing_observability_resource_group ? var.observability_resource_group_name : null,
    existing_management_resource_group    = var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : var.use_existing_management_resource_group ? var.management_resource_group_name : null,
    existing_workload_resource_group      = var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : var.use_existing_workload_resource_group ? var.workload_resource_group_name : null,
    existing_edge_resource_group          = var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : var.use_existing_edge_resource_group ? var.edge_resource_group_name : null,
    existing_devops_resource_group        = var.use_existing_single_resource_group && var.single_resource_group_name != null ? var.single_resource_group_name : var.use_existing_devops_resource_group ? var.devops_resource_group_name : null
  }

  existing_rg_list = distinct(compact(values(local.existing_rg_vars)))

  existing_rg_map = { for name in local.existing_rg_list :
    name => [for k, v in local.rg_vars : k if name == v]
  }

  # resource group outputs
  single_resource_group = local.existing_rg_vars["existing_single_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_single_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_single_resource_group"]].resource_group_name
    } : local.rg_vars["single_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["single_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["single_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  security_resource_group = local.existing_rg_vars["existing_security_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_security_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_security_resource_group"]].resource_group_name
    } : local.rg_vars["security_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["security_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["security_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  audit_resource_group = local.existing_rg_vars["existing_audit_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_audit_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_audit_resource_group"]].resource_group_name
    } : local.rg_vars["audit_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["audit_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["audit_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  observability_resource_group = local.existing_rg_vars["existing_observability_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_observability_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_observability_resource_group"]].resource_group_name
    } : local.rg_vars["observability_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["observability_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["observability_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  management_resource_group = local.existing_rg_vars["existing_management_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_management_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_management_resource_group"]].resource_group_name
    } : local.rg_vars["management_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["management_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["management_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  workload_resource_group = local.existing_rg_vars["existing_workload_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_workload_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_workload_resource_group"]].resource_group_name
    } : local.rg_vars["workload_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["workload_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["workload_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  edge_resource_group = local.existing_rg_vars["existing_edge_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_edge_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_edge_resource_group"]].resource_group_name
    } : local.rg_vars["edge_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["edge_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["edge_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
  devops_resource_group = local.existing_rg_vars["existing_devops_resource_group"] != null ? {
    id   = module.existing_resource_group[local.existing_rg_vars["existing_devops_resource_group"]].resource_group_id
    name = module.existing_resource_group[local.existing_rg_vars["existing_devops_resource_group"]].resource_group_name
    } : local.rg_vars["devops_resource_group"] != null ? {
    id   = module.resource_group[local.rg_vars["devops_resource_group"]].resource_group_id
    name = module.resource_group[local.rg_vars["devops_resource_group"]].resource_group_name
    } : {
    id   = null
    name = null
  }
}

module "resource_group" {
  for_each            = local.rg_map
  source              = "terraform-ibm-modules/resource-group/ibm"
  version             = "1.2.1"
  resource_group_name = each.key
}

moved {
  from = module.existing_resource_group[0]
  to   = module.existing_resource_group["existing_observability_resource_group"]
}

module "existing_resource_group" {
  for_each                     = local.existing_rg_map
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.2.1"
  existing_resource_group_name = each.key
}

moved {
  from = module.account_settings
  to   = module.account_settings[0]
}

module "account_settings" {
  count                        = !var.skip_iam_account_settings ? 1 : 0
  source                       = "terraform-ibm-modules/iam-account-settings/ibm"
  version                      = "2.12.0"
  access_token_expiration      = var.access_token_expiration
  active_session_timeout       = var.active_session_timeout
  allowed_ip_addresses         = var.allowed_ip_addresses
  api_creation                 = var.api_creation
  enforce_allowed_ip_addresses = var.enforce_allowed_ip_addresses
  inactive_session_timeout     = var.inactive_session_timeout
  max_sessions_per_identity    = var.max_sessions_per_identity
  mfa                          = var.mfa
  public_access_enabled        = var.public_access_enabled
  refresh_token_expiration     = var.refresh_token_expiration
  serviceid_creation           = var.serviceid_creation
  shell_settings_enabled       = var.shell_settings_enabled
  user_mfa                     = var.user_mfa
  user_mfa_reset               = var.user_mfa_reset
  skip_cloud_shell_calls       = var.skip_cloud_shell_calls
}

moved {
  from = module.trusted_profile_projects
  to   = module.trusted_profile_projects[0]
}

module "trusted_profile_projects" {
  count                       = var.provision_trusted_profile_projects ? 1 : 0
  source                      = "terraform-ibm-modules/trusted-profile/ibm"
  version                     = "2.3.1"
  trusted_profile_name        = var.trusted_profile_name
  trusted_profile_description = var.trusted_profile_description
  trusted_profile_policies = [{
    roles = var.trusted_profile_roles
    resources = [{
      service = "project"
    }]
  }]
}

module "cbr_fscloud" {
  count                                  = var.provision_cbr ? 1 : 0
  source                                 = "terraform-ibm-modules/cbr/ibm//modules/fscloud"
  version                                = "1.32.5"
  prefix                                 = var.cbr_prefix
  zone_vpc_crn_list                      = []
  allow_cos_to_kms                       = var.cbr_allow_cos_to_kms
  allow_block_storage_to_kms             = var.cbr_allow_block_storage_to_kms
  allow_roks_to_kms                      = var.cbr_allow_roks_to_kms
  allow_icd_to_kms                       = var.cbr_allow_icd_to_kms
  allow_event_streams_to_kms             = var.cbr_allow_event_streams_to_kms
  allow_vpcs_to_container_registry       = var.cbr_allow_vpcs_to_container_registry
  allow_vpcs_to_cos                      = var.cbr_allow_vpcs_to_cos
  allow_at_to_cos                        = var.cbr_allow_at_to_cos
  allow_iks_to_is                        = var.cbr_allow_iks_to_is
  allow_is_to_cos                        = var.cbr_allow_is_to_cos
  allow_scc_to_cos                       = var.cbr_allow_scc_to_cos
  allow_vpcs_to_iam_groups               = var.cbr_allow_vpcs_to_iam_groups
  allow_vpcs_to_iam_access_management    = var.cbr_allow_vpcs_to_iam_access_management
  kms_service_targeted_by_prewired_rules = var.cbr_kms_service_targeted_by_prewired_rules
  target_service_details                 = var.cbr_target_service_details
}
