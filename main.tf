// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "random_integer" "random_number" {
  min = 1000000000
  max = 9999999999
}

locals {
  logical_product_family  = trimspace(var.logical_product_family)
  logical_product_service = trimspace(var.logical_product_service)
  region                  = var.use_azure_region_abbr ? lookup(local.azure_region_abbr_map, lower(trimspace(var.region)), trimspace(var.region)) : join("", split("-", trimspace(var.region)))
  class_env               = trimspace(var.class_env)
  cloud_resource_type     = trimspace(var.cloud_resource_type)

  instance_resource = format("%03d", var.instance_resource)
  instance_env      = format("%03d", var.instance_env)


  azure_region_abbr_map = {
    eastus         = "eus"
    westus         = "wus"
    eastus2        = "eus2"
    westus2        = "wus2"
    centralus      = "cus"
    northcentralus = "ncus"
    southcentralus = "scus"
    westcentralus  = "wcus"
  }


  variable_list = [
    local.logical_product_family,
    local.logical_product_service,
    local.region,
    local.class_env,
    local.instance_env,
    local.cloud_resource_type,
    local.instance_resource
  ]

  minimal_variable_list = [
    local.logical_product_family,
    local.logical_product_service,
    local.class_env,
    local.instance_env,
    local.cloud_resource_type
  ]

}

locals {
  lower_case = lower(join("", local.variable_list))
  # will remove any -,_,. present in any of the fields
  lower_case_without_any_separators = replace(local.lower_case, "/[-_.]{1}/", "")
  lower_case_with_separator         = lower(join(var.separator, local.variable_list))
}

locals {
  upper_case = upper(join("", local.variable_list))
  # will remove any -,_,. present in any of the fields
  upper_case_without_any_separators = replace(local.upper_case, "/[-_.]{1}/", "")
  upper_case_with_separator         = upper(join(var.separator, local.variable_list))
}

locals {
  minimal_random_variable_list = [local.logical_product_family, local.logical_product_service, random_integer.random_number.id]
  standard                     = lower(join(var.separator, local.variable_list))
  # will remove any . or _ with a -. We don't want . as it will be parsed as unintended subdomains.
  dns_compliant_standard         = replace(local.standard, "/[-_.]{1}/", "-")
  minimal                        = lower(join(var.separator, local.minimal_variable_list))
  minimal_without_any_separators = replace(local.minimal, "/[-_.]{1}/", "")
  # Appends a 10 digit random number to the local.minimal and then trims it from the right until its under maximum_length limit.
  minimal_random_suffix               = trimsuffix(substr(lower(join(var.separator, local.minimal_random_variable_list)), 0, tonumber(var.maximum_length) - 1), var.separator)
  dns_compliant_minimal               = replace(local.minimal, "/[-_.]{1}/", "-")
  dns_compliant_minimal_random_suffix = replace(local.minimal_random_suffix, "_", "-")
}

locals {
  variable_list_in_camel_case = [
    title(local.logical_product_family),
    title(local.logical_product_service),
    title(local.region),
    title(local.class_env),
    title(local.instance_env),
    title(local.cloud_resource_type),
    title(local.instance_resource)
  ]

  camel_case                        = join("", local.variable_list_in_camel_case)
  camel_case_without_any_separators = replace(local.camel_case, "/[-_.]{1}/", "")
  camel_case_with_separator         = join(var.separator, local.variable_list_in_camel_case)
}

locals {
  length_of_camel_case_without_any_separators = length(local.camel_case_without_any_separators)

  # if length(local.standard) < var.maximum_length -> output: local.standard
  # else if length(local.camel_case_without_any_separators) < var.maximum_length -> output: local.camel_case_without_any_separators
  # else -> output: local.minimal_without_any_separators
  recommended_per_length_restriction = length(local.standard) > var.maximum_length ? local.length_of_camel_case_without_any_separators > var.maximum_length ? local.minimal_without_any_separators : local.camel_case_without_any_separators : local.standard

}
