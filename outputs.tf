########################################################################################################################
# Outputs
########################################################################################################################

output "single_resource_group_id" {
  value       = local.single_resource_group.id
  description = "ID of the resource group created by the module."
}

output "single_resource_group_name" {
  value       = local.single_resource_group.name
  description = "Name of the resource group created by the module."
}

output "security_resource_group_id" {
  value       = local.security_resource_group.id
  description = "ID of the resource group created for security-related resources."
}

output "security_resource_group_name" {
  value       = local.security_resource_group.name
  description = "Name of the resource group created for security-related resources."
}

output "audit_resource_group_id" {
  value       = local.audit_resource_group.id
  description = "ID of the resource group created for audit-related resources."
}

output "audit_resource_group_name" {
  value       = local.audit_resource_group.name
  description = "Name of the resource group created for audit-related resources."
}

output "observability_resource_group_id" {
  value       = local.observability_resource_group.id
  description = "ID of the resource group created for observability-related resources."
}

output "observability_resource_group_name" {
  value       = local.observability_resource_group.name
  description = "Name of the resource group created for observability-related resources."
}

output "management_resource_group_id" {
  value       = local.management_resource_group.id
  description = "ID of the resource group created for management-related resources."
}

output "management_resource_group_name" {
  value       = local.management_resource_group.name
  description = "Name of the resource group created for management-related resources."
}

output "workload_resource_group_id" {
  value       = local.workload_resource_group.id
  description = "ID of the resource group created for workload-related resources."
}

output "workload_resource_group_name" {
  value       = local.workload_resource_group.name
  description = "Name of the resource group created for workload-related resources."
}

output "edge_resource_group_id" {
  value       = local.edge_resource_group.id
  description = "ID of the resource group created for edge network-related resources."
}

output "edge_resource_group_name" {
  value       = local.edge_resource_group.name
  description = "Name of the resource group created for edge network-related resources."
}

output "devops_resource_group_id" {
  value       = local.devops_resource_group.id
  description = "ID of the resource group created for devops-related resources."
}

output "devops_resource_group_name" {
  value       = local.devops_resource_group.name
  description = "Name of the resource group created for devops-related resources."
}

output "account_allowed_ip_addresses" {
  value       = one(module.account_settings[*].account_allowed_ip_addresses)
  description = "Account settings allowed IP addresses"
}

output "account_allowed_ip_addresses_control_mode" {
  value       = one(module.account_settings[*].account_allowed_ip_addresses_control_mode)
  description = "Account settings allowed IP addresses control mode"
}

output "account_allowed_ip_addresses_enforced" {
  value       = one(module.account_settings[*].account_allowed_ip_addresses_enforced)
  description = "Account settings allowed IP addresses enforced"
}

output "account_iam_access_token_expiration" {
  value       = one(module.account_settings[*].account_iam_access_token_expiration)
  description = "Account eettings IAM access token expiration"
}

output "account_iam_active_session_timeout" {
  value       = one(module.account_settings[*].account_iam_active_session_timeout)
  description = "Account settings IAM active session timeout"
}

output "account_iam_apikey_creation" {
  value       = one(module.account_settings[*].account_iam_apikey_creation)
  description = "Account settings IAM API key creation"
}

output "account_iam_inactive_session_timeout" {
  value       = one(module.account_settings[*].account_iam_inactive_session_timeout)
  description = "Account settings IAM inactive session timeout"
}

output "account_iam_mfa" {
  value       = one(module.account_settings[*].account_iam_mfa)
  description = "Account settings IAM MFA"
}

output "account_iam_refresh_token_expiration" {
  value       = one(module.account_settings[*].account_iam_refresh_token_expiration)
  description = "Account settings IAM refresh token expiration"
}

output "account_iam_serviceid_creation" {
  value       = one(module.account_settings[*].account_iam_serviceid_creation)
  description = "Account settings IAM service ID creation"
}

output "account_iam_user_mfa_list" {
  value       = one(module.account_settings[*].account_iam_user_mfa_list)
  description = "Account settings IAM user MFA list"
}

output "account_public_access" {
  value       = one(module.account_settings[*].account_public_access)
  description = "Account settings public access"
}

output "account_shell_settings_status" {
  value       = one(module.account_settings[*].account_shell_settings_status)
  description = "Account settings shell settings status"
}

output "trusted_profile_projects" {
  value       = one(module.trusted_profile_projects[*].trusted_profile)
  description = "Trusted profile for IBM Cloud projects"
}

output "trusted_profile_projects_claim_rules" {
  value       = one(module.trusted_profile_projects[*].trusted_profile_claim_rules)
  description = "Trusted profile IBM Cloud projects profile claim rules"
}

output "trusted_profile_projects_links" {
  value       = one(module.trusted_profile_projects[*].trusted_profile_links)
  description = "Trusted profile IBM Cloud projects profile links"
}

output "trusted_profile_projects_policies" {
  value       = one(module.trusted_profile_projects[*].trusted_profile_policies)
  description = "Policies for the trusted profile for IBM Cloud projects"
}

output "cbr_map_service_ref_name_zoneid" {
  value       = one(module.cbr_fscloud[*].map_service_ref_name_zoneid)
  description = "Map of service references and zone IDs"
}

output "cbr_map_target_service_rule_ids" {
  value       = one(module.cbr_fscloud[*].map_target_service_rule_ids)
  description = "Map of target services and rule IDs"
}

output "cbr_map_vpc_zoneid" {
  value       = one(module.cbr_fscloud[*].map_vpc_zoneid)
  description = "Map of VPC and zone ID"
}
