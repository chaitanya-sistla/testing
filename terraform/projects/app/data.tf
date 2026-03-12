data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "ops0-test-12345"
    key    = "tf/ops0/network/terraform.tfstate"
    region = "us-east-1"
  }
}
