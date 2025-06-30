# variables for clb

variable "prefix" {
  description = "Prefix for all resources in the poroject"
  type        = string
}

variable "vpc_id" {
  description = "CDIR block of VPC for security group of CLB"
  type        = string
}

variable "common_tags" {
  description = "Tags mandatory for resource group"
  type        = map(string)
  default     = {}
}

variable "public_subnets_ids" {
  description = "Publicsubnets attached to load balancer"
  type        = list(string)
}

variable "clb_sg_id" {
  description = "clb sg id"
  type        = string
}

variable "private_instance_count" {
  description = "count of instances"
  type        = number
}

variable "ec2_private_ids" {
  description = "Ids of instances attached to the load balancer"
  type        = list(string)
}