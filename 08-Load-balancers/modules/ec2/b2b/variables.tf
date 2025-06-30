# AWS EC2 Instance Terraform Variables

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type        = string
  default     = "dev-ohio-learning-kp"
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "ami_ubuntu_id" {
  description = "AMI id for instance"
  type        = string
}

variable "common_tags" {
  description = "Common tags for resources"
  type        = map(string)
  default     = {}
}

variable "private_subnet_ids" {
  description = "List of Subnet IDs for the private instances"
  type        = list(string)
}

variable "private_security_group_id" {
  description = "Security Group ID for the private instances"
  type        = string
}