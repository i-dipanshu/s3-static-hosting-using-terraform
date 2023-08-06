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

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = templatefile("s3_bucket_policy.json", { bucket = var.BUCKET_NAME })
}
