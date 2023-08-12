provider "aws" {
  region = "us-west-2"
}

locals{
    AWS_Region="us-west-2"
    AWS_BucketName="hansenites-terraform-state" # only lowercase alphanumeric characters and hyphens allowed
    Terraform_Workspaces=["dev","tst","stg","uat","prd"] #only lowercase alphanumeric characters and hyphens allowed
    AWS_s3_PolicyPath="../configs/policies/terraform_s3_state.json"

}
resource "aws_s3_bucket" "terraform_state" {
  bucket = local.AWS_BucketName
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
resource "aws_s3_object" "workspace_subFolders" {
  for_each = toset(local.Terraform_Workspaces)
    bucket = aws_s3_bucket.terraform_state.id
    key    = "${each.value}/"
    source = "/dev/null"
    acl    = "private"
    tags = {
      Name        = "tracking Terraform state for ${each.value} do not delete this unless you know what it does."
      Workspace = "${each.value}"
    }
}
