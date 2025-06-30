# EC2 instance - Bastion
output "ec2_bastion_instance_id" {
  description = "The ID of the instance Bastion"
  value       = module.ec2_bastion.id
}
output "ec2_bastion_public_ip" {
  description = "The public IP address assigned to the bastion instance via EIP"
  value       = aws_eip.bastion_eip.public_ip
}
output "ec2_bastion_tags_all" {
  description = "A map of tags assigned to the resource"
  value       = module.ec2_bastion.tags_all
}