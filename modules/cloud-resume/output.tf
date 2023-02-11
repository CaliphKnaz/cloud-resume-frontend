output "bucket-name" {
  value = aws_s3_bucket.resume-bucket.bucket
}

output "bucket-endpoint" {
  value = aws_s3_bucket.resume-bucket.website_endpoint
}

