#Security group module
module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "${var.prefix}-bastion-sg"
  description = "Security group with public access(IPV4) and ssh from internet"
  vpc_id      = var.vpc_id

  # Ingress Rules & CIDR Blocks
  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow SSH access from anywhere on the internet to the bastion host"
    }
  ]

  # Egress Rules
  egress_rules = ["all-all"]
  tags         = var.common_tags
} 