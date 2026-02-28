# IAM Role and Policy Configuration
role_name   = "ops0-read-only-role"
policy_name = "ops0-read-only-policy"

# Trusted services that can assume the role
trusted_services = [
  "ec2.amazonaws.com",
  "lambda.amazonaws.com"
]

# Optional: Add AWS account ARNs that can assume the role
# trusted_principals = ["arn:aws:iam::123456789012:root"]
trusted_principals = []

# ops0 Configuration
conversation_id = "03c34051-0a79-43df-b200-3730fada7fee"