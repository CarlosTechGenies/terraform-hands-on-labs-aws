# Variables that this module needs received from root
variable "vpc_name" {
  description = "Name to be used on all VPC resources as identifier"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_azs" {
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

# Variables computed from root module
variable "prefix" {
  description = "Name prefix for resources"
  type        = string
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}