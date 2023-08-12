output "terraform_state_bucket"{
value= resource.aws_s3_bucket.terraform_state.arn
}

output "terraform_workspace_state_buckets"{
    value= resource.aws_s3_object.workspace_subFolders
}