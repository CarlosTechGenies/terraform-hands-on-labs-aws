# AWS EC2 Instance - bastion

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

variable "bastion_subnet_id" {
  description = "Subnet ID for the bastion instance"
  type        = string
}

variable "bastion_security_group_id" {
  description = "Security Group ID for the bastion instance"
  type        = string
}