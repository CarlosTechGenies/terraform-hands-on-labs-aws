#Bastion host

module "ec2_bastion" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "5.8.0"
  name                   = "${var.prefix}-bastion-vm-1"
  ami                    = var.ami_ubuntu_id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  subnet_id              = var.bastion_subnet_id
  vpc_security_group_ids = [var.bastion_security_group_id]
  tags                   = var.common_tags
}