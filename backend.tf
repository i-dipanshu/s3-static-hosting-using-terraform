terraform {
  backend "s3" {
    bucket = "terraform-central-backend"
    key    = "state_files"
    region = "us-east-2"
  }
}
