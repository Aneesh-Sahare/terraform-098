resource "aws_s3_bucket" "testbucket33" {
  bucket = "aneesh-test-bucket-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 6
  special = false
}
