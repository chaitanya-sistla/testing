#------------------------------------------------------------------------------
# Region Configuration
#------------------------------------------------------------------------------
variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-west-2"
}

#------------------------------------------------------------------------------
# Instance Configuration
#------------------------------------------------------------------------------
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = can(regex("^t[2-3]\\.(nano|micro|small|medium)", var.instance_type))
    error_message = "Instance type must be a small burstable instance (t2/t3 nano, micro, small, or medium)."
  }
}

#------------------------------------------------------------------------------
# Network Configuration
#------------------------------------------------------------------------------
variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH to the instance (update with your IP range)"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0))
    error_message = "Must be a valid IPv4 CIDR block."
  }
}

#------------------------------------------------------------------------------
# ops0 Configuration
#------------------------------------------------------------------------------
variable "project_name" {
  description = "Name of the ops0 project (used for secret naming)"
  type        = string
  default     = "oracle-test"
}

variable "conversation_id" {
  description = "ops0 conversation ID for resource tracking"
  type        = string
}
