#outputs

output "output_list" {
  description = "List of outputs"
  value       = [for instance in aws_instance.dev-ohio-vm-list : instance.public_dns]
}

output "output_map" {
  description = "Map of outputs"
  value       = { for instance in aws_instance.dev-ohio-vm-map : instance.id => instance.public_dns }
}

output "output_map_advance" {
  description = "Map of outputs advanced"
  value       = { for i, instance in aws_instance.dev-ohio-vm-map : i => instance.public_dns }
}

output "output_legacy_splat_operator" {
  description = "Legacy splat operator way"
  value       = aws_instance.dev-ohio-vm-list.*.public_dns
}

output "output_splat_operator" {
  description = "Splat operator way"
  value       = aws_instance.dev-ohio-vm-list[*].public_dns
}