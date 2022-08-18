variable "s3bucketname" {}

resource "aws_s3_bucket" "s3bucket" {
  bucket = var.s3bucketname

  tags = {
    Name        = var.s3bucketname
    Environment = "Test"
  }
}

resource "aws_s3_bucket_acl" "s3bucketacl" {
  bucket = aws_s3_bucket.s3bucket.id
  acl    = "private"
}


 output "bucketid" {
    value = aws_s3_bucket.s3bucket.id
 }