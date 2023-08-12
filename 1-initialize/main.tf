provider "aws" {
  region = "us-west-2"
}
resource "aws_s3_bucket" "terraform_state" {
  bucket = "hansenites-terraform-state"
  tags ={
    Name = "Terraform Tracking state"
  }
}

resource "aws_s3_bucket_versioning" "versioning_terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}