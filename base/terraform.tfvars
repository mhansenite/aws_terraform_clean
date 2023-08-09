master = {
    region = "us-west-2"
    convention="hansenites"

}

permissions = {
    ############################################################################
    # Accounts are dependant on each other .. so if you leave the 
    # /account blank and they try to assign an account to a group it will fail 
    ############################################################################
    #to disable/enable
    iam_groups_users_enabled=true
    #Groups and accounts to create and assign 
        iam_groups_users=[        
        {
            user="mike"
            groups = ["admin","developer","base"]
        },
        {
            user="sean"
            groups =["admin","base"]
        },
        {
            user="brett"
            groups =["developer","base"]
        },
        {
            user="jason"
            groups =["developer","base"]
        },
        {
            user="svc"
            groups =["system","base"]
        }
        ]
    

    ############################################################################
    #assign policies to groups... dependant on iam_groups_users above
    #should have a policy.json file in policies directory named the same as the policy name
    #to disable/enable
    iam_policies_enabled="true"
    iam_policies=[
            {
                name="admin_s3_policy"
                groups=["admin","system"]
            },
            {
                name="dev_s3_policy"
                groups=["developer"]
            }
    ]
    
    ############################################################################
    #Create roles
    #should habe a policy.json file in roles directory named the same as the role name
    #to disable/enable
    iam_roles_enabled="true"
    iam_roles=[
            {
                name="ecs_task_execution_role"
                groups=["admin","system"]
                aws_policies=["AmazonECSTaskExecutionRolePolicy"]
            },
            {
                name="lambda_execution_role"
                groups=["system"]
                aws_policies=["AWSLambdaBasicExecutionRole"]
                
            }
    ]
    ############################################################################    
    #assign aws policies to groups. dependant on iam_groups_users above
    #to disable/enable
    iam_aws_policies_enabled="true"
    iam_aws_policies=[
        {
            group="base"
            policies=["IAMUserChangePassword"]
        },
        {
            group="admin"
            policies=["AdministratorAccess"]
        },
       {
            group="developer"
            policies=["CloudWatchLogsFullAccess"]
        }
    ]

}