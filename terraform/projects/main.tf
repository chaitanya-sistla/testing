#------------------------------------------------------------------------------
# Provider Configurations
#------------------------------------------------------------------------------
provider "aws" {
  region = var.region
}

#------------------------------------------------------------------------------
# Data Sources
#------------------------------------------------------------------------------
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

#------------------------------------------------------------------------------
# Security Group
#------------------------------------------------------------------------------
resource "aws_security_group" "oracle_test" {
  name        = "oracle-test-sg"
  description = "Security group for oracle-test instance"

  # SSH access from restricted CIDR (update with your IP range)
  ingress {
    description = "SSH from restricted network"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "oracle-test-sg"
    ManagedBy  = "ops0"
    ManagedIaC = "terraform"
  }
}

#------------------------------------------------------------------------------
# EC2 Instance
#------------------------------------------------------------------------------
resource "aws_instance" "oracle_test" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.oracle_test.key_name

  vpc_security_group_ids = [aws_security_group.oracle_test.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name       = "oracle-test"
    ManagedBy  = "ops0"
    ManagedIaC = "terraform"
  }
}
