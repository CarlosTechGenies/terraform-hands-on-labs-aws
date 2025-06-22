variable "vpc_id" {
  description = "The ID of the VPC where security groups will be created"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC for security group rules"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "prefix" {
  description = "Prefix for all resources in the poroject"
  type        = string
} 