variable master {}
variable permissions {}

provider "aws" {
  region = "${var.master.region}"
}

module "iam" {
    source = "../modules/iam"
    master=var.master
    permissions=var.permissions
  
}


# module "assign_policies" {
#   count=var.permissions.iam_create_assign_policies == "true" ? 1 : 0
#     source = "../modules/iam/create_assign_policies"
#     master=var.master
#     permissions=var.permissions
#     depends_on = [ module.users_groups ]
# }

# module "assign_aws_policies" {
#   count=var.permissions.iam_assign_aws_policies == "true" ? 1 : 0
#     source = "../modules/iam/assign_aws_policies"
#     master=var.master
#     permissions=var.permissions
#     depends_on = [ module.users_groups ]
# }

# module "create_assign_roles" {
#   count=var.permissions.iam_create_assign_roles == "true" ? 1 : 0
#     source = "../modules/iam/create_assign_roles"
#     master=var.master
#     permissions=var.permissions
# }



# locals {

#     # Get each posssible user
#     user_list = [for k,v in var.permissions.iam_groups_users[*].user: "${v}"]
#     # Get each possible Group
#     group_list = distinct(flatten([for k,v in var.permissions.iam_groups_users[*].groups: "${v}"]))
#     #flatten the variables and map each group to each user
#     user_group_flat=[for k, v in var.permissions.iam_groups_users:{for k1,v1 in v.groups: k1 =>{"group" = v1, "user" = v.user, "enable" = v.enable} } ]
#     user_group_map=merge([for k,v in local.user_group_flat : { for v1 in v :"${k}-${v1.group}" => v1 }]...) 


#  }

#  resource "null_resource" "strengths" {
#   for_each = { for k, v in local.user_group_map : k => v if var.permissions.iam_assign_users_and_groups } 
#   triggers = {
#     group  = each.value.group
#     user = each.value.user
#     enabled = each.value.enable
#   }
# }

# output "strengths" {
#   value = null_resource.strengths
# }



# output myflat {
#   value = local.user_group_flat
# }
# output myMap {
#   value = local.user_group_map
# }

# output myUsers {
#   value = local.user_list
# }

# output myGroups {
#   value = local.group_list
#   }

# output child_format {

# value = local.child_format 
# }

# output parent_format {
# value = local.parent_format 
# }


# output child_map {
# value = local.child_map 
# }

# output parent_map {
# value = local.parent_map 
# }

# output final_map {
# value = local.final_map
# }

