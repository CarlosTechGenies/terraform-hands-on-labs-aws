#Variables for alb basic

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

variable "alb_sg_id" {
  description = "slb sg id"
  type        = string
}

variable "ec2_private_ids" {
  description = "Ids for attached the instances to tg"
  type        = list(string)
}