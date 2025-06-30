#Private instance host for b2b service

module "ec2_private_b2b" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "5.8.0"
  count                  = length(var.private_subnet_ids)
  name                   = "${var.prefix}-b2b-vm-${count.index + 1}"
  ami                    = var.ami_ubuntu_id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data              = file("${path.module}/../../scripts/b2b.sh")
  vpc_security_group_ids = [var.private_security_group_id]
  subnet_id              = var.private_subnet_ids[count.index]
  tags                   = var.common_tags
}