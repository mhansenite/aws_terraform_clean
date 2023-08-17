# output user_list {
#   value = local.user_list
# }
# output group_list {
#   value = local.group_list
# }

# output  user_group_flat {
#   value = local.user_group_flat
# }

# output user_group_map {
#   value = local.user_group_map
#   }

# output policy_list {
#   value = local.policy_list
# }

# output  policy_group_flat {
#   value = local.policy_group_flat
# }

# output policy_group_map {
#   value = local.policy_group_map
#   }

# output role_policy_flat {
#   value = local.role_policy_flat
#   }
# output role_policy_map {
#   value = local.role_policy_map
#   }

subnet_build=merge([for k, v in local.subnet_az :{for v1 in v: v1.subnet_az_key => v1}]... )


subnet_build={for k, v in local.subnet_az : k => { subnet_az={for k, v in local.subnet_flat : k => { 
        
        for k1,v1 in v.availability_zones: k1 => {
            "name"=v.name,
            "subnet_key"="${v.vpc_key}-${k1}",
            "subnet_zones"=v.subnet_zones,
            "availability_zones"=v1, 
            "vpc_key"=v.vpc_key,
            "workspace"=v.workspace,
            "vpc_cidr" = v.vpc_cidr,
            "cidr"=cidrsubnet(v.vpc_cidr,8,k1)
            }
        }

    }