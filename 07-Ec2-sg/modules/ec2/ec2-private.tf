#Private instance host

module "ec2_private" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "5.8.0"
  count                  = length(var.private_subnet_ids)
  name                   = "${var.prefix}-private-vm-${count.index + 1}"
  ami                    = data.aws_ami.os-ami.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data              = file("${path.module}/../scripts/user-data.sh")
  vpc_security_group_ids = [var.private_security_group_id]
  subnet_id              = var.private_subnet_ids[count.index]
  tags                   = var.common_tags
}