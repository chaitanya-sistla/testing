#------------------------------------------------------------------------------
# IAM Role Configuration
#------------------------------------------------------------------------------

variable "role_name" {
  description = "Name of the IAM role"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9+=,.@_-]+$", var.role_name))
    error_message = "Role name must contain only alphanumeric characters and +=,.@_-"
  }
}

variable "policy_name" {
  description = "Name of the IAM policy"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9+=,.@_-]+$", var.policy_name))
    error_message = "Policy name must contain only alphanumeric characters and +=,.@_-"
  }
}

variable "trusted_services" {
  description = "List of AWS services that can assume this role"
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
}

variable "trusted_principals" {
  description = "List of AWS account principals that can assume this role (optional)"
  type        = list(string)
  default     = []
}

#------------------------------------------------------------------------------
# ops0 Configuration
#------------------------------------------------------------------------------

variable "conversation_id" {
  description = "ops0 conversation ID for resource tracking"
  type        = string
}