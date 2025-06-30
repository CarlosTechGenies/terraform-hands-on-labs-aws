#Private-instance b2c
output "ec2_private_b2c_id" {
  description = "A list of the IDs of the private instances"
  value       = [for ec2private in module.ec2_private_b2c : ec2private.id]
}
output "ec2_private_b2c_public_ip" {
  description = "A list of private IP address assigned to the private instances"
  value       = [for ec2private in module.ec2_private_b2c : ec2private.private_ip]
}
output "ec2_private_b2c_tags_all" {
  description = "A list of maps of tags assigned to the private instances"
  value       = [for ec2private in module.ec2_private_b2c : ec2private.tags_all]
}
