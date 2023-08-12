
locals{    
master = {
    region = "us-west-2"
    convention="hansenites"
}


}
output "master" {
    value = local.master
}

