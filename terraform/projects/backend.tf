terraform {
  backend "s3" {
    bucket                      = "bucket-20260227-1431"
    key                         = "product/tofu.tfstate"
    region                      = "us-sanjose-1"
    endpoint                    = "https://axib01nrrzob.compat.objectstorage.us-sanjose-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}
