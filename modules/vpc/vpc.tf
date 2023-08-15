variable "master" {}
variable "infa" {}

resource "aws_vpc" "resource-vpc" {
  cidr_block                       = var.infa.vpc_cidr_block
  # enable_classiclink               = "false"
  # enable_classiclink_dns_support   = "true"
  enable_dns_hostnames             = "true"
  enable_dns_support               = "true"
  instance_tenancy                 = "default"

  tags = {
    Name = "${var.infa.lane}-${var.master.company}-VPC"
  }

  tags_all = {
    Name = "${var.infa.lane}-${var.master.company}-VPC"
  }
}
##when adding a new vpc a default security group is added.  Need to find a way for it to not auto attatch to that SG
#resource "aws_security_group" "default-vpc" {
#  name        = "default ${var.infa.lane}-${var.master.company}-VPC"
#  description = "default VPC security group for ${var.infa.lane}-${var.master.company} "
#  vpc_id      = aws_vpc.resource-vpc.id
#
#   egress {
#    from_port        = 0
#    to_port          = 0
#    protocol         = "-1"
#    cidr_blocks      = ["0.0.0.0/0"]
#    ipv6_cidr_blocks = ["::/0"]
#  }
#
#  tags = {
#    Name = "default ${var.infa.lane}-${var.master.company}-VPC"
#  }
#}

resource "aws_internet_gateway" "resource_igw" {
  tags = {
    Name = "${var.infa.lane}-${var.master.company}-GW"
  }

  tags_all = {
    Name = "${var.infa.lane}-${var.master.company}-GW"
  }

  vpc_id = aws_vpc.resource-vpc.id
}


output "my_vpc" {
  value = aws_vpc.resource-vpc
}
output "my_main_route_table" {
  value = aws_vpc.resource-vpc.default_route_table_id
}

output "my_igw" {
  value = aws_internet_gateway.resource_igw
}