########################################################################################################################
# Base Account
########################################################################################################################

module "account_infrastructure_base" {
  source = "../.."
  providers = {
    logdna.at = logdna.at
    logdna.ld = logdna.ld
  }
  region                              = var.region
  provision_atracker_cos              = var.provision_atracker_cos
  security_resource_group_name        = var.security_resource_group_name != null ? "${var.prefix}-${var.security_resource_group_name}" : null
  audit_resource_group_name           = var.audit_resource_group_name != null ? "${var.prefix}-${var.audit_resource_group_name}" : null
  observability_resource_group_name   = var.observability_resource_group_name != null ? "${var.prefix}-${var.observability_resource_group_name}" : null
  management_resource_group_name      = var.management_resource_group_name != null ? "${var.prefix}-${var.management_resource_group_name}" : null
  workload_resource_group_name        = var.workload_resource_group_name != null ? "${var.prefix}-${var.workload_resource_group_name}" : null
  edge_resource_group_name            = var.edge_resource_group_name != null ? "${var.prefix}-${var.edge_resource_group_name}" : null
  devops_resource_group_name          = var.devops_resource_group_name != null ? "${var.prefix}-${var.devops_resource_group_name}" : null
  existing_cos_resource_group_name    = var.existing_cos_resource_group_name
  cos_instance_name                   = "${var.prefix}-cos-instance"
  cos_bucket_name                     = "${var.prefix}-cos-bucket"
  trusted_profile_name                = "${var.prefix}-trusted-profile"
  cos_target_name                     = "${var.prefix}-cos-target"
  cos_bucket_management_endpoint_type = var.cos_bucket_management_endpoint_type
  activity_tracker_route_name         = "${var.prefix}-cos-route"
  kms_key_crn                         = var.kms_key_crn
  resource_tags                       = var.resource_tags
  allowed_ip_addresses                = var.allowed_ip_addresses
}
