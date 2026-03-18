#------------------------------------------------------------------------------
# General Configuration
#------------------------------------------------------------------------------

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name of the ops0 project"
  type        = string
}

variable "conversation_id" {
  description = "ops0 conversation ID for resource tracking"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

#------------------------------------------------------------------------------
# Network Configuration
#------------------------------------------------------------------------------

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "availability_zones" {
  description = "List of availability zones for subnet placement"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

#------------------------------------------------------------------------------
# EKS Cluster Configuration
#------------------------------------------------------------------------------

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]*$", var.cluster_name))
    error_message = "Cluster name must start with a letter and contain only letters, numbers, and hyphens."
  }
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.28"
}

variable "cluster_log_types" {
  description = "List of control plane logging types to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

#------------------------------------------------------------------------------
# EKS Node Group Configuration
#------------------------------------------------------------------------------

variable "node_instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "t3.small"
}

variable "node_disk_size" {
  description = "Disk size in GB for EKS worker nodes"
  type        = number
  default     = 20

  validation {
    condition     = var.node_disk_size >= 20 && var.node_disk_size <= 100
    error_message = "Node disk size must be between 20 and 100 GB."
  }
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 3

  validation {
    condition     = var.node_desired_size >= 1 && var.node_desired_size <= 10
    error_message = "Desired size must be between 1 and 10."
  }
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1

  validation {
    condition     = var.node_min_size >= 1
    error_message = "Minimum size must be at least 1."
  }
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 5

  validation {
    condition     = var.node_max_size >= 1 && var.node_max_size <= 20
    error_message = "Maximum size must be between 1 and 20."
  }
}