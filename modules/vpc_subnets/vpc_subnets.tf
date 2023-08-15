variable "master" {}
variable "vpc_subnets" {}


locals {
      # Get each posssible vpc
    vpc_map = {for k,v in var.vpc_subnets : v.name => v.vpc_cidr_block }
    # policy_list = [for k,v in var.permissions.iam_policies[*].name: "${v}"]
    #flatten the variables and map each group to each policy
    app_subnet_map=[for k, v in var.vpc_subnets:{for k1,v1 in v.app_subnet_zones: k1 =>{"subnet" = v1, "name" = v.name} } ]
    # app_subnet_map = merge([for k,v in local.policy_group_flat : { for v1 in v :"${k}-${v1.group}" => v1 }]...)
    
    
    
    db_subnet_map = {for k,v in var.vpc_subnets : v.name => v.vpc_cidr_block }
}



resource "aws_vpc" "resource-vpc" {
for_each = local.vpc_map 
  cidr_block                       = each.value
  # enable_classiclink               = "false"
  # enable_classiclink_dns_support   = "true"
  enable_dns_hostnames             = "true"
  enable_dns_support               = "true"
  instance_tenancy                 = "default"

  tags = {
    Name = "${each.key}-${var.master.convention}-VPC"
  }

  tags_all = {
    Name = "${each.key}-${var.master.convention}-VPC"
  }
}

resource "aws_internet_gateway" "resource_igw" {
  for_each = local.vpc_map
  vpc_id = aws_vpc.resource-vpc[each.key].id
  tags = {
    Name = "${each.key}-${var.master.convention}-GW"
  }

  tags_all = {
    Name = "${each.key}-${var.master.convention}-GW"
  }
  
}


resource "aws_subnet" "resource_subnet" {
  for_each = local.app_subnet_map
  availability_zone = "${var.master.region}${var.infa.subnets_app[count.index].avl_zone}"
  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = var.infa.subnets_app[count.index].cidr_block
  #cidr_block                                     = each.value.cidr_block
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  map_public_ip_on_launch                        = "false"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name = "${var.infa.lane}-${var.master.company}-${var.infa.subnets_app[count.index].name}-SN"
    #Name = "${var.infa.lane}-${var.master.company}-${each.value.name}-SN"
  }

  tags_all = {
    Name = "${var.infa.lane}-${var.master.company}-${var.infa.subnets_app[count.index].name}-SN"
    #Name = "${var.infa.lane}-${var.master.company}-${each.value.name}-SN"
  }

  vpc_id = var.my_vpc.id
  
}

# output "my_subnets_app" {
#   value = aws_subnet.resource_subnet_app[*].id
# }

# resource "aws_subnet" "resource_subnet_db" {
#   count = length(var.infa.subnets_db)
#   availability_zone = "${var.master.region}${var.infa.subnets_app[count.index].avl_zone}"
#   assign_ipv6_address_on_creation                = "false"
#   cidr_block                                     = var.infa.subnets_db[count.index].cidr_block
#   #cidr_block                                     = each.value.cidr_block
#   enable_resource_name_dns_a_record_on_launch    = "false"
#   enable_resource_name_dns_aaaa_record_on_launch = "false"
#   map_public_ip_on_launch                        = "false"
#   private_dns_hostname_type_on_launch            = "ip-name"

#   tags = {
#     Name = "${var.infa.lane}-${var.master.company}-${var.infa.subnets_db[count.index].name}-SN"
#     #Name = "${var.infa.lane}-${var.master.company}-${each.value.name}-SN"
#   }

#   tags_all = {
#     Name = "${var.infa.lane}-${var.master.company}-${var.infa.subnets_db[count.index].name}-SN"
#     #Name = "${var.infa.lane}-${var.master.company}-${each.value.name}-SN"
#   }

#   vpc_id = var.my_vpc.id
  
# }


# output "my_subnets_db" {
#   value = aws_subnet.resource_subnet_app[*].id
# }

