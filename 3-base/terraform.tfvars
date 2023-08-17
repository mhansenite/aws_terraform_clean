#vpcs are specified with the whole /16 zone.  10.<vpc>.0.0/16 
#standards to follow  10.<vpc>.<avilability zone>.0/24 vpc octet is the the octet set by the vpc for the given env
#Zone-1 is a 1  10.0.1.0  Zone-2 is 2  10.0.2.0 and so on 

vpcs = [
    
    {
    workspace="dev"
    subnet_zones={1="App", 2="DB",4="mikes"}# needs to have the #= the # sets the 3rd octet
    # availability_zones=["a","c"] 
    tag_purpose="NonProd Testing"
    vpc_cidr_block = "10.1.0.0/16"
    },
    {
    workspace="dev"
    subnet_zones={1="App",2="DB",3="admin"}
    # availability_zones=["a","c"]
    tag_purpose="Testing environment for QA"
    vpc_cidr_block = "10.2.0.0/16"
    }
]


permissions = {
    ############################################################################
    # Accounts are dependant on each other .. so if you leave the 
    # /account blank and they try to assign an account to a group it will fail 
    ############################################################################
    #to disable/enable
    iam_groups_users_enabled=false
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
    iam_policies_enabled="false"
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
    iam_roles_enabled="false"
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
    iam_aws_policies_enabled="false"
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