output "lower_case" {
  value       = local.lower_case
  description = "Name of the resource with lower case."
}

output "lower_case_with_separator" {
  value       = local.lower_case_with_separator
  description = "Name of the resource with lower case and separator. If separator is not provided by user, then '-' character will be used as a separator."
}

output "upper_case" {
  value       = local.upper_case
  description = "Name of the resource with upper case."
}

output "upper_case_with_separator" {
  value       = local.upper_case_with_separator
  description = "Name of the resource with upper case and separator. If separator is not provided by user, then '-' character will be used as a separator."
}

output "standard" {
  value       = local.standard
  description = "Name of the resource as per pre-determined recommended naming convention."
}

output "recommended_per_length_restriction" {
  value       = local.recommended_per_length_restriction
  description = "Name of the resource that fits the maximum length restriction criteria specified by the user."
}

output "camel_case" {
  value       = local.camel_case
  description = "Name of the resource in camel case."
}

output "camel_case_with_separator" {
  value       = local.camel_case_with_separator
  description = "Name of the resource in camel case and separator. If separator is not provided by user, then '-' character will be used as a separator."
}

