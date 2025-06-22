#EIP for bastion host
resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_bastion]
  domain     = "vpc"
  tags = merge(var.common_tags, {
    Name = "${var.prefix}-bastion-eip"
  })
}

# Association of EIP with the EC2 Bastion instance
resource "aws_eip_association" "bastion_eip_assoc" {
  instance_id   = module.ec2_bastion.id
  allocation_id = aws_eip.bastion_eip.id
}

resource "null_resource" "destroy_time_logger" {
  # This resource has no effect on its own, it's just a host for the provisioner.
  # We depend on the EIP so this is triggered when the EIP is destroyed.
  depends_on = [aws_eip.bastion_eip]

  # local-exec provisioner (Destroy-Time Provisioner - Triggered during deletion of Resource)
  provisioner "local-exec" {
    command     = "Add-Content -Path 'destroy-time.txt' -Value \"Destroy infrastructure on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')\""
    working_dir = "local-exec-outputs-files/"
    when        = destroy
    interpreter = ["PowerShell", "-Command"]
    # on_failure = continue
  }
}