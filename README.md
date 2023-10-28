# tf_module_resource_name

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module generates the name of cloud resources in different formats as specified below. For the product_family `demo_org`, product_service `test_backend`, environment `dev` and cloud resource `acr`
```
# Outputs
camel_case = "Demo_orgTest_backendUseast2Dev000Acr000"
camel_case_with_separator = "Demo_org-Test_backend-Useast2-Dev-000-Acr-000"
camel_case_without_any_separators = "DemoorgTestbackendUseast2Dev000Acr000"
dns_compliant_minimal = "demo-org-test-backend-dev-000-acr"
dns_compliant_minimal_random_suffix = "demo-org-test-backend-9349499394"
lower_case = "demo_orgtest_backenduseast2dev000acr000"
lower_case_with_separator = "demo_org-test_backend-useast2-dev-000-acr-000"
lower_case_without_any_separators = "demoorgtestbackenduseast2dev000acr000"
minimal = "demo_org-test_backend-dev-000-acr"
minimal_random_suffix = "demo_org-test_backend-9349499394"
recommended_per_length_restriction = "demo_org-test_backend-useast2-dev-000-acr-000"
standard = "demo_org-test_backend-useast2-dev-000-acr-000"
upper_case = "DEMO_ORGTEST_BACKENDUSEAST2DEV000ACR000"
upper_case_with_separator = "DEMO_ORG-TEST_BACKEND-USEAST2-DEV-000-ACR-000"
upper_case_without_any_separators = "DEMOORGTESTBACKENDUSEAST2DEV000ACR000"

```

## Pre-Commit hooks
[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly
- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below
```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.
- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```
- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitgnore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target
- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_integer.random_number](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | n/a | yes |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | (Required) The location where the resource will be created. Must not have spaces<br>    For example, us-east-2, useast2, West-US-2 | `string` | n/a | yes |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | n/a | yes |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_cloud_resource_type"></a> [cloud\_resource\_type](#input\_cloud\_resource\_type) | (Required) Abbreviation for the type of resource. For ex. 'rg' for Azure Resource group. | `string` | n/a | yes |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_maximum_length"></a> [maximum\_length](#input\_maximum\_length) | Number that represents the maximum length the resource name could have. | `number` | `60` | no |
| <a name="input_separator"></a> [separator](#input\_separator) | Separator to be used in the name | `string` | `"-"` | no |
| <a name="input_use_azure_region_abbr"></a> [use\_azure\_region\_abbr](#input\_use\_azure\_region\_abbr) | Whether to use Azure region abbreviation e.g. eastus -> eus | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lower_case"></a> [lower\_case](#output\_lower\_case) | Name of the resource in lower case. |
| <a name="output_lower_case_without_any_separators"></a> [lower\_case\_without\_any\_separators](#output\_lower\_case\_without\_any\_separators) | Name of the resource in lower case without any separators. Will remove any separators present in any fields as well. |
| <a name="output_lower_case_with_separator"></a> [lower\_case\_with\_separator](#output\_lower\_case\_with\_separator) | Name of the resource with lower case and separator. If separator is not provided by user, then '-' character will be used as a separator. |
| <a name="output_upper_case"></a> [upper\_case](#output\_upper\_case) | Name of the resource in upper case. |
| <a name="output_upper_case_without_any_separators"></a> [upper\_case\_without\_any\_separators](#output\_upper\_case\_without\_any\_separators) | Name of the resource in upper case without any separators. Will remove any separators present in any fields as well. |
| <a name="output_upper_case_with_separator"></a> [upper\_case\_with\_separator](#output\_upper\_case\_with\_separator) | Name of the resource in upper case and separator. If separator is not provided by user, then '-' character will be used as a separator. |
| <a name="output_standard"></a> [standard](#output\_standard) | Name of the resource as per pre-determined recommended naming convention that is join each field with the provided separator |
| <a name="output_recommended_per_length_restriction"></a> [recommended\_per\_length\_restriction](#output\_recommended\_per\_length\_restriction) | Name of the resource that fits the maximum length restriction criteria specified by the user.<br>    Returns standard else camel\_case\_without\_any\_separators else minimal\_without\_any\_separators until it<br>    satisfies the maximum\_length requirements |
| <a name="output_camel_case"></a> [camel\_case](#output\_camel\_case) | Name of the resource in camel case. |
| <a name="output_camel_case_without_any_separators"></a> [camel\_case\_without\_any\_separators](#output\_camel\_case\_without\_any\_separators) | Name of the resource in camel case. Will remove any separators present in any fields as well. |
| <a name="output_camel_case_with_separator"></a> [camel\_case\_with\_separator](#output\_camel\_case\_with\_separator) | Name of the resource in camel case and separator. If separator is not provided by user, then '-' character will be used as a separator. |
| <a name="output_minimal"></a> [minimal](#output\_minimal) | Name of the resource would exclude region, instance\_resource |
| <a name="output_minimal_random_suffix"></a> [minimal\_random\_suffix](#output\_minimal\_random\_suffix) | Name of the resource would exclude region, instance\_resource and append a random number suffix. This supports max\_length restriction |
| <a name="output_dns_compliant_minimal"></a> [dns\_compliant\_minimal](#output\_dns\_compliant\_minimal) | Name is minimal and DNS complaint, that is it can contain only -. |
| <a name="output_dns_compliant_minimal_random_suffix"></a> [dns\_compliant\_minimal\_random\_suffix](#output\_dns\_compliant\_minimal\_random\_suffix) | Name is minimal\_random\_suffix and DNS complaint, that is it can contain only -. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
