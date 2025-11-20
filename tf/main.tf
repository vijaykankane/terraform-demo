module "my_ec2" {
    source = "./modules/ec2"
    ami_id = "ami-00d8fc944fb171e29"
    instance_type = "t3.micro"
    sg_ids = [module.security_group.sg_id]
    instance_name = "vijay-instance-01"
}

module "security_group" {
    source = "./modules/sg"
}

module "vpc" {
    source = "./modules/vpc"
    vpc_name = "vijay_vpc"
    vpc_cidr = "10.0.0.0/24"
}