#------------------------------------------------------------------------------
# SSH Key Generation and Secret Storage
#------------------------------------------------------------------------------

# Generate SSH key pair
resource "tls_private_key" "oracle_test" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Register public key with AWS
resource "aws_key_pair" "oracle_test" {
  key_name   = "oracle-test-key"
  public_key = tls_private_key.oracle_test.public_key_openssh

  tags = {
    Name       = "oracle-test-key"
    ManagedBy  = "ops0"
    ManagedIaC = "terraform"
  }
}

# Store private key in AWS Secrets Manager
resource "aws_secretsmanager_secret" "ssh_private_key" {
  name        = "ops0/${var.project_name}/ec2/oracle-test-ssh-key"
  description = "SSH private key for oracle-test EC2 instance managed by ops0"

  tags = {
    "ops0:managed"        = "true"
    "ops0:conversationID" = var.conversation_id
    "ops0:project-name"   = var.project_name
    "ops0:resource"       = "aws_instance.oracle_test"
    "ops0:secret-type"    = "ssh-private-key"
    "ManagedBy"           = "ops0"
    "ManagedIaC"          = "terraform"
  }
}

resource "aws_secretsmanager_secret_version" "ssh_private_key" {
  secret_id     = aws_secretsmanager_secret.ssh_private_key.id
  secret_string = tls_private_key.oracle_test.private_key_pem
}
