#------------------------------------------------------------------------------
# EC2 Instance Configuration
#------------------------------------------------------------------------------

variable "project_name" {
  description = "Name of the project (used for resource naming)"
  type        = string
}

variable "conversation_id" {
  description = "ops0 conversation ID (used for resource tracking)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"

  validation {
    condition     = !can(regex("^(p2\\.|p3\\.|p4\\.|g4\\.)", var.instance_type))
    error_message = "GPU instance types (p2, p3, p4, g4) are not allowed without approval."
  }
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "enable_detailed_monitoring" {
  description = "Enable detailed CloudWatch monitoring"
  type        = bool
  default     = true
}

variable "root_volume_type" {
  description = "Type of root volume (gp3, gp2, io1, io2)"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "Size of root volume in GB"
  type        = number
  default     = 20
}

#------------------------------------------------------------------------------
# Network Configuration
#------------------------------------------------------------------------------

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to launch the instance in"
  type        = string
}

variable "ssh_cidr_block" {
  description = "CIDR block allowed to SSH into the instance (replace with your IP)"
  type        = string
  default     = "10.0.0.0/8"
}

variable "http_cidr_block" {
  description = "CIDR block allowed to access HTTP port"
  type        = string
  default     = "10.0.0.0/8"
}

variable "https_cidr_block" {
  description = "CIDR block allowed to access HTTPS port"
  type        = string
  default     = "10.0.0.0/8"
}

#------------------------------------------------------------------------------
# Tags
#------------------------------------------------------------------------------

variable "additional_tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}