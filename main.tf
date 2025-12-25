module "network" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  subnet_id         = element(module.network.public_subnet_ids, 0)
  security_group_id = module.security.security_group_id
}

output "web_public_ip" {
  value = module.ec2.public_ip
}

