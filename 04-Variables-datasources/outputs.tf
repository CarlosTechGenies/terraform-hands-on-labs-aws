# Outputs for ec2 instance

output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.dev-ohio-vm-1.public_ip
  sensitive   = true
}

output "ec2_public_dns" {
  description = "The public DNS name of the EC2 instance"
  value       = aws_instance.dev-ohio-vm-1.public_dns
  sensitive   = true
}

output "ec2_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.dev-ohio-vm-1.id
  sensitive   = true
}