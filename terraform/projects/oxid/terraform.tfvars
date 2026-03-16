# CRITICAL: ops0 Configuration - DO NOT MODIFY
conversation_id = "f94208b3-ff36-49a4-82dc-907aa5bd738c"

# General Configuration
project_name = "my-eks-project"
region       = "ap-south-1"

common_tags = {
  Environment = "production"
  Project     = "eks-cluster"
  ManagedBy   = "ops0"
  ManagedIaC  = "terraform"
}

# Network Configuration
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["ap-south-1a", "ap-south-1b"]

# EKS Cluster Configuration
cluster_name       = "my-eks-cluster"
kubernetes_version = "1.28"
cluster_log_types  = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

# EKS Node Group Configuration
node_instance_type = "t3.small"
node_disk_size     = 20
node_desired_size  = 3
node_min_size      = 1
node_max_size      = 5