variable "master" {}
variable "env" {}
variable "app_name" {}

resource "aws_ecr_repository" "ecr-repo" {
  name                 = "${var.master.convention}-${var.env}-${var.app_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

}
