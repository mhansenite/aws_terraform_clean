
provider "aws" {
  region = module.variables.master.region
}

terraform {
  backend "s3" {
    bucket = "hansenites-terraform-state"
    key    = "app1/terraform.tfstate"
    region = "us-west-2"
    # profile = "awscliprofile"
    encrypt = true
  }
}

#use modules and outputs to have a single master variable that we can call
module "variables" {
  source = "../../configs/variables"
}

variable "app" {}


module "ecr" {
  source = "../../modules/ecr"
  env= "${terraform.workspace}"
  master=module.variables.master
  app_name= var.app.name
}

