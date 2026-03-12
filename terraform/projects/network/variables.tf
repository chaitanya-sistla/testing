#------------------------------------------------------------------------------
# VPC Variables
#------------------------------------------------------------------------------

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "region" {
  description = "AWS region for VPC deployment"
  type        = string

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1}$", var.region))
    error_message = "Region must be a valid AWS region format (e.g., us-west-1)."
  }
}

#------------------------------------------------------------------------------
# Project Variables
#------------------------------------------------------------------------------

variable "project_name" {
  description = "Name of the project (used for resource naming)"
  type        = string
}

variable "conversation_id" {
  description = "ops0 conversation ID (used for resource tracking)"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}