terraform {
  backend "s3" {
    bucket = "daniellemaywood"
    key    = "terraform.tfstate"
    region = "auto"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true

    endpoints = {
      s3 = "https://6b1f203f12648e063d24e9d81346523c.r2.cloudflarestorage.com"
    }
  }
}
