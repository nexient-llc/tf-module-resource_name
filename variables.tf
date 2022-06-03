variable "logical_product_name" {
  type        = string
  description = "(Required) Name of the application for which the resource is created."
  nullable    = false

  validation {
    condition     = length(trimspace(var.logical_product_name)) <= 15 && length(trimspace(var.logical_product_name)) > 0
    error_message = "Length of the logical product name must be between 1 to 15 characters."
  }
}

variable "region" {
  type        = string
  description = "(Required) The location where the resource will be created."
  nullable    = false

  validation {
    condition     = length(trimspace(var.region)) <= 10 && length(trimspace(var.region)) > 0
    error_message = "Length of the region must be between 1 to 10 characters."
  }


  validation {
    condition     = length(regexall("\\b \\b", var.region)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For ex. dev, qa, uat"
  nullable    = false

  validation {
    condition     = length(trimspace(var.class_env)) <= 15 && length(trimspace(var.class_env)) > 0
    error_message = "Length of the environment must be between 1 to 15 characters."
  }

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 1 to 999."
  }
}

variable "cloud_resource_type" {
  type        = string
  description = "(Required) Abbreviation for the type of resource. For ex. 'rg' for Azure Resource group."
  nullable    = false

  validation {
    condition     = length(trimspace(var.cloud_resource_type)) <= 8 && length(trimspace(var.cloud_resource_type)) > 0
    error_message = "Length of the cloud_resource_type must be between 1 to 8 characters."
  }

  validation {
    condition     = length(regexall("\\b \\b", var.cloud_resource_type)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 1 to 100."
  }
}

variable "maximum_length" {
  type        = number
  description = "Number that represents the maximum length the resource name could have."
  default     = 60

  validation {
    condition     = var.maximum_length >= 24 && var.maximum_length <= 512
    error_message = "Maximum length number should be between 24 to 512."
  }
}

variable "separator" {
  type        = string
  description = "Separator to be used in the name"
  default     = "-"

  validation {
    condition     = length(trimspace(var.separator)) == 1
    error_message = "Length of the separator must be 1 character."
  }

  validation {
    condition     = length(regexall("[._-]", var.separator)) > 0
    error_message = "Only '.', '_', '-' are allowed as separator."
  }
}



