################################################################################
# ALB based on Host header
################################################################################

output "id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb_host_header.id
}

output "arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb_host_header.arn
}

output "arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = module.alb_host_header.arn_suffix
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb_host_header.dns_name
}

output "zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = module.alb_host_header.zone_id
}

# Listener(s)

output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb_host_header.listeners
  sensitive   = true
}

output "listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.alb_host_header.listener_rules
  sensitive   = true
}

# Target Group(s)

output "target_groups" {
  description = "Map of target groups created and their attributes"
  value       = module.alb_host_header.target_groups
}

# Security Group

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.alb_host_header.security_group_arn
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.alb_host_header.security_group_id
}
