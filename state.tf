terraform {
  backend "s3" {
    shared_credentials_file = "/home/mayank/.aws/creds_t"
    bucket = "kproject-1"
    key = "state/terraform.tfstate"
    region = "ap-south-1"
  }
}