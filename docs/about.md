# Cloud automation for Account Configuration

This deployable architecture prepares your IBM Cloud account with the necessary configurations to ensure a secure and organized environment for your architecture.

This deployable architecture is **typically consumed as a dependency** by other IBM Cloud deployable architectures published in the catalog, providing the foundational account setup they require.

You can choose from two variations when deploying:

* **Resource groups only**: Creates a structured set of IBM Cloud resource groups to help organize cloud resources by function.
* **Resource groups with Account Settings**: In addition to resource groups, configures account-level settings for access control, security, and compliance alignment.

---

## Resource Groups – Organizing Your Cloud Resources

IBM Cloud uses Resource Groups to help organize and manage your cloud resources, similar to folders on your computer.

It provisions an opinionated structure of labeled resource groups for clearer separation of responsibilities and improved access control.

| Category      | Default Resource Group Name | Suggested Use Case                                                          |
| ------------- | --------------------------- | --------------------------------------------------------------------------- |
| Security      | `security-rg`               | Security resources, such as Key Protect, Secrets Manager etc                |
| Audit Logs    | `audit-rg`                  | Auditing resources                                                          |
| Monitoring    | `observability-rg`          | Monitoring resources, such as Log Analysis, Monitoring and Event Management |
| Management    | `management-plane-rg`       | Management resources                                                        |
| Workloads     | `workload-rg`               | Workload resources, such as VSI, Kubernetes, OpenShift etc                  |
| Edge Services | `edge-rg`                   | Edge services, such as Cloud Internet Services                              |
| DevOps Tools  | `devops-tools-rg`           | DevOps tools, such as Toolchain, Toolchain Service etc                      |

**Note:** If you're using a single resource group, all categories will share that group.

**Tip:** Deployable architectures that depend on **Cloud automation for Account Configuration** will automatically map resources to the appropriate group if this structure is enabled.

**Important:** To customize group names or disable the opinionated structure, edit the **Cloud automation for Account Configuration** configuration in your IBM Cloud Project [more details](./resource-group-configuration.md).

---

## Account Settings – Enhancing Security, Access Control, and Compliance

All account settings applied by this deployable architecture can be customized through input parameters in the deployable architecture interface (DA). This includes options for session timeout values, trusted profile names, and CBR configuration.

When using the **Resource groups with Account Settings** variation, the following defaults are applied to improve your account's security posture and readiness for regulated workloads:

* **IAM Session Timeout and Access Token Expiry**: Secure defaults for user and service identity sessions.
* **Context-Based Restrictions (CBRs)**: Configures default zones and rules, especially useful with [IBM Cloud for Financial Services (FS Cloud)](https://cloud.ibm.com/docs/framework-financial-services?topic=framework-financial-services-about).
* **Trusted Profiles and Access Groups**: Provides identity and role-based access foundations for future project-level governance.

**Note:** Some advanced settings—like enabling user list visibility restrictions or FS Validated mode—must be configured manually through the IBM Cloud UI.

---

## Customization

All settings provided by this deployable architecture are configurable. Use the input parameters in the deployable architecture interface (DA) to:

* Rename or disable any resource group
* Enable or skip account settings
* Provide custom trusted profile names, group prefixes, or timeout values

For detailed instructions on customizing the resource group structure, see [resource-groups-configuration.md](./resource-groups-configuration.md).

This flexibility allows teams to enforce enterprise-wide standards or tailor deployments to specific project needs.

---

## Summary

The **Cloud automation for Key Protect** deployable architecture lays a secure and scalable foundation for your IBM Cloud account. Whether you're just organizing workloads or preparing for strict governance and compliance, this deployable architecture can be configured to meet your needs.

For more information, visit the [terraform-ibm-account-infrastructure-base repository](https://github.com/terraform-ibm-modules/terraform-ibm-account-infrastructure-base/tree/main) and the [IBM Cloud account documentation](https://cloud.ibm.com/docs/account).
