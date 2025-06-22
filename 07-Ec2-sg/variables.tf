variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "name_region" {
  description = "Name AWS Region where resources will be created"
  type        = string
  default     = "virginia"
}

variable "environment" {
  description = "Environment name (dev, stg, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "stg", "prod"], var.environment)
    error_message = "Environment must be dev, stg, or prod."
  }
}

variable "customer" {
  description = "Customer/Client name"
  type        = string
}

# VPC Variables (que vas a pasar al módulo)
variable "vpc_name" {
  description = "Name to be used on all VPC resources as identifier"
  type        = string
  default     = "vpc"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_availability_zones" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
}

variable "vpc_database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list(string)
}

variable "vpc_create_database_subnet_group" {
  description = "Controls if database subnet group should be created"
  type        = bool
  default     = true
}

variable "vpc_create_database_subnet_route_table" {
  description = "Controls if database subnet route table should be created"
  type        = bool
  default     = true
}

variable "vpc_enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways"
  type        = bool
  default     = true
}

variable "vpc_single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway"
  type        = bool
  default     = true
}

# EC2 Instance Variables
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_keypair" {
  description = "Name of the EC2 key pair to use for the instances"
  type        = string
  default     = "dev-ohio-learning-kp" # Please replace with your key pair name
}