module "vpc" {
  source   = "./modules/vpc"
  name     = "vk-vpc"
  vpc_cidr = var.vpc_cidr
}

module "iam" {
  source = "./modules/iam"
  name   = "vk-vpc"
}

module "ec2" {
  source               = "./modules/ec2"
  name                 = "vk-vpc"
  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_id_0
  private_subnet_id    = module.vpc.private_subnet_id_0
  ami_id               = var.ami_id
  key_name             = var.key_name
  allowed_ssh_cidr     = var.allowed_ssh_cidr
  instance_type_web    = var.instance_type_web
  instance_type_db     = var.instance_type_db
  iam_instance_profile = module.iam.ec2_instance_profile_name
}

module "eks" {
  source = "./modules/eks"
  cluster_name      = var.eks_cluster_name
  cluster_version   = var.eks_cluster_version
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = [module.vpc.private_subnet_id_0, module.vpc.private_subnet_id_1]
  tags              = var.tags
  region            = var.aws_region
  
}