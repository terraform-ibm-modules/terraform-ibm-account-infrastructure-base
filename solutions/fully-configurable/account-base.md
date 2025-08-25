# Cloud Automation for Account Configuration

This deployable architecture is used to create a base layout of resource groups for a new IBM Cloud account and configure the IAM account settings within the account, as well as creating an initial layout of Context Based Restriction (CBR) zones to secure resources within the account and a Trusted Profile for access to IBM Cloud Projects.

## Supported Configuration Options

Below are the different configuration options available within the Cloud Automation for Account Configuration deployable architecture

### Resource Groups

The deployable architecture supports creating one or more resource groups:

- Single resource group
    - When providing a single resource group name, the deployable architecture will only create this group and ignore any of the other resource group names provided

If the single resource group name is not provided, the following resource groups will be created

- Audit resource group
    - A resource group to be used for the provisioning of any audit resources in the account
- Devops resource group
    - A resource group to be used for the provisioning of any devops resources in the account
- Edge resource group
    - A resource group to be used for the provisioning of any edge network resources in the account
- Management resource group
    - A resource group to be used for the provisioning of any management resources in the account
- Observability resource group
    - A resource group to be used for the provisioning of any observability resources in the account
- Security resource group
    - A resource group to be used for the provisioning of any security resources in the account
- Workload resource group
    - A resource group to be used for the provisioning of any workload resources in the account

### IAM Account Settings

The deployable architecture supports controlling the following IAM account settings within the account:

- Multifactor authentication (None - Federated Users - All - Email/TOPT/U2F based)
- User specific Multifactor authentication (None - Federated Users - All - Email/TOPT/U2F based)
- Restrict API key creation (on - off)
- Restrict service ID creation (on - off)
- Session activity timeout (seconds)
- Session inactivity timeout (seconds)
- Access token expiration (seconds)
- Refresh token expiration (seconds)
- Restrict IP address access (off/Any Allowed - on/Allow only specified IP subnets or IP addresses). Two control modes
  are supported:
    - Monitor: traffic that originates outside the specified allowed IP addresses is allowed but logged by audit events
      that are sent to SIEM and Activity Tracker
    - Restrict: traffic that originates outside the specified allowed IP addresses is blocked
- Global shell settings (on - off)
- Public access group (on - off)

### Context Based Restrictions

This deployable architecture can create pre-wired rules for CBR from our [FS Cloud submodule for CBR](https://github.com/terraform-ibm-modules/terraform-ibm-cbr), see [this README](https://github.com/terraform-ibm-modules/terraform-ibm-cbr/tree/main/modules/fscloud#pre-wired-cbr-configuration-for-fs-cloud) for more details on this configuration.

### Trusted Profile for Projects

This deployable architecture supports creating a trusted profile within the account that provides access to manage deployable architectures in IBM Cloud Projects.
