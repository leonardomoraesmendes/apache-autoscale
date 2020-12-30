resource "aws_s3_bucket" "S3" {
  acl    = "private"

  tags = {
    Name = "S3-${var.name}"
  }

}

resource "aws_s3_bucket_object" "UPLOAD" {
  key        = "s3.html"
  bucket     = aws_s3_bucket.S3.id
  source     = "${path.module}/provision/s3.html"
}