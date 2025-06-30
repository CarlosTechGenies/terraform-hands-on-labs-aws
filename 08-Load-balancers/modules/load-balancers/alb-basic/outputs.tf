################################################################################
# ALB without ASG
################################################################################

output "id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb_without_asg.id
}

output "arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb_without_asg.arn
}

output "arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = module.alb_without_asg.arn_suffix
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb_without_asg.dns_name
}

output "zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = module.alb_without_asg.zone_id
}

# Listener(s)

output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb_without_asg.listeners
  sensitive   = true
}

output "listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.alb_without_asg.listener_rules
  sensitive   = true
}

# Target Group(s)

output "target_groups" {
  description = "Map of target groups created and their attributes"
  value       = module.alb_without_asg.target_groups
}

# Security Group

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.alb_without_asg.security_group_arn
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.alb_without_asg.security_group_id
}
