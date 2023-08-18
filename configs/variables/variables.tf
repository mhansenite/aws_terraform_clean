
locals{    
master = {
    region = "us-west-2"
    convention="mysite"
}


}
output "master" {
    value = local.master
}

