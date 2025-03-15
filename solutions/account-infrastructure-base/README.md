# IBM Cloud Account Infrastructure Base solution

An end-to-end deployable architecture solution that provisions the following infrastructure:

- A set of resource groups for separation of resources
- A default set of account settings that are compliant with the IBM Cloud for Financial Services framework
- A trusted profile to give access for IBM Cloud Projects to deploy solutions securely in this account
- A set of context-based restriction rules and zones that are compliant with IBM Cloud Framework for Financial Services.

![account-infrastructure-base](https://raw.githubusercontent.com/terraform-ibm-modules/terraform-ibm-account-infrastructure-base/main/reference-architectures/base-account-enterprise.svg)

## Limitations

The solution does not support configuring the following settings that are required for compliance with IBM Cloud for Financial Services:

- The user list visibility IAM setting. An account owner can enable this restriction in the IBM Cloud console by following these [steps](https://cloud.ibm.com/docs/account?topic=account-iam-user-setting).
- The Financial Services Validated setting. An account owner can enable the account to be designated as Financial Services Validated. IBM Cloud for Financial Services Validated designates that an IBM Cloud service or ecosystem partner service has evidenced compliance to the controls of the IBM Cloud Framework for Financial Services and can be used to build solutions that might themselves be validated.

    For more information, see [Enabling your account to use Financial Services Validated products](https://cloud.ibm.com/docs/account?topic=account-enabling-fs-validated).

Tracking issue with IBM provider -> https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4204
