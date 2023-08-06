terraform {
  backend "s3" {
    bucket = "backend-state-file"
    key    = "backend_state_file"
    region = "us-east-1"
  }
}
