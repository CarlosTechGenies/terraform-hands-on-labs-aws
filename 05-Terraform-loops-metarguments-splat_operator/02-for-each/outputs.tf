#outputs

output "instance_public_ip" {
  description = "EC2 instance public IP"
  #value       = aws_instance.dev-ohio-vm-map.*.public_ip
  value = toset([for instance in aws_instance.dev-ohio-vm-map : instance.public_ip])
}

output "instance_public_dns1" {
  description = "EC2 instance public DNS"
  #value       = aws_instance.dev-ohio-vm-map[*].public_dns
  value = toset([for instance in aws_instance.dev-ohio-vm-map : instance.public_dns])
}

output "instance_public_dns2" {
  description = "EC2 instance public DNS using tomap"
  value       = tomap({ for az, instance in aws_instance.dev-ohio-vm-map : az => instance.public_dns })
}