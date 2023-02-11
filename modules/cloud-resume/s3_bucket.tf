resource "aws_s3_bucket" "resume-bucket" {
  bucket = var.bucket-name


  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "allow_global_access" {
  bucket = aws_s3_bucket.resume-bucket.id
  policy = file("modules/cloud-resume/public-bucket.json")

}

resource "aws_s3_bucket_website_configuration" "resume-website" {
  bucket = aws_s3_bucket.resume-bucket.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_acl" "resume-assets-acl" {
  bucket = aws_s3_bucket.resume-bucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "resume-assets" {
  bucket = aws_s3_bucket.resume-bucket.bucket
  for_each = fileset("frontend", "*")
  key = each.value

  source = "frontend/${each.value}"
}

resource "aws_s3_bucket_object" "index" {
  bucket = var.bucket-name
  key = "index.html"

  content_type = "text/html"
  source = "frontend/index.html"

  depends_on = [
    aws_s3_bucket.resume-bucket
  ]
}

resource "aws_s3_bucket_object" "style" {
  bucket = var.bucket-name
  key = "style.css"

  content_type = "text/css"
  source = "frontend/style.css"

  depends_on = [
    aws_s3_bucket.resume-bucket
  ]
}

