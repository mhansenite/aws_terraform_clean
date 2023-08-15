variable "permissions" {}

#use modules and outputs to have a single master variable that we can call
module "variables" {
  source = "../configs/variables"
}
provider "aws" {
  region = module.variables.master.region
}

terraform {
  backend "s3" {
    bucket = "hansenites-terraform-state"
    key    = "terraform.tfstate"
    region = "us-west-2"
    # profile = "housio"
    encrypt = true
  }
}



module "iam" {
    source = "../modules/iam"
    master=module.variables.master
    permissions=var.permissions
  
}

module "vpc" {
  source = "../modules/vpc"
  master=  module.variables.master
  
}
