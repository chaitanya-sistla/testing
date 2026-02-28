#------------------------------------------------------------------------------
# IAM Role
#------------------------------------------------------------------------------

resource "aws_iam_role" "read_only" {
  name        = "${var.role_name}"
  description = "IAM role with read-only access to AWS resources"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = var.trusted_services
          AWS     = var.trusted_principals
        }
      }
    ]
  })

  tags = {
    Name       = var.role_name
    ManagedBy  = "ops0"
    ManagedIaC = "opentofu"
  }
}

#------------------------------------------------------------------------------
# IAM Policy - Read Only Access
#------------------------------------------------------------------------------

resource "aws_iam_policy" "read_only" {
  name        = "${var.policy_name}"
  description = "Policy granting read-only access to AWS resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          # EC2 Read-Only
          "ec2:Describe*",
          "ec2:Get*",
          "ec2:List*",
          # S3 Read-Only
          "s3:Get*",
          "s3:List*",
          # RDS Read-Only
          "rds:Describe*",
          "rds:List*",
          # Lambda Read-Only
          "lambda:Get*",
          "lambda:List*",
          # CloudWatch Read-Only
          "cloudwatch:Describe*",
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "logs:Describe*",
          "logs:Get*",
          "logs:List*",
          # IAM Read-Only
          "iam:Get*",
          "iam:List*",
          # VPC Read-Only
          "vpc:Describe*",
          "vpc:Get*",
          "vpc:List*",
          # CloudFormation Read-Only
          "cloudformation:Describe*",
          "cloudformation:Get*",
          "cloudformation:List*"
        ]
        Resource = "*"
      }
    ]
  })

  tags = {
    Name       = var.policy_name
    ManagedBy  = "ops0"
    ManagedIaC = "opentofu"
  }
}

#------------------------------------------------------------------------------
# Policy Attachment
#------------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "read_only" {
  role       = aws_iam_role.read_only.name
  policy_arn = aws_iam_policy.read_only.arn
}