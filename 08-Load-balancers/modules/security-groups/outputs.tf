# Public Bastion Host Security Group Outputs
output "public_bastion_sg_group_id" {
  description = "The ID of the security group"
  value       = module.public_bastion_sg.security_group_id
}
output "public_bastion_sg_group_vpc_id" {
  description = "The VPC ID"
  value       = module.public_bastion_sg.security_group_vpc_id
}
output "public_bastion_sg_group_name" {
  description = "The name of the security group"
  value       = module.public_bastion_sg.security_group_name
}


# Private EC2 Instances Security Group Outputs
output "private_sg_group_id" {
  description = "The ID of the security group"
  value       = module.private_sg.security_group_id
}
output "private_sg_group_vpc_id" {
  description = "The VPC ID"
  value       = module.private_sg.security_group_vpc_id
}
output "private_sg_group_name" {
  description = "The name of the security group"
  value       = module.private_sg.security_group_name
}

# CLB security groups outputs

output "clb_sg_group_id" {
  description = "The ID of the security group for CLB"
  value       = module.clb_sg.security_group_id
}

output "clb_sg_group_vpc_id" {
  description = "The VPC ID"
  value       = module.clb_sg.security_group_vpc_id
}

output "clb_sg_group_name" {
  description = "The name of the security group"
  value       = module.clb_sg.security_group_name
}

# ALB security groups outputs

output "alb_sg_group_id" {
  description = "The ID of the security group for CLB"
  value       = module.alb_sg.security_group_id
}

output "alb_sg_group_vpc_id" {
  description = "The VPC ID"
  value       = module.alb_sg.security_group_vpc_id
}

output "alb_sg_group_name" {
  description = "The name of the security group"
  value       = module.alb_sg.security_group_name
}