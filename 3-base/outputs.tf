output user_list {
  value = module.iam.user_list
}
output group_list {
  value = module.iam.group_list
}

output  user_group_flat {
  value = module.iam.user_group_flat
}

output user_group_map {
  value = module.iam.user_group_map
  }

output policy_group_list {
  value = module.iam.policy_list
}

output  policy_group_flat {
  value = module.iam.policy_group_flat
}

output policy_group_map {
  value = module.iam.policy_group_map
  }
output role_policy_flat {
  value = module.iam.role_policy_flat
  }
output role_policy_map {
  value = module.iam.role_policy_map
  }
output "vpc_map" {
    value = module.vpc_subnets.vpc_map
}
output "app_subnet_map" {
    value = module.vpc_subnets.app_subnet_map
}
output "db_subnet_map" {
    value = module.vpc_subnets.db_subnet_map
}
