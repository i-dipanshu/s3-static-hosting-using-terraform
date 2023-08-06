terraform {
  backend "s3" {
    bucket = "terraform-central-backend"
    key    = "backend_state_file"
    region = "us-east-1"
  }
}
