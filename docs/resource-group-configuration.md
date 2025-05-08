# Resource Group Configuration

This **Deployable Architecture** is typically consumed as a dependency by other architectures. It provides a structured set of IBM Cloud resource‑group options to help you organise workloads and apply governance at scale.

The deployable architecture supports multiple ways to define your resource‑group layout—from a single default group to a more opinionated structure for improved separation of duties and access control.

---

## Deploy without Cloud automation for Key Protect

In many cases, a deployable architecture will start by placing all resources in a single resource group—typically the IBM Cloud `Default` group—unless you manually reconfigure it using the available input options.

---

## Deploy with Cloud automation for Key Protect (standard)

When **Cloud automation for Key Protect** is included, it can create an *opinionated* structure of seven resource groups to keep security, audit, workload, and platform components neatly separated:

| Category      | Default Resource Group Name | Typical Use Case                                       |
| ------------- | --------------------------- | ------------------------------------------------------ |
| Security      | `security-rg`               | Key Protect, Secrets Manager, other security services  |
| Audit Logs    | `audit-rg`                  | Activity Tracker and audit tooling                     |
| Monitoring    | `observability-rg`          | Log Analysis, Monitoring, Event Management             |
| Management    | `management-plane-rg`       | Platform management services                           |
| Workloads     | `workload-rg`               | Application runtimes (VSI, VPC, Kubernetes, OpenShift) |
| Edge Services | `edge-rg`                   | Cloud Internet Services, DNS, CDN                      |
| DevOps Tools  | `devops-tools-rg`           | Toolchain, Continuous Delivery, Tekton Pipelines       |

**Note:** If you supply a single resource‑group name, all categories will use that group instead.

**Tip:** Parent deployable architectures automatically map resources to the correct group when this structure is enabled.

**Important:** Every group name and the overall layout are fully customisable (see advanced options below).

---

## Deploy with Cloud automation for Key Protect (advanced)

You can tailor the resource‑group configuration to meet your needs. The options below are listed in the order you will most often use them.

### 1 · Create multiple **new** resource groups (default)

1. Edit **Cloud automation for Key Protect** ➜ **Optional** tab.
2. Ensure `single_resource_group_name` is `null`.
3. Provide custom names for any of the following variables:

   * `security_resource_group_name`
   * `audit_resource_group_name`
   * `observability_resource_group_name`
   * `management_resource_group_name`
   * `workload_resource_group_name`
   * `edge_resource_group_name`
   * `devops_resource_group_name`
4. Click **Save**.

### 2 · Re‑use **existing** resource groups

1. Edit **Cloud automation for Key Protect** ➜ **Optional** tab.
2. Ensure `single_resource_group_name` is `null`.
3. For each group you want to reuse, set the group name and set the matching `use_existing_*_resource_group` flag to `true`.
4. Click **Save**.

### 3 · Mix new and existing groups

Need a hybrid? For example, create a new *security* group while re‑using an existing *audit* group.

1. Edit **Cloud automation for Key Protect** ➜ **Optional** tab.
2. Set `single_resource_group_name` to `null`.
3. Configure `security_resource_group_name` and leave `use_existing_security_resource_group = false`.
4. Configure `audit_resource_group_name` and set `use_existing_audit_resource_group = true`.
5. Click **Save**.

### 4 · Use one **existing** resource group for everything

1. Edit **Cloud automation for Key Protect** ➜ **Optional** tab.
2. Set `single_resource_group_name` to the name of the existing resource group you want to use.
3. Set `use_existing_single_resource_group` to `true`.
4. Click **Save**.

### 5 · Use one **new** resource group for everything

1. Edit **Cloud automation for Key Protect** ➜ **Optional** tab.
2. Set `single_resource_group_name` to the new group name you want to create.
3. Click **Save**.

**Note:** When you deploy with a single resource group (options 4 or 5), All other resource group names will be ignored. The deployable architecture still produces outputs for every resource‑group category, but all outputs will contain the same group name.

---

For a complete overview, see the [Cloud automation for Account Configuration](https://github.com/terraform-ibm-modules/terraform-ibm-account-infrastructure-base/tree/main/docs/about.md).
