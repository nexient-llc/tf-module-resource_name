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

output "lower_case" {
  value       = local.lower_case
  description = "Name of the resource in lower case."
}

output "lower_case_without_any_separators" {
  value       = local.lower_case_without_any_separators
  description = "Name of the resource in lower case without any separators. Will remove any separators present in any fields as well."
}

output "lower_case_with_separator" {
  value       = local.lower_case_with_separator
  description = "Name of the resource with lower case and separator. If separator is not provided by user, then '-' character will be used as a separator."
}

output "upper_case" {
  value       = local.upper_case
  description = "Name of the resource in upper case."
}

output "upper_case_without_any_separators" {
  value       = local.upper_case_without_any_separators
  description = "Name of the resource in upper case without any separators. Will remove any separators present in any fields as well."
}

output "upper_case_with_separator" {
  value       = local.upper_case_with_separator
  description = "Name of the resource in upper case and separator. If separator is not provided by user, then '-' character will be used as a separator."
}

output "standard" {
  value       = local.standard
  description = "Name of the resource as per pre-determined recommended naming convention that is join each field with the provided separator"
}

output "recommended_per_length_restriction" {
  value       = local.recommended_per_length_restriction
  description = <<EOF
    Name of the resource that fits the maximum length restriction criteria specified by the user.
    Returns standard else camel_case_without_any_separators else minimal_without_any_separators until it
    satisfies the maximum_length requirements

  EOF
}

output "camel_case" {
  value       = local.camel_case
  description = "Name of the resource in camel case."
}

output "camel_case_without_any_separators" {
  value       = local.camel_case_without_any_separators
  description = "Name of the resource in camel case. Will remove any separators present in any fields as well."
}

output "camel_case_with_separator" {
  value       = local.camel_case_with_separator
  description = "Name of the resource in camel case and separator. If separator is not provided by user, then '-' character will be used as a separator."
}

output "minimal" {
  value       = local.minimal
  description = "Name of the resource would exclude region, instance_resource"
}

output "minimal_random_suffix" {
  value       = local.minimal_random_suffix
  description = "Name of the resource would exclude region, instance_resource and append a random number suffix. This supports max_length restriction"
}

output "dns_compliant_minimal" {
  value       = local.dns_compliant_minimal
  description = "Name is minimal and DNS complaint, that is it can contain only -."
}

output "dns_compliant_standard" {
  value       = local.dns_compliant_standard
  description = "Name is standard and DNS complaint, that is it can contain only -."
}

output "dns_compliant_minimal_random_suffix" {
  value       = local.dns_compliant_minimal_random_suffix
  description = "Name is minimal_random_suffix and DNS complaint, that is it can contain only -."
}
