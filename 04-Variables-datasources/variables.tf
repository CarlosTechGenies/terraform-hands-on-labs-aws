# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-2"
}

#  EC2 Instance Type
variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
  sensitive   = true
}

#  EC2 Instance key pair
variable "instance_keypair" {
  description = "The key pair to use for the EC2 instance"
  type        = string
  default     = "dev-ohio-learning-kp"
}

# My IP address
variable "my_ip" {
  description = "My IP address"
  type        = string
  default     = "179.15.74.88/32"
}


