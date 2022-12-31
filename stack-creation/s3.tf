resource "aws_s3_bucket" "S3Bucket" {
  bucket = var.S3Bucket
  tags = {
    Name = var.S3Bucket
  }
}

resource "aws_s3_bucket_acl" "S3BucketACL" {
  bucket = aws_s3_bucket.S3Bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "S3BucketPublicAccess" {
  bucket = aws_s3_bucket.S3Bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "S3BucketVersioning" {
  bucket = aws_s3_bucket.S3Bucket.id
  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_object" "S3BucketObject" {
  bucket = aws_s3_bucket.S3Bucket.id
  key    = var.S3CodeZip
  source = "../src/${var.S3CodeZip}"
  etag   = filemd5("../src/${var.S3CodeZip}")
}