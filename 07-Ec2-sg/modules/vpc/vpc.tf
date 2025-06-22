# Create VPC using terraform-aws-modules
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.20.0"

  # VPC Basic Details
  name            = "${var.prefix}-${var.vpc_name}"
  cidr            = var.vpc_cidr_block
  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  # Naming for Public and Private Subnets
  public_subnet_names = [
    for k, v in var.vpc_public_subnets : "${var.prefix}-public-s-${k + 1}"
  ]
  private_subnet_names = [
    for k, v in var.vpc_private_subnets : "${var.prefix}-private-s-${k + 1}"
  ]

  # Database Subnets
  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  database_subnets                   = var.vpc_database_subnets
  database_subnet_names = [
    for k, v in var.vpc_database_subnets : "${var.prefix}-db-s-${k + 1}"
  ]

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  #Naming for Nat Gateway, EIP and IGW
  nat_eip_tags = {
    Name = "${var.prefix}-nat-eip"
  }

  nat_gateway_tags = {
    Name = "${var.prefix}-nat-gateway"
  }

  igw_tags = {
    Name = "${var.prefix}-igw"
  }

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  tags = merge(var.common_tags, {
    Module = "vpc"
  })
}