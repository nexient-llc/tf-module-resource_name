locals {
  logical_product_name = trimspace(var.logical_product_name)
  region               = trimspace(var.region)
  class_env            = trimspace(var.class_env)
  cloud_resource_type  = trimspace(var.cloud_resource_type)

  instance_resource = format("%03d", var.instance_resource)
  instance_env      = format("%03d", var.instance_env)

  variable_list = [local.logical_product_name, local.region, local.class_env, local.instance_env, local.cloud_resource_type, local.instance_resource]
}

locals {
  lower_case                = lower(join("", local.variable_list))
  lower_case_with_separator = lower(join(var.separator, local.variable_list))
}

locals {
  upper_case                = upper(join("", local.variable_list))
  upper_case_with_separator = upper(join(var.separator, local.variable_list))
}

locals {
  standard = lower(join("-", local.variable_list))
}

locals {
  variable_list_without_product_name           = [local.region, local.class_env, local.instance_env, local.cloud_resource_type, local.instance_resource]
  length_of_variable_list_without_product_name = length(join("", local.variable_list_without_product_name))

  # If standard output length if greater than maximum length provided by user, then output for the user is created using maximum length specified by the user.
  # For that strip off region from the output. Also restrict the logical_product_name so that total length of the output is same as maximum length.
  recommended_per_length_restriction = length(local.standard) > var.maximum_length ? format("%s%s%s%s%s",
    substr(local.logical_product_name, 0, var.maximum_length - local.length_of_variable_list_without_product_name),
    local.class_env,
    local.instance_env,
    local.cloud_resource_type,
  local.instance_resource) : local.standard

}

locals {
  variable_list_in_camel_case = [title(local.logical_product_name),
    title(local.region),
    title(local.class_env),
    title(local.instance_env),
    title(local.cloud_resource_type),
  title(local.instance_resource)]

  camel_case                = join("", local.variable_list_in_camel_case)
  camel_case_with_separator = join(var.separator, local.variable_list_in_camel_case)
}


