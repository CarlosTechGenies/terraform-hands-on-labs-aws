#EC2 Outputs 

#Bastion-host
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


#Private-instance
output "ec2_private_id" {
  description = "A list of the IDs of the private instances"
  value       = [for ec2private in module.ec2_private : ec2private.id]
}
output "ec2_private_public_ip" {
  description = "A list of private IP address assigned to the private instances"
  value       = [for ec2private in module.ec2_private : ec2private.private_ip]
}
output "ec2_private_tags_all" {
  description = "A list of maps of tags assigned to the private instances"
  value       = [for ec2private in module.ec2_private : ec2private.tags_all]
}
