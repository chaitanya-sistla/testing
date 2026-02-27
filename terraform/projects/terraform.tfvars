# Project Configuration
project_name    = "my-project"
conversation_id = "6b9c49c8-cf69-4be7-b90d-abab89e33f00"

# EC2 Instance Configuration
ami_id        = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 (update for your region)
instance_type = "t3.medium"
key_name      = "my-ec2-keypair"  # Replace with your SSH key name

# Monitoring
enable_detailed_monitoring = true

# Storage
root_volume_type = "gp3"
root_volume_size = 20

# Network Configuration
vpc_id    = "vpc-xxxxxxxxxxxxx"  # Replace with your VPC ID
subnet_id = "subnet-xxxxxxxxxxxxx"  # Replace with your subnet ID

# Security - IMPORTANT: Update these CIDR blocks to restrict access
# Replace 10.0.0.0/8 with your specific IP or VPN CIDR
ssh_cidr_block   = "10.0.0.0/8"  # TODO: Replace with your IP (e.g., "203.0.113.0/24")
http_cidr_block  = "10.0.0.0/8"  # TODO: Update if needed
https_cidr_block = "10.0.0.0/8"  # TODO: Update if needed

# Additional Tags
additional_tags = {
  Environment = "production"
  Owner       = "devops-team"
}