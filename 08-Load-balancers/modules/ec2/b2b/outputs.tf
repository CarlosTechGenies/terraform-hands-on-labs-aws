#Private-instance b2b
output "ec2_private_b2b_id" {
  description = "A list of the IDs of the private instances"
  value       = [for ec2private in module.ec2_private_b2b : ec2private.id]
}
output "ec2_private_b2b_public_ip" {
  description = "A list of private IP address assigned to the private instances"
  value       = [for ec2private in module.ec2_private_b2b : ec2private.private_ip]
}
output "ec2_private_b2b_tags_all" {
  description = "A list of maps of tags assigned to the private instances"
  value       = [for ec2private in module.ec2_private_b2b : ec2private.tags_all]
}

