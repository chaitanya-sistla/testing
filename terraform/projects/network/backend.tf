terraform {
  backend "s3" {
    bucket         = "ops0-test-12345"
    key            = "tf/ops0/network/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
