terraform {
  backend "s3" {
    bucket = "backend-state-file"
    key    = "tf_state"
    region = "us-east-1"
  }
}
