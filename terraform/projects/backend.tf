terraform {
  backend "s3" {
    bucket                      = "bucket-20260224-1534"
    key                         = "oracle/terraform.tfstate"
    region                      = "us-sanjose-1"
    endpoint                    = "https://axib01nrrzob.compat.objectstorage.us-sanjose-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}
