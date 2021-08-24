resource "aws_s3_bucket" "Angular" {
  bucket = "vabbucket123"
  acl    = "public-read"

  tags = {
    Name        = "Angular"
    Environment = "Dev"

  }
}

