#------------------------------------------------------------------------------
# EC2 Instance Configuration
#------------------------------------------------------------------------------

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

#------------------------------------------------------------------------------
# Local Values
#------------------------------------------------------------------------------

locals {
  common_tags = {
    ManagedBy   = "ops0"
    ManagedIaC  = "opentofu"
    Project     = var.project_name
    Environment = var.environment
  }
  
  name_prefix = "${var.project_name}-${var.environment}"
}

#------------------------------------------------------------------------------
# Data Sources
#------------------------------------------------------------------------------

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get available subnets in the VPC
data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.terraform_remote_state.network.outputs.vpc_id]
  }
}

#------------------------------------------------------------------------------
# Security Group
#------------------------------------------------------------------------------

resource "aws_security_group" "ec2_instance" {
  name_prefix = "${local.name_prefix}-ec2-"
  description = "Security group for EC2 instance"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-ec2-sg"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

#------------------------------------------------------------------------------
# SSH Key Pair
#------------------------------------------------------------------------------

resource "aws_key_pair" "ec2_key" {
  key_name   = "${local.name_prefix}-key"
  public_key = var.ssh_public_key

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-key"
    }
  )
}

#------------------------------------------------------------------------------
# EC2 Instance
#------------------------------------------------------------------------------

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.vpc_subnets.ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_instance.id]
  key_name               = aws_key_pair.ec2_key.key_name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_volume_size
    encrypted             = true
    delete_on_termination = true
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from ops0 EC2 Instance</h1>" > /var/www/html/index.html
              EOF

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-ec2"
    }
  )
}
