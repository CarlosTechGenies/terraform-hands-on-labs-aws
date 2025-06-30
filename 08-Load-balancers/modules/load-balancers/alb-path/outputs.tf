################################################################################
# ALB based on path routing
################################################################################

output "id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb_path.id
}

output "arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb_path.arn
}

output "arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = module.alb_path.arn_suffix
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb_path.dns_name
}

output "zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = module.alb_path.zone_id
}

# Listener(s)

output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb_path.listeners
  sensitive   = true
}

output "listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.alb_path.listener_rules
  sensitive   = true
}

# Target Group(s)

output "target_groups" {
  description = "Map of target groups created and their attributes"
  value       = module.alb_path.target_groups
}

# Security Group

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.alb_path.security_group_arn
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.alb_path.security_group_id
}
