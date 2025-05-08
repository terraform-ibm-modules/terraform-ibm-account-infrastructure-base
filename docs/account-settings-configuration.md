# Account Settings Configuration

This document provides detailed guidance on how to customize the IBM Cloud **Account Settings** when using **Cloud automation for Key Protect**. These settings enhance security, access control, and compliance alignment across your IBM Cloud account.

Account settings are applied when you choose the **Resource groups with Account Settings** variation.

---

## Overview

This deployable architecture configures the following:

* IAM account security policies
* Context‑Based Restriction (CBR) zones
* A trusted profile for use with IBM Cloud Projects

These settings follow IBM Cloud best practices and are particularly relevant for organizations working in regulated environments such as the [IBM Cloud for Financial Services (FS Cloud)](https://cloud.ibm.com/docs/framework-financial-services?topic=framework-financial-services-about).

---

## IAM Account Settings

The following settings can be controlled using input parameters:

| Setting                              | Description                                                       |
| ------------------------------------ | ----------------------------------------------------------------- |
| `mfa`                                | Configure multifactor authentication (None, Federated Users, All) |
| `user_mfa`                           | Set MFA policies specific to individual users                     |
| `restrict_create_apikey`             | Restrict API‑key creation (on/off)                                |
| `restrict_create_service_id`         | Restrict Service‑ID creation (on/off)                             |
| `session_expiration_seconds`         | Session activity timeout (seconds)                                |
| `session_inactivity_timeout_seconds` | Session inactivity timeout (seconds)                              |
| `access_token_expiration`            | Access‑token lifetime (seconds)                                   |
| `refresh_token_expiration`           | Refresh‑token lifetime (seconds)                                  |
| `allowed_ip_addresses`               | Restrict access to specific IP subnets or addresses               |
| `ip_restriction_mode`                | `monitor` (log) or `enforce` (block) traffic outside allowed IPs  |
| `enable_public_access_group`         | Enable or disable the public access group                         |
| `global_shell_settings`              | Enable or disable global shell access (on/off)                    |

---

## Context‑Based Restrictions (CBRs)

This deployable architecture can create predefined CBR zones and rules to secure access based on network context. CBRs ensure that only requests from approved networks or services can reach sensitive resources.

To configure or extend these rules:

* Adjust the list of zones and rules via input variables
* Consult the [FS Cloud CBR sub‑module documentation](https://github.com/terraform-ibm-modules/terraform-ibm-cbr-fscloud) for advanced scenarios

---

## Trusted Profile for Projects

By default, the deployable architecture creates a **Trusted Profile** and associated **Access Group** that grant controlled access to IBM Cloud Projects. These identities are useful for DevOps pipelines, automation, or platform administrators.

You can customize:

* The trusted‑profile name
* Whether the profile is created
* The IAM policies applied to it

---

## Customization Steps

To customize account settings:

1. Open your **IBM Cloud Project**
2. Locate the **Cloud automation for Key Protect** configuration
3. Click **Edit**
4. Select the **Optional** tab
5. Update any IAM‑related input parameters (see table above)
6. Click **Save** to apply your changes

These options allow you to tailor account governance to meet your organization’s security policies and compliance needs.

---

For a high‑level overview, see the [Cloud automation for Key Protect README](./about.md)
