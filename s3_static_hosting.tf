// Creating a new bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.BUCKET_NAME
}


// Enabling static hosting to the above created bucket
resource "aws_s3_bucket_website_configuration" "s3_bucket_config" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }
}


resource "aws_s3_bucket_public_access_block" "mybucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  //ignore_public_acls      = true
  //restrict_public_buckets = true
}