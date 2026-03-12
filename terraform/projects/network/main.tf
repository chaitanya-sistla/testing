#------------------------------------------------------------------------------
# VPC Configuration
#------------------------------------------------------------------------------

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    {
      Name       = "${var.project_name}-vpc"
      ManagedBy  = "ops0"
      ManagedIaC = "opentofu"
    },
    var.common_tags
  )
}