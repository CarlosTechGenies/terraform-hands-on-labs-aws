# Create VPC using module
module "vpc" {
  source = "./modules/vpc"

  # Passing variables FROM root TO module
  vpc_name             = var.vpc_name
  vpc_cidr_block       = var.vpc_cidr_block
  vpc_azs              = var.vpc_availability_zones
  vpc_private_subnets  = var.vpc_private_subnets
  vpc_public_subnets   = var.vpc_public_subnets
  vpc_database_subnets = var.vpc_database_subnets

  vpc_create_database_subnet_group       = var.vpc_create_database_subnet_group
  vpc_create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  vpc_enable_nat_gateway                 = var.vpc_enable_nat_gateway
  vpc_single_nat_gateway                 = var.vpc_single_nat_gateway

  # Passing computed values from locals
  prefix      = local.prefix
  common_tags = local.common_tags
}

# Create Security Groups using module
module "security_groups" {
  source = "./modules/security-groups"

  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
  common_tags    = local.common_tags
  prefix         = local.prefix
}

# Create EC2 Instances using module
module "ec2_instances" {
  source = "./modules/ec2"

  # From locals
  prefix      = local.prefix
  common_tags = local.common_tags

  # From variables
  instance_type    = var.instance_type
  instance_keypair = var.instance_keypair

  # From vpc module - Per diagram, bastion is in a public subnet, and private instances in private subnets
  bastion_subnet_id  = module.vpc.public_subnets[0]
  private_subnet_ids = module.vpc.private_subnets

  # From security_groups module
  bastion_security_group_id = module.security_groups.public_bastion_sg_group_id
  private_security_group_id = module.security_groups.private_sg_group_id
}

